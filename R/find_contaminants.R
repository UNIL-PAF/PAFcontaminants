#
# find_contaminants
# -------------------
# identify contaminants based on protein AC's, gene names or descriptions
#
# The list of contaminants are parsed from the following sources:
# - contaminants_ac: from the internal list from PAF (contaminant_list.csv)
# - contaminants_kuravsky: from proteins marked in Kuravsky_7956_7999/kuravsky_more_contamin.txt
# - contaminants_term: from a list of terms created at the PAF


#' kuravsky_transform_long
#'
#' There are several protein IDs and Gene.names per line in a MaxQuant
#' proteinGroups.txt file. We create a new line for every single protein Id.
#'
#' @param kuravsky_path Path to kuravsky_more_contamin.txt.
#' @examples
#' kuravsky_path <- "/Users/admin/Work/PAF/projects/SliceSILAC/latest/data/Kuravsky_7956_7999/kuravsky_more_contamin.txt"
#' contaminants_kuravsky <- kuravsky_transform_long(kuravsky_path)
#' devtools::use_data(contaminants_kuravsky)
kuravsky_transform_long <- function(kuravsky_path){
  kuravsky_df <- read.table(kuravsky_path, stringsAsFactors=FALSE,quote="\"", row.names=NULL,
                              header=TRUE, sep="\t", fill=TRUE, na.strings=c("Non Num\303\251rique"))
  # remove using contaminant table (where Selection is +)
  kuravsky_df_2 <- kuravsky_df[kuravsky_df$Selection == "+", c("Majority.protein.IDs", "Protein.names", "Gene.names")]

  # split protein IDs by ";" and create a new line per entry
  long_df <- data.frame()

  for(i in 1:nrow(kuravsky_df_2)){
    one_row <- kuravsky_df_2[i,]
    protein_ids <- strsplit(one_row$Majority.protein.IDs, ";")[[1]]
    protein_names <- strsplit(one_row$Protein.names, ";")[[1]]
    gene_names <- strsplit(one_row$Gene.names, ";")[[1]]
    for(k in 1:length(protein_ids)){
      long_df <- rbind(long_df, data.frame(protein_ids[k], protein_names[k], gene_names[k]))
    }
  }

  colnames(long_df) <- c("protein.ac", "protein.name", "gene.name")
  long_df
}


#' Identify contaminants by protein ACs
#'
#' Gives back a boolean for every given protein AC, indicating if it is a
#' contaminant or not.
#'
#' @param protein_ac A vector of protein AC's.
#' @return A vector indicating if it is a contaminant.
#' @examples
#' contaminant_AC(c("A0AVF1", "Q9NZT1", "P02786"))
#' @export
contaminant_AC <- function(protein_ac){
  data("contaminants_ac")
  data("contaminants_kuravsky")

  (protein_ac %in% contaminants_ac) | (protein_ac %in% contaminants_kuravsky$protein.ac)
}


#' Identify contaminants by gene names
#'
#' Gives back a boolean for every given gene name, indicating if it is a
#' contaminant or not.
#'
#' @param gene_name A vector of gene names.
#' @return A vector indicating if it is a contaminant.
#' @examples
#' contaminant_gene(c("TFRC", "TGM1", "MTFR1"))
#' @export
contaminant_gene <- function(gene_names){
  data("contaminants_kuravsky")

  (gene_names %in% contaminants_kuravsky$gene.name)
}


#' Identify contaminants by terms
#'
#' Gives back a boolean for every given term, indicating if it is a
#' contaminant or not.
#'
#' @param protein_terms A vector of terms.
#' @return A vector indicating if it is a contaminant.
#' @examples
#' contaminant_term(c("blibla", "blibla keratin blabla", "Keratinblibla", "kerami mouou"))
#' @export
contaminant_term <- function(protein_terms){
  data("contaminants_term")

  is_match_idx <- unlist(lapply(contaminants_term, function(ct){
    grep(ct, protein_terms, ignore.case = TRUE)
  }))

  is_match <- rep(FALSE, length(protein_terms))
  is_match[is_match_idx] <- TRUE

  is_match
}
