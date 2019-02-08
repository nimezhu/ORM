plot_orm<-function(chr="chr1", start=1000000, stop=50000000, dataset=dataset,Fiber=TRUE,Nucleotide=TRUE,Segment=TRUE){


# Extract the parameters for the legend. colors here can be changed, but will be only on the legend, not the plot

Legend=data.frame(names=c("DNA Fiber","Replicating Segment","Higher Fluorescence","Middle Fuorescence", "Lower Fluorescence"),width_line=c(5,3,5,5,5),colors=c("LIGHTGREY","BLACK","RED","ORANGE","GOLD"),values=c(Fiber,Segment,Nucleotide,Nucleotide,Nucleotide))


# Empty plot

plot(0,0,xlim=c(start,stop),ylim=c(min(dataset[which(dataset[,7]>=start & dataset[,6]<=stop & dataset[,2]==chr),8]),max(dataset[which(dataset[,7]>=start & dataset[,6]<=stop & dataset[,2]==chr),8])+5),pch=19,col="white",ylab="",yaxt='n',xlab=paste(chr,"(bp)",sep=" "))


# Plot fibers. To change color, replace "LIGHTGREY" by the color you want (and change it in the legend parameters).

if(Fiber==TRUE){
rect(dataset[which(dataset[,7]>=start & dataset[,6]<=stop & dataset[,2]==chr & dataset[,1]=="Fiber"),3],dataset[which(dataset[,7]>=start & dataset[,6]<=stop & dataset[,2]==chr & dataset[,1]=="Fiber"),8]-0.45,dataset[which(dataset[,7]>=start & dataset[,6]<=stop & dataset[,2]==chr & dataset[,1]=="Fiber"),4],dataset[which(dataset[,7]>=start & dataset[,6]<=stop & dataset[,2]==chr & dataset[,1]=="Fiber"),8]+0.45,col="LIGHTGREY",border=NA)}


# Plot Nucleotides. To change color, replace "c("YELLOW","GOLD","RED")" by the color you want (and change it in the legend parameters: the second on is the "lower fluo", the third one, the higher fluo, and an intermediate color is the middle fluo. The first color is basically for fluo=0 and should not appear).

if(Nucleotide==TRUE){
rect(dataset[which(dataset[,7]>=start & dataset[,6]<=stop & dataset[,2]==chr & dataset[,1]=="Nucleotide"),3]-1000,dataset[which(dataset[,7]>=start & dataset[,6]<=stop & dataset[,2]==chr & dataset[,1]=="Nucleotide"),8]-0.45,dataset[which(dataset[,7]>=start & dataset[,6]<=stop & dataset[,2]==chr & dataset[,1]=="Nucleotide"),3]+1000,dataset[which(dataset[,7]>=start & dataset[,6]<=stop & dataset[,2]==chr & dataset[,1]=="Nucleotide"),8]+0.45,col=colorRampPalette(c("YELLOW","GOLD","RED"))(2000)[ifelse(dataset[which(dataset[,7]>=start & dataset[,6]<=stop & dataset[,2]==chr & dataset[,1]=="Nucleotide"),4]>=2000,2000,ifelse(dataset[which(dataset[,7]>=start & dataset[,6]<=stop & dataset[,2]==chr & dataset[,1]=="Nucleotide"),4]==0,1,dataset[which(dataset[,7]>=start & dataset[,6]<=stop & dataset[,2]==chr & dataset[,1]=="Nucleotide"),4]))],border=NA)}


# Plot Replicating segments. To change color, replace "BLACK" by the color you want (and change it in the legend parameters).

if(Segment==TRUE){
rect(dataset[which(dataset[,7]>=start & dataset[,6]<=stop & dataset[,2]==chr & dataset[,1]=="Segment"),3],dataset[which(dataset[,7]>=start & dataset[,6]<=stop & dataset[,2]==chr & dataset[,1]=="Segment"),8]-0.1,dataset[which(dataset[,7]>=start & dataset[,6]<=stop & dataset[,2]==chr & dataset[,1]=="Segment"),4],dataset[which(dataset[,7]>=start & dataset[,6]<=stop & dataset[,2]==chr & dataset[,1]=="Segment"),8]+0.1,col="BLACK",border=NA)}

# Add a legend, but it can overlap with the data, so sometimes it can just be removed by commenting it (adding a # at the beginning of the line)
legend("topleft",legend=Legend[which(Legend[,4]==TRUE),1],col=as.character(Legend[which(Legend[,4]==TRUE),3]),lty=1,lwd=Legend[which(Legend[,4]==TRUE),2])

return(0)
}