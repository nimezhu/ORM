orm_plot <- function(file_orm="merge.bed",file_RT="RT.bed", chrom="chr11",Start=NULL,Stop=NULL){
         if(is.null(Start)){Start=0}
         if(is.null(Stop)){Stop=50000000}
	 min0<-read.table(file_orm,header=TRUE)
	 require(tidyverse)
	 data_1 <- min0 %>% na.omit() %>% group_by(id) %>% mutate(min=min(start), max=max(stop)) %>% ungroup %>% filter(chr==chrom) %>% mutate(Feature = factor(Feature,levels=c("Fiber","BrdU","Segment"))) %>% mutate(id = reorder(id, min))
	 RT<-read.table(file_RT,header=TRUE) %>% mutate(pos=start+((stop-start)/2)) %>% filter(chr==chrom, stop>=Start, start<=Stop)
	 p1 <- data_1 %>% filter(max>=Start, min<=Stop) %>% ggplot() + geom_segment(aes(x=start, xend=stop, y=id, yend=id, col=Feature,size=Feature)) + scale_size_manual("",values=c(1.5,1.5,0.5)) + scale_color_manual("",values=c("LIGHTGREY","BLUE","BLACK")) + ylab("ORM") + xlab(as.vector(data_1$chr[1])) + theme_bw() + theme(axis.text.y=element_blank(),axis.ticks.y=element_blank(),panel.grid.major = element_blank(), panel.grid.minor = element_blank(),panel.background = element_blank()) + scale_x_continuous(labels = scales::comma)
	 p2 <- RT %>% ggplot() + geom_bar(aes(x=pos,y=RT,fill=ifelse(RT<0,"Late","Early")),stat="identity") + scale_x_continuous(labels = scales::comma) + theme(panel.grid.minor = element_blank(),panel.background = element_blank()) + xlab('') + ylab("RT") + coord_cartesian(ylim=c(-2,2)) + scale_fill_manual("",values=c("GREEN","RED"))
	 require(plotly)
	 gg1 <- ggplotly(p1) %>% layout(xaxis=list(tickmode="auto"),yaxis=list(autorange=TRUE,title="ORM"))
	 gg2 <- ggplotly(p2) %>% layout(xaxis=list(tickmode="auto"),yaxis=list(zeroline=TRUE,title="RT"))
	 gg <- subplot(gg2,gg1,nrows=2,shareX=TRUE,heights=c(0.4,0.6))
	 return(gg)
}
