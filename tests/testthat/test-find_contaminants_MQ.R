context("Find contaminants in MaxQuant")

test_that("contaminants found in proteinGroups file", {
  expect_equal(1, 2)
})


# to create test file from "/Users/admin/Work/PAF/projects/SliceSILAC/latest/data/Conde_9508/proteinGroups.txt"
# only site: 19, 63, 64,
# only rev: 6571
# only cont: 17, 18, 80
# only ACs: 402, 465
# only fasta: 526, 923


# 426 with contaminants_MQ vs 377 with following code


# inputFileName <- "/Users/admin/Work/PAF/projects/SliceSILAC/latest/data/Conde_9508/proteinGroups.txt"
# contaminantFileName <- "/Users/admin/Work/PAF/projects/SliceSILAC/latest/data/Kuravsky_7956_7999/kuravsky_more_contamin.txt"
#
# dataMQ <- read.table(inputFileName, stringsAsFactors=FALSE,quote="\"", row.names=NULL,
#                      header=TRUE, sep="\t", fill=TRUE, na.strings=c("Non Num\303\251rique"))
#
# contaminantMQ <- read.table(contaminantFileName, stringsAsFactors=FALSE,quote="\"", row.names=NULL,
#                             header=TRUE, sep="\t", fill=TRUE, na.strings=c("Non Num\303\251rique"))
#
# # remove columns containing this tag
# if(exists("ignore.tag")){
#   dataMQ <- dataMQ[,-grep(ignore.tag, colnames(dataMQ))]
# }
#
# # remove tag from colnames
# for(one.tag in all.tags){
#   colnames(dataMQ) <- gsub(one.tag, "", colnames(dataMQ))
# }
#
# # remove contaminants identified by their names
# contaminant.term <- c("keratin", "desmo", "plako", "filaggrin", "corneao", "derm", "cystatin", "horn", "annexin")
# contaminant.ac <- c("Q9NZT1", "P31944")
# contaminant.id <- grep( paste("^", contaminant.term, sep="", collapse="|"), dataMQ[, "Fasta.headers"], ignore.case = TRUE)
# contaminant.id <- c(contaminant.id, grep( paste(contaminant.ac, sep="", collapse="|"), dataMQ[, "Protein.IDs"]))
#
# # remove given gene names
# contaminant.genes <- c("TGM1")
# contaminant.id <- c(contaminant.id, grep( paste("^", contaminant.genes, sep="", collapse="|"), dataMQ[, "Fasta.headers"], ignore.case = TRUE))
#
# # remove using contaminant table (where Selection is +)
# contaminantMQ <- contaminantMQ[contaminantMQ$Selection == "+", ]
#
# for(one.p in contaminantMQ$Majority.protein.IDs){
#   best.p <- strsplit(one.p, ";")[[1]][1]
#   contaminant.id <- c(contaminant.id, grep(best.p, dataMQ[, "Protein.IDs"]))
# }
#
# contaminant.id <- unique(contaminant.id)
#
# # prepare table to plot
# contaminants.removed <- dataMQ[contaminant.id, c("Protein.IDs", "Fasta.headers", "Potential.contaminant", "Ratio.H.L")]
# contaminants.removed$Protein.IDs <- unlist(lapply(contaminants.removed$Protein.IDs, function(x) head(unlist(strsplit(x, ";")) , n=1)))
#
# # remove also contaminants and reverse indicated by MaxQuant
# contaminant.id <- c(contaminant.id, which(dataMQ$Only.identified.by.site == "+"))
# contaminant.id <- c(contaminant.id, which(dataMQ$Reverse == "+"))
# contaminant.id <- c(contaminant.id, which(dataMQ$Potential.contaminant == "+"))
#
# contaminant.id <- unique(contaminant.id)
#
# length(contaminant.id)
