################################################################################
#
# Load internationalisation data from the file 'ramOP.language.csv' which should
# be present in the current working directory (i.e. the same diectory as this
# workflow file).
#
################################################################################
#
# Read language file
#
language <- read.table(file = "data-raw/ramOP.language.csv",
                       header = TRUE,
                       sep = ",",
                       quote = "")
#
# Save language file as internal package data
#
devtools::use_data(language, pkg = ".", internal = TRUE, overwrite = TRUE)
