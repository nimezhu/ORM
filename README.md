# ORM
Tools for ORM

## orm_plot
orm_plot is an R function allowing to plot ORM data and replication timing data in an interactive web browser.
- Dependencies: R packages tidyverse and plotly need to be instaled. In R, execute

    install.packages("tidyverse");
    install.packages("plotly")

- Input files:
  orm file: tab separated 4 columns with the feature type, the chr, the start position, the stop position and the id of the fiber. the header must be as in "orm_example.txt":

  RT file: bed file containing the RT in the 4th column, with a header as in "RT_example.txt"

- Usage: In R:
  - load the script:
  
     source("Path/to/script.R")
     
  - Plot using the orm file, the RT file, the chr you want, the start position (0 by default), the stop position (50000000 by defaut):
  
     orm_plot("merge.bed", "RT_HeLaS3_hg19_header.bed", "chr21", 20000000, 50000000)
     
(In this example, the orm file is "merge.bed", the RT file is "RT_HeLaS3_hg19_header.bed" and the starting genomic cooordinates are chr21:20,000,000-50,000,000).

To note: It is absolutly not recommanded to plot larger than 50Mb windows as starting coordinates, it will be too heavy.
