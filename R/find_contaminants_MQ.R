#
# find_contaminants_MQ
#----------------------
# Finds contaminants in a MQ proteinGroups file
#
# Also considers proteins marked as contaminants or revers by MQ.
# Additionaly lists from PAF are used.


#' Find contaminants
#'
#' Find all contaminants in a data.frame from MaxQuant proteinGroups.txt.
#'
#' @param proteinGroups_df A data.frame from proteinGroups.txt
#' @examples
#' proteinGroups_path <- system.file("extdata", "Conde_9508_sub.txt", package = "PAFcontaminants")
#' proteinGroups_df <- read.table(proteinGroups_path, quote='\"', row.names=NULL, header=TRUE, sep='\t', fill=TRUE, na.strings=c('Non Num\303\251rique'))
#' is_contaminant <-contaminants_MQ(proteinGroups_df)
#' @export
contaminants_MQ <- function(proteinGroups_df){
  # the unwanted entries marked by MQ
  is_only_identified_by_site <- proteinGroups_df$Only.identified.by.site == "+"
  is_reverse <- proteinGroups_df$Reverse == "+"
  is_MQ_contaminant <- proteinGroups_df$Potential.contaminant == "+"

  # find by ACs
  is_in_AC <- unlist(lapply(as.character(proteinGroups_df$Majority.protein.IDs), function(prot_IDs){
    any(contaminant_AC(strsplit(prot_IDs, ";")[[1]]))
  }))

  # find by terms
  is_in_fasta <- contaminant_term(proteinGroups_df$Fasta.headers)

  is_only_identified_by_site | is_reverse | is_MQ_contaminant | is_in_AC | is_in_fasta
}



