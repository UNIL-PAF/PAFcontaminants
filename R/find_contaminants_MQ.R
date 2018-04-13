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
#' proteinGroups_path <- "/Users/admin/Work/PAF/projects/SliceSILAC/latest/data/Conde_9508/proteinGroups.txt"
#' proteinGroups_df <- read.table(proteinGroups_path, stringsAsFactors=FALSE,
#' quote="\"", row.names=NULL, header=TRUE, sep="\t", fill=TRUE,
#' na.strings=c("Non Num\303\251rique"))
#' is_contaminant <-contaminants_MQ(proteinGroups_df)
#' @export
contaminants_MQ <- function(proteinGroups_df){
  # the unwanted entries marked by MQ
  is_only_identified_by_site <- proteinGroups_df$Only.identified.by.site == "+"
  is_reverse <- proteinGroups_df$Reverse == "+"
  is_MQ_contaminant <- proteinGroups_df$Potential.contaminant == "+"

  site_1 <- which(is_only_identified_by_site)
  rev_2 <- which(is_reverse)
  cont_3 <- which(is_MQ_contaminant)

  all_4 <- union(union(site_1, rev_2), cont_3)

  # find by ACs
  is_in_AC <- unlist(lapply(proteinGroups_df$Majority.protein.IDs, function(prot_IDs){
    any(contaminant_AC(strsplit(prot_IDs, ";")[[1]]))
  }))

  ac_5 <- which(is_in_AC)

  all_6 <- union(all_4, ac_5)

  # find by terms
  is_in_fasta <- contaminant_term(proteinGroups_df$Fasta.headers)

  fasta_7 <- which(is_in_fasta)

  setdiff(fasta_7, all_6)

  all_8 <- union(fasta_7, all_6)

  length(all_8)

  is_only_identified_by_site | is_reverse | is_MQ_contaminant | is_in_AC | is_in_fasta
}



