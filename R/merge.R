#
# Concatenate classic and PROBIT estimates into a single data.frame
#
estimates <- rbind(classicEstimates, probitEstimates)

#
# Merge 'estimates' data.frame and 'language' data.frame in prepartion for reporting
# and maintaining the original row ordering of the 'language' data.frame ...
#
language$originalOrder <- 1:nrow(estimates)
estimates <- merge(estimates, language, by = "INDICATOR")
estimates <- estimates[order(estimates$originalOrder), ]
estimates <- subset(estimates, select = -originalOrder)

#
# Clean-up
#
rm(classicEstimates, probitEstimates)
