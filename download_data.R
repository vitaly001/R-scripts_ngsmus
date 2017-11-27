setwd('/Users/Vitaly/Desktop/ngsmus')
setwd('/Volumes/HD3/NGS/AML')
#For downloading SRA repository data, an automated process may be desirable. For example, from https://www.ncbi.nlm.nih.gov/sra?term=SRP056315 (the entire experiment corre- sponding to GEO accession GSE18508), users can download a table of the metadata into a comma-separated tabular file “SraRunInfo.csv” (see Supplementary File 1, which contains an archive of various files used in this protocol). To do this, click on “Send to:” (top right corner), select “File”, select format “RunInfo” and click on “Create File”. Read this CSV file “SraRunInfo.csv” into R, and select the subset of samples that we are interested in (using R’s string matching function grep), corresponding to the 22 SRA files

# or you can download the SraRunTable.txt file from link "Send results to Run selector" and download the table.
sri = read.csv("SraRunInfo.csv", stringsAsFactors=FALSE)  #from https://www.ncbi.nlm.nih.gov/sra?term=SRP056315 go to link save results as run selector  and download a table of the metadata into a text tabular file “SraRunTable.txt”. This file should be in working directory

#select rows with data you need, base numbers or treatments 
keep = grep("SRR1919002|SRR1918994|SRR1918864",sri$Run) #select only fiels names with given characters in names (words)

#create datafame with all required data
sri = sri[keep,] #select rows from a table with given numbers
# for second method create vector with URL path to data
#download_path= c('ftp://ftp-trace.ncbi.nih.gov/sra/sra-instant/reads/ByRun/sra/SRR/SRR191/SRR1918864/SRR1918864.sra', 'ftp://ftp-trace.ncbi.nih.gov/sra/sra-instant/reads/ByRun/sra/SRR/SRR191/SRR1918994/SRR1918994.sra', 'ftp://ftp-trace.ncbi.nih.gov/sra/sra-instant/reads/ByRun/sra/SRR/SRR191/SRR1919002/SRR1919002.sra') # create vector with all paths
#and add it to the table as separate column
#sri$download_path=download_path # ad it as column to the sri dataframe
# extract the path from the dataframe and download file to the working directory
fs = basename(sri$download_path)
for (i in 1:nrow(sri))
        download.file(sri$download_path[i], fs[i])
stopifnot( all(file.exists(fs)) )  # assure FTP download was successful
#using sratoolkit split the files to the paired fastq files, in case you have single end files add option -U instead of --split-files

for(f in fs) {
        cmd = paste("fastq-dump --split-files", f) #convert the example data to FASTQ, use the fastq-dump command from the SRA Toolkit on each SRA file.
        cat(cmd,"\n") 
        system(cmd) # invoke command
}
