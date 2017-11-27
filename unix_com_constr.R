#Align the reads (using tophat2) to reference genome
#Using R string manipulation, construct the Unix commands to call tophat2
getwd()
setwd("~/Desktop/ngsmus")
samples = read.csv("samples.csv", stringsAsFactors=FALSE)
gf = "~/Desktop/mus_genome/GRCm38.gff"
bowind = "~/Desktop/mus_genome/GRCm38"
cmd = with(samples,
           paste("tophat -G", gf, "-p 4 -o", conditions, bowind,
                 fastq1, fastq2))
cmd
system(cmd) # invoke command
