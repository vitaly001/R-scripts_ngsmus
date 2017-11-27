library("edgeR")
counts = readDGE(samples$countf)$counts
noint = rownames(counts) %in% c("no_feature","ambiguous","too_low_aQual", "not_aligned","alignment_not_unique")
cpms = cpm(counts)
keep = rowSums(cpms>1)>=1 & !noint
counts = counts[keep,]
colnames(counts) = samples$conditions
head( counts[,order(samples$conditions)], 5 )
d = DGEList(counts=counts, group=samples$conditions)
d = calcNormFactors(d)
d$samples
plotMDS(d, labels=samples$conditions,
        col=c("darkgreen","blue")[factor(samples$conditions)])

d = estimateCommonDisp(d)
d = estimateTagwiseDisp(d)
plotMeanVar(d, show.tagwise.vars=TRUE, NBline=TRUE)
plotBCV(d)
de = exactTest(d, pair=c("NT","IL4"))
tt = topTags(de, n=nrow(d))
head(tt$table)
nc = cpm(d, normalized.lib.sizes=TRUE)
rn = rownames(tt$table)
head(nc[rn,order(samples$conditions)],5)
deg = rn[tt$table$FDR < .05]
plotSmear(d, de.tags=deg) #Differentially expressed transcripts are represented by red dots.
abline(h = c(-2, 2), col = "blue")
write.csv(tt$table, file="toptags_edgeR.csv")
