setwd("/Volumes/HD2/ngsmus/Cuffdiff_test")
getwd()
library(cummeRbund)
gf = "/Volumes/HD2/UCSC/mm10/Annotation/Archives/archive-2015-07-17-14-33-26/Genes/genes.gtf"
rm(cuff)
cuff = readCufflinks(gtfFile = gf, genome = 'mm10')
cuff
disp<-dispersionPlot(genes(cuff)) # evaluate the quality of the model fitting
disp
dispersionPlot(cuff) #directly will allow you to visualize the full model fit. 
genes.scv<-fpkmSCVPlot(genes(cuff)) #The squared coefficient of variation is a normalized measure of cross-replicate variability that can be useful for evaluating the quality your RNA-seq data. Differences in CV 2 can result in lower numbers of differentially expressed genes due to a higher degree of variability between replicate fpkm estimates.

isoforms.scv<-fpkmSCVPlot(isoforms(cuff)) 

dens<-csDensity(genes(cuff)) # To assess the distributions of FPKM scores across samples
dens

b<-csBoxplot(genes(cuff))
b
s<-csScatterMatrix(genes(cuff)) # matrix of pairwise scatterplots 
s
v<-csVolcanoMatrix(genes(cuff))
v
runInfo(cuff) #Run-level information such as run parameters, and sample information can be accessed from a CuffSet object by using the runInfo and replicates methods

#Retrive significant gene IDs (XLOC) with a pre-specified alpha

diffGeneIDs <- getSig(cuff,level="genes",alpha=0.05) 
#Use returned identifiers to create a CuffGeneSet object with all relevant info for given genes
diffGenes<-getGenes(cuff,diffGeneIDs)

#gene_short_name values (and corresponding XLOC_* values) can be retrieved from the CuffGeneSet by using:
featureNames(diffGenes)

mySigMat<-sigMatrix(cuff,level='genes',alpha=0.05)
mySigMat

mySigGeneIds<-getSig(cuff,alpha=0.05,level='genes')
length(mySigGeneIds)
NTvsLPS = getSig(cuff, x= "NT", y = "LPS", alpha = 0.05, level = "isoforms")
diffNTvsLPS = getGenes(cuff, NTvsLPS)
featureNames(diffNTvsLPS)
NTvsIL = getSig(cuff, x= "NT", y = "IL4", alpha = 0.05, level = "genes")
myDistHeat<-csDistHeat(genes(cuff))
myDistHeat
myGeneIds = c('Il6', 'Cdkn2a', 'Il4', 'Il1b', 'Mmp2', 'Mmp3', 'Trp53', 'Stat3', 'Stat6', 'Glb1', 'Cdkn2b', 'Il8')
myGenes<-getGenes(cuff,myGeneIds)
head(fpkm(myGenes))
h<-csHeatmap(myGenes,cluster='both')
h
b<-expressionBarplot(myGenes)
b
feature.level <- "genes"
# ... or "isoforms", "TSS", "CDS"
idColumnName <- "gene_id"
# ... or "isoform_id", "TSS_group_id", "CDS_id" to match above
report.name <- paste0('QC.sig_diffExp_', feature.level,'.txt')
# ... or whatever you want

#cuff <- readCufflinks()
sigIDs <- getSig(cuff,level=feature.level,alpha=0.05)
if (NROW(sigIDs) > 0) {
        sigFeatures <- getFeatures(cuff,sigIDs,level=feature.level)
        sigData <- diffData(sigFeatures)
        sigData <- subset(sigData, (significant == 'yes'))
        names <- featureNames(sigFeatures)
        sigOutput <- merge(names, sigData, by.x="tracking_id", 
                           by.y=idColumnName)
        
        # Patch the merged table to have the original name for the ID column.  
        # This is always the first column for the examples we've seen.
        colnames(sigOutput)[1] <- idColumnName
        write.table(sigOutput, report.name, sep='\t', row.names = F, 
                    col.names = T, quote = F)
}
nameID=names$gene_short_name # just to extract gene names
nameID #print it
write.csv(nameID, file='nameID.csv',  eol = "\r", col.names = TRUE)
