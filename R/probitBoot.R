#
# Parameter list (indicator names) and output column names for bootstrapping
#
params <- c("MUAC")

#
# Blocking weighted bootstrap (GAM)
#
THRESHOLD <- 210
bootGAM.ALL <- bootBW(x = indicators.ALL, w = psuData, statistic = bootPROBIT, params = params, outputColumns = params, replicates = REPLICATES)
bootGAM.MALES <- bootBW(x = indicators.MALES, w = psuData, statistic = bootPROBIT, params = params, outputColumns = params, replicates = REPLICATES)
bootGAM.FEMALES <- bootBW(x = indicators.FEMALES, w = psuData, statistic = bootPROBIT, params = params, outputColumns = params, replicates = REPLICATES)
names(bootGAM.ALL) <- names(bootGAM.MALES) <- names(bootGAM.FEMALES) <- "GAM"

#
# Blocking weighted bootstrap (SAM)
#
THRESHOLD <- 185
bootSAM.ALL <- bootBW(x = indicators.ALL, w = psuData, statistic = bootPROBIT, params = params, outputColumns = params, replicates = REPLICATES)
bootSAM.MALES <- bootBW(x = indicators.MALES, w = psuData, statistic = bootPROBIT, params = params, outputColumns = params, replicates = REPLICATES)
bootSAM.FEMALES <- bootBW(x = indicators.FEMALES, w = psuData, statistic = bootPROBIT, params = params, outputColumns = params, replicates = REPLICATES)
names(bootSAM.ALL) <- names(bootSAM.MALES) <- names(bootSAM.FEMALES) <- "SAM"

#
# MAM is GAM - SAM
#
bootMAM.ALL <- bootGAM.ALL - bootSAM.ALL
bootMAM.MALES <- bootGAM.MALES - bootSAM.MALES
bootMAM.FEMALES <- bootGAM.FEMALES - bootSAM.FEMALES
names(bootMAM.ALL) <- names(bootMAM.MALES) <- names(bootMAM.FEMALES) <- "MAM"
#
# Fix for MAM < 0 (may occur if bootstrap GAM < bootstrap SAM)
#
bootMAM.ALL$MAM[bootMAM.ALL$MAM < 0] <- 0
bootMAM.MALES$MAM[bootMAM.MALES$MAM < 0] <- 0
bootMAM.FEMALES$MAM[bootMAM.FEMALES$MAM < 0] <- 0

#
# Combine 'bootGAM.*', 'bootMAM.*', and 'booSAM.*' data.frames (ALL, MALES, FEMALES)
#
boot.ALL <- data.frame(bootGAM.ALL, bootMAM.ALL, bootSAM.ALL)
boot.MALES <- data.frame(bootGAM.MALES, bootMAM.MALES, bootSAM.MALES)
boot.FEMALES <- data.frame(bootGAM.FEMALES, bootMAM.FEMALES, bootSAM.FEMALES)
rm(bootGAM.ALL, bootMAM.ALL, bootSAM.ALL, bootGAM.MALES, bootMAM.MALES, bootSAM.MALES, bootGAM.FEMALES, bootMAM.FEMALES, bootSAM.FEMALES)

#
# Extract estimates from 'boot.*' data.frames
#
estimates.ALL <- data.frame(t(apply(boot.ALL, 2, quantile, probs = c(0.025, 0.5, 0.975), na.rm = TRUE)))
estimates.MALES <- data.frame(t(apply(boot.MALES, 2, quantile, probs = c(0.025, 0.5, 0.975), na.rm = TRUE)))
estimates.FEMALES <- data.frame(t(apply(boot.FEMALES, 2, quantile, probs = c(0.025, 0.5, 0.975), na.rm = TRUE)))

#
# Join 'estimates.*' data.frames side-by-side
#
probitEstimates <- data.frame(estimates.ALL, estimates.MALES, estimates.FEMALES)

#
# Clean-up row and column names
#
probitEstimates$indicator <- row.names(probitEstimates)
row.names(probitEstimates) <- NULL
names(probitEstimates) <- c("LCL.ALL", "EST.ALL", "UCL.ALL", "LCL.MALES", "EST.MALES", "UCL.MALES", "LCL.FEMALES", "EST.FEMALES", "UCL.FEMALES", "INDICATOR")

#
# Clean-up
#
rm(params, THRESHOLD, boot.ALL, boot.MALES, boot.FEMALES, estimates.ALL, estimates.MALES, estimates.FEMALES)
gc()
