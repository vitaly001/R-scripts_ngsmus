setwd("/Volumes/HD2/ngsmus")
samples = read.csv("samples.csv", stringsAsFactors=FALSE)



for(i in seq_len(nrow(samples))) {
        lib = samples$conditions[i]
        print(lib)
        bamFile = file.path(lib, "accepted_hits.bam")
        print(bamFile)
        system(paste0("nohup cufflinks -L ", lib ," -p 6 ", bamFile," ", " -o", " Cufflinks","/", lib, " >& com.cufflinks.log &"))
        

}


