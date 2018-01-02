################################################################################
#
# Read testPSU dataset and save as .rda
#
################################################################################

testPSU <- read.csv("data-raw/testPSU.csv", header = TRUE, sep = ",")
devtools::use_data(testPSU, overwrite = TRUE)
