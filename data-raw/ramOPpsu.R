################################################################################
#
# Read testPSU dataset and save as .rda
#
################################################################################

testPSU <- read.csv("data-raw/testPSU.csv",
                    header = TRUE, sep = ",",
                    stringsAsFactors = FALSE)

testPSU <- tibble::tibble(testPSU)

usethis::use_data(testPSU, overwrite = TRUE, compress = "xz")
