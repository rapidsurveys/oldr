#
# Parameter list (indicator names) and output column names for bootstrapping
#
params <- c("resp1", "resp2", "resp3", "resp4",
            "age", "ageGrp1", "ageGrp2", "ageGrp3", "ageGrp4", "ageGrp5", "sex1", "sex2",
            "marital1", "marital2", "marital3", "marital4", "marital5", "marital6",
            "alone",
            "MF", "DDS", "FG01", "FG02", "FG03", "FG04", "FG05", "FG06", "FG07",
            "FG08", "FG09", "FG10", "FG11", "proteinRich", "pProtein", "aProtein",
            "pVitA", "aVitA", "xVitA",
            "ironRich",
            "caRich",
            "znRich",
            "vitB1", "vitB2", "vitB3", "vitB6", "vitB12", "vitBcomplex",
            "HHS1", "HHS2", "HHS3",
            "ADL01", "ADL02", "ADL03", "ADL04", "ADL05", "ADL06", "scoreADL", "classADL1", "classADL2", "classADL3", "hasHelp", "unmetNeed",
            "K6", "K6Case", "DS",
            "H1", "H2", "H31", "H32", "H33", "H34", "H35", "H36", "H37", "H38", "H39",
            "H4", "H5", "H61", "H62", "H63", "H64", "H65", "H66", "H67", "H68", "H69",
            "M1", "M2A", "M2B", "M2C", "M2D", "M2E", "M2F", "M2G", "M2H", "M2I",
            "W1", "W2", "W3", "W4",
            "MUAC", "oedema", "screened",
            "poorVA",
            "chew", "food", "NFRI",
            "wgVisionD0", "wgVisionD1", "wgVisionD2", "wgVisionD3",
            "wgHearingD0", "wgHearingD1", "wgHearingD2", "wgHearingD3",
            "wgMobilityD0", "wgMobilityD1", "wgMobilityD2", "wgMobilityD3",
            "wgRememberingD0", "wgRememberingD1", "wgRememberingD2", "wgRememberingD3",
            "wgSelfCareD0", "wgSelfCareD1", "wgSelfCareD2", "wgSelfCareD3",
            "wgCommunicatingD0", "wgCommunicatingD1", "wgCommunicatingD2", "wgCommunicatingD3",
            "wgP0", "wgP1", "wgP2", "wgP3", "wgPM")

#
# Blocking weighted bootstap estimates (ALL, MALES, FEMALES)
#
boot.ALL <- bootBW(x = indicators.ALL, w = psuData, statistic = bootClassic, params = params, outputColumns = params, replicates = REPLICATES)
boot.MALES <- bootBW(x = indicators.MALES, w = psuData, statistic = bootClassic, params = params, outputColumns = params, replicates = REPLICATES)
boot.FEMALES <- bootBW(x = indicators.FEMALES, w = psuData, statistic = bootClassic, params = params, outputColumns = params, replicates = REPLICATES)

#
# Extract estimates from 'boot.*' data.frames
#
estimates.ALL <- data.frame(t(apply(boot.ALL, 2, quantile, probs = c(0.025, 0.5, 0.975), na.rm = TRUE)))
estimates.MALES <- data.frame(t(apply(boot.MALES, 2, quantile, probs = c(0.025, 0.5, 0.975), na.rm = TRUE)))
estimates.FEMALES <- data.frame(t(apply(boot.FEMALES, 2, quantile, probs = c(0.025, 0.5, 0.975), na.rm = TRUE)))

#
# Join 'estimates.*' data.frames side-by-side
#
classicEstimates <- data.frame(estimates.ALL, estimates.MALES, estimates.FEMALES)

#
# Clean-up row and column names
#
classicEstimates$indicator <- row.names(classicEstimates)
row.names(classicEstimates) <- NULL
names(classicEstimates) <- c("LCL.ALL", "EST.ALL", "UCL.ALL", "LCL.MALES", "EST.MALES", "UCL.MALES", "LCL.FEMALES", "EST.FEMALES", "UCL.FEMALES", "INDICATOR")

#
# Clean-up
#
rm(boot.ALL, boot.MALES, boot.FEMALES, estimates.ALL, estimates.MALES, estimates.FEMALES, params)
gc()
