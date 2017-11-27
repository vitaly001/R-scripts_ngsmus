setwd("/Volumes/HD2/ngsmus")

for(i in seq_len(nrow(samples))) {
        lib = samples$conditions[i]
        print(lib)
        bamFile = file.path(lib, "accepted_hits.bam")
        print(bamFile)
        # sort by name, convert to SAM for htseq-count
        system(paste0("samtools sort -n ",bamFile," ",lib,"_sn"))
        system(paste0("samtools view -o ",lib,"_sn.sam ",lib,"_sn.bam"))
        # sort by position and index for IGV
        system(paste0("samtools sort ",bamFile," ",lib,"_s"))
        system(paste0("samtools index ",lib,"_s.bam"))
}


