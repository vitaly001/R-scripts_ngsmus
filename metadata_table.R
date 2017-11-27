sri$Run = gsub("C57BL_","",sri$Run) # trim label
samples = unique(sri[,c("Run","LibraryLayout")])
for(i in seq_len(nrow(samples))) {
        rw = (sri$Run==samples$Run[i])
        if(samples$LibraryLayout[i]=="PAIRED") {
                samples$fastq1[i] = paste0(sri$Run[rw],"_1.fastq",collapse=",")
                samples$fastq2[i] = paste0(sri$Run[rw],"_2.fastq",collapse=",")
        } else {
                samples$fastq1[i] = paste0(sri$Run[rw],".fastq",collapse=",")
                samples$fastq2[i] = ""
        }
}
#Add important or descriptive columns to the metadata table (here, experimental groupings are set based on the “LibraryName” column, and a label is created for plotting)

#add colunm 'conditions' with name of treatment
conditions = c('NT', 'LPS', 'IL4')
samples$conditions = conditions
write.csv(samples, 'samples.csv', row.names = F)

# or use this script if you have multiple conditions
samples$condition = "CTL"
samples$condition[grep("RNAi",samples$LibraryName)] = "KD"
samples$shortname = paste( substr(samples$condition,1,2),
                           substr(samples$LibraryLayout,1,2),
                           seq_len(nrow(samples)), sep=".")
