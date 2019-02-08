# Formating the gtf and the bed file to obtain one file with this structure:
#	Feature	chr	start	stop	id
## GTF (fibers and nucleotides) data extraction
for file in *.gtf; do
    echo $file;
    cat $file | awk '//{print $3,"chr"$1,$4,$5,$10}' OFS='\t' | sed 's/\"//g' | sed 's/\;//g' | sed 's/transcript/Fiber/g' | sed 's/exon/Nucleotide/g' > ${file%.gtf}_format.gtf;
done
## BED (segments) data extraction
for file in *.bed; do
    echo $file;
    cat $file | sed 's/Chr/chr/g' | awk '//{print "Segment",$1,$2,$3,"GID"$4}' OFS='\t' > ${file%.bed}_format.bed;
done
## Merge fibers, nucleotides and segements, one feature by line. Attention! This need that the file have corresponding names! (See in the code line).
for file in *_format.bed; do
    cat $file > ${file%_format.bed}_merge.txt;
    cat ${file%_format.bed}_format.gtf >> ${file%_format.bed}_merge.txt;
done

# Sorting the merged file by id (first by chr to make it easy to check for problem, but this is not at this step necessary) to be sure to have all features from the same fiber togethere before pulling them in one line
## Sorting
for file in *_merge.txt; do
    echo $file;
    sort -k2,2 -k5,5 -k1,1 -k3,3n -k4,4n $file > ${file%.txt}_sorted.txt;
done
## Fusion all features from the same fiber on one line
for file in *_merge_sorted.txt; do
    echo $file;
    cat $file | awk 'BEGIN{id="";min=0;max=0} //{if($5==id){printf $0"\t"min"\t"max"\tnewline\t"}; if($5!=id){if(NR!=1){print "_"}; min=$3; max=$4; printf $0"\t"min"\t"max"\tnewline\t"; id=$5}} END{print ""}' | sed 's/	newline	_//g' > ${file%_sorted.txt}_oneline.txt;
done

# Sorting by position to give an intelligent y value for plotting wihtout overlapping each fiber but maximazing the used space
## Sorting
for file in *merge_oneline.txt; do
    echo $file;
    sort -k2,2 -k3,3n -k4,4n $file > ${file%.txt}_sort.txt;
done
## Calculating the best y value
for file in *merge_oneline_sort.txt; do
    echo $file;
    cat $file | awk 'BEGIN{chr=""} //{if($2==chr){i=0; while(tab[i]>=$3 && tab[i]>0){i=i+1}; tab[i]=$4+1; print i"\t"$0} else {chr=$2; i=0; while(tab[i]>0){tab[i]=0; i=i+1}; i=0; while(tab[i]>=$3 && tab[i]>0){i=i+1}; tab[i]=$4+1; print i"\t"$0}}' > ${file%_sort.txt}_y.txt;
done
## Putting back one feature by line, with the y value as a 6th column.
for file in *_merge_oneline_y.txt; do
    echo $file;
    cat $file | awk '//{for(i=2;i<=NF;i=i+8){print $i,$(i+1),$(i+2),$(i+3),$(i+4),$(i+5),$(i+6),$1}}' OFS='\t' > ${file%_oneline_y.txt}_y.txt;
done

# Transforming the stop position of each Nucleotide to a fluorescence value (fluo = stop - start). The script R allow 0 to 2000 as fluorescence arbitrary value. Over 2000, the color will be the same as for 2000.
## Calcul fluo
for file in *_merge_y.txt; do
    echo $file;
    cat $file | awk '!/^Nucleo/{print $0} /^Nucleo/{print $1,$2,$3,$4-$3,$5,$6,$7,$8}' OFS='\t' > ${file%.txt}_nucl.txt;
done
