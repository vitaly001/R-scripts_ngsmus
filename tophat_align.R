#Align the reads (using tophat2) to reference genome
#Using R string manipulation, construct the Unix commands to call tophat2


gf = "/Volumes/HD2/Homo_sapiens_NCBI_GRCh38/Homo_sapiens/NCBI/GRCh38/Annotation/Genes/genes.gtf"
bowind = "/Volumes/HD2/Homo_sapiens_NCBI_GRCh38/Homo_sapiens/NCBI/GRCh38/Sequence/Bowtie2Index/genome"
transcriptome = "/Volumes/HD2/Homo_sapiens_NCBI_GRCh38/Homo_sapiens/NCBI/GRCh38/Sequence/Bowtie2Index/transcriptome"

for(i in dat_IR$NGS.DNA) {
        w = paste0("/Volumes/HD2/RNA-seq/", i, collapse = '')
        print(w)
        setwd(w)
        print(getwd())
        cmd = paste("tophat -G", gf, "--no-novel-juncs", "-p 7 -o", dat_IR$LibraryName, bowind, dat_IR$fastq) # no novel junction option will save the time

#        cmd = with(dat_IR, paste("tophat -G", gf, "-p 5 -o", LibraryName, bowind, fastq))
        print(cmd)
        for(c in cmd) system(c)
}

        setwd("/Volumes/HD2/RNA-seq/Control_IR")
        print(getwd())
        cmd = with(dat_IR, paste("tophat -G", gf, "-p 5 -o", LibraryName, bowind, fastq))
        cmd
        for(c in cmd) system(c)
