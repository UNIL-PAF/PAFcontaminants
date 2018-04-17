context("Find contaminants in MaxQuant")

test_that("contaminants found in proteinGroups file", {
  proteinGroups_path <- "Conde_9508_sub.txt"
  proteinGroups_df <- read.table(proteinGroups_path, header=TRUE, sep='\t')
  expect_equal(nrow(proteinGroups_df), 17)

  is_contaminant <- contaminants_MQ(proteinGroups_df)

  expect_equal(sum(is_contaminant), 11)
  expect_equal(sum(!is_contaminant), 6)
})

# to create test file from "/Users/admin/Work/PAF/projects/SliceSILAC/latest/data/Conde_9508/proteinGroups.txt"
# only site: 19, 63, 64
# only rev: 6571
# only cont: 17, 18, 80
# only ACs: 402, 465
# only fasta: 526, 923
# some valid proteins: 961, 2595, 1997, 6108, 5221, 1237
# keep only columns c("Only.identified.by.site", "Reverse", "Potential.contaminant", "Majority.protein.IDs", "Fasta.headers")
