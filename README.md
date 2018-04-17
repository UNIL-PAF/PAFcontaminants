# PAFcontaminants
Find contaminants in proteomics experiments. You can easily filter *proteinGroups.txt* from MaxQuant using *PAFcontimants*.

At the [Protein Analysis Faciltiy](https://www.unil.ch/paf/en/home.html) of the [University of Lausanne](http://www.unil.ch/index.html) we have our internal list of contaminants.

## Installation

Install from source in R using *devtools*:

```R
library(devtools)
install_github("UNIL-PAF/PAFcontaminants", build_vignettes = TRUE)
```

## Usage

Look at the vignettes for more information about usage:

```R
browseVignettes(package="PAFcontaminants")
```
