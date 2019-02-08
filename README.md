# ORM
Tools for ORM

## script for orm file formating
The purpose is to attribute a "y" value to each fiber to allow them to be plotted in a smart manner, wihtout overlap.
The script starts with a ".gtf" file containing fibers and nucleotides data, and a ".bed" file containing the replicating segments. These two files need to have matching names for each sample:
sample_1.gtf and sample_1.bed
sample_2.gtf and sample_2.bed
...

## orm_plot
orm_plot is an R function allowing to plot ORM data from formated files (see script to format the files).
- Input file: tab separated 6 columns with the feature type, the chr, the start position, the stop position, the id of the fiber and the smart y position (see the script to format the files). No header.


- Usage: In R:
  - load the orm file:


    	 dataset<-read.table("orm_file.txt",header=FALSE)

  - load the script:


     	 source("Path/to/script.R")
     
  - Plot using the chromosome you want, the start position (1000000 by default), the stop position (50000000 by defaut), the orm dataset, the features you want to plot (all by defaut):


    	 plot_orm(chr="chr1", start=1000000, stop=50000000, dataset=dataset,Fiber=TRUE,Nucleotide=TRUE,Segment=TRUE)

