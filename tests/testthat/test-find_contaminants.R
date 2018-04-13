context("Find contaminants")


test_that("contaminant_AC finds correct entries", {
  expect_equal(contaminant_AC(c("A0AVF1", "Q9NZT1", "P02786")), c(FALSE, TRUE, FALSE))
  # check an entry only in contaminants_ac
  expect_equal(contaminant_AC(c("Q53H37", "P02786")), c(TRUE, FALSE))
  # check an entry only in contaminants_kuravsky$protein.ac
  expect_equal(contaminant_AC(c("P02786", "A8K2U0")), c(FALSE, TRUE))
  # check entries in both tables
  expect_equal(contaminant_AC(c("P02786", "P02656")), c(FALSE, TRUE))
})


test_that("contaminant_gene finds correct entries", {
  expect_equal(contaminant_gene(c("TFRC", "TGM1", "MTFR1")), c(FALSE, TRUE, FALSE))
})


