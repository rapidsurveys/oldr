#
# Temporary variables
#
sexText <- ifelse(indicators.ALL$sex1 == 1, "Male", "Female")
ageGroup <- recode(indicators.ALL$age, "50:59='50:59'; 60:69='60:69'; 70:79='70:79'; 80:89='80:89'; 90:hi='90+'; else=NA")

#
# Age BY sex (pyramid plot)
#
plotFileName <- paste(FILENAME, ".AgeBySex.png", sep = "")
png(filename = plotFileName, width = 6, height = 6, units = "in", res = 600, pointsize = 12)
par(pty = "m"); par(mar = c(5, 4, 2, 2) + 0.1)
pyramid.plot(ageGroup, sexText, main = "", xlab = "Sex (Females | Males)", ylab = "Age group (years)")
dev.off()
rm(plotFileName)

#
# Distribution of MUAC (overall and by sex)
#
plotFileName <- paste(FILENAME, ".MUAC.png", sep = "")
png(filename = plotFileName, width = 6, height = 3.5, units = "in", res = 600, pointsize = 10)
par(mfrow = c(1, 2)); par(pty = "m"); par(cex.axis = 0.8); par(mar = c(5, 4, 2, 2) + 0.1)
hist(indicators.ALL$MUAC, breaks = 20, xlim = c(160, max(indicators.ALL$MUAC, na.rm = TRUE)), main = "", xlab = "MUAC (mm)", ylab = "Frequency", col = "lightgray")
boxplot(indicators.ALL$MUAC ~ sexText,  main = "", xlab = "Sex", ylab = "MUAC", frame.plot = FALSE)
dev.off()
rm(plotFileName)

#
# Distribution of meal frequency (overall and by sex)
#
plotFileName <- paste(FILENAME, ".MF.png", sep = "")
png(filename = plotFileName, width = 6, height = 3.5, units = "in", res = 600, pointsize = 10)
par(mfrow = c(1, 2)); par(pty = "m"); par(cex.axis = 0.8); par(mar = c(5, 4, 2, 2) + 0.1)
barplot(fullTable(x = indicators.ALL$MF, values = 0:max(indicators.ALL$MF, na.rm = TRUE)), main = "", xlab = "Meal frequency", ylab = "Frequency", col = "lightgray")
boxplot(indicators.ALL$MF ~ sexText,  main = "", xlab = "Sex", ylab = "Meal frequency", frame.plot = FALSE)
dev.off()
rm(plotFileName)

#
# Distribution of DDS (overall and by sex)
#
plotFileName <- paste(FILENAME, ".DDS.png", sep = "")
png(filename = plotFileName, width = 6, height = 3.5, units = "in", res = 600, pointsize = 10)
par(mfrow = c(1, 2)); par(pty = "m"); par(cex.axis = 0.8); par(mar = c(5, 4, 2, 2) + 0.1)
barplot(fullTable(x = indicators.ALL$DDS, values = 0:max(indicators.ALL$DDS)), main = "", xlab = "Dietary diversity score", ylab = "Frequency", col = "lightgray")
boxplot(indicators.ALL$DDS ~ sexText, main = "", xlab = "Sex", ylab = "Dietary diversity score", frame.plot = FALSE)
dev.off()
rm(plotFileName)

#
# Distribution of K6 (overall and by sex)
#
plotFileName <- paste(FILENAME, ".K6.png", sep = "")
png(filename = plotFileName, width = 6, height = 3.5, units = "in", res = 600, pointsize = 10)
par(mfrow = c(1, 2)); par(pty = "m"); par(cex.axis = 0.8); par(mar = c(5, 4, 2, 2) + 0.1)
hist(indicators.ALL$K6, main = "", xlab = "K6", ylab = "Frequency", col = "lightgray")
boxplot(indicators.ALL$K6 ~ sexText, main = "", xlab = "Sex", ylab = "K6", frame.plot = FALSE)
dev.off()
rm(plotFileName)

#
# Distribution of ADL (overall and by sex)
#
plotFileName <- paste(FILENAME, ".ADL.png", sep = "")
png(filename = plotFileName, width = 6, height = 3.5, units = "in", res = 600, pointsize = 10)
par(mfrow = c(1, 2)); par(pty = "m"); par(cex.axis = 0.8); par(mar = c(5, 4, 2, 2) + 0.1)
barplot(fullTable(x = indicators.ALL$scoreADL, values = 0:6), main = "",  xlab = "Katz ADL Score", ylab = "Frequency", col = "lightgray")
boxplot(indicators.ALL$scoreADL ~ sexText, main = "", xlab = "Sex", ylab = "Katz ADL Score", frame.plot = FALSE)
dev.off()
rm(plotFileName)

#
# Sources of income (by sex)
#
tabM <- NULL
tabM <- c(tabM, table(indicators.MALES$M2A)["1"])
tabM <- c(tabM, table(indicators.MALES$M2B)["1"])
tabM <- c(tabM, table(indicators.MALES$M2C)["1"])
tabM <- c(tabM, table(indicators.MALES$M2D)["1"])
tabM <- c(tabM, table(indicators.MALES$M2E)["1"])
tabM <- c(tabM, table(indicators.MALES$M2F)["1"])
tabM <- c(tabM, table(indicators.MALES$M2G)["1"])
tabM <- c(tabM, table(indicators.MALES$M2H)["1"])
tabM <- c(tabM, table(indicators.MALES$M2I)["1"])
tabM[is.na(tabM)] <- 0
tabF <- NULL
tabF <- c(tabF, table(indicators.FEMALES$M2A)["1"])
tabF <- c(tabF, table(indicators.FEMALES$M2B)["1"])
tabF <- c(tabF, table(indicators.FEMALES$M2C)["1"])
tabF <- c(tabF, table(indicators.FEMALES$M2D)["1"])
tabF <- c(tabF, table(indicators.FEMALES$M2E)["1"])
tabF <- c(tabF, table(indicators.FEMALES$M2F)["1"])
tabF <- c(tabF, table(indicators.FEMALES$M2G)["1"])
tabF <- c(tabF, table(indicators.FEMALES$M2H)["1"])
tabF <- c(tabF, table(indicators.FEMALES$M2I)["1"])
tabF[is.na(tabF)] <- 0
#
# Merge data for males (tabM) and females (tabF)
#
tab <- data.frame(tabM, tabF)
names(tab) <- c("M", "F")
tab$SUM <- tab$M + tab$F
#
# Label rows with income source
#
rownames(tab) <- c("Agriculture / fishing / livestock",
                   "Wage / salary",
                   "Sales of charcoal / bricks / &c.",
                   "Trading (e.g. market or shop)",
                   "Investments",
                   "Spending savings / sales of assets",
                   "Charity",
                   "Cash transfer / social security",
                   "Other source(s) of income")
#
# Sort by frequency of income source (descending)
#
tab <- tab[rev(order(tab$SUM)), ]
#
# Convert data.frame to a table for plotting using the 'barplot()' function
#
tab <- as.table(as.matrix(tab[ ,1:2]))
#
# Plot income sources by sex
#
plotFileName <- paste(FILENAME, ".Incomes.png", sep = "")
png(filename = plotFileName, width = 6, height = 6, units = "in", res = 600, pointsize = 10)
par(pty = "m"); par(las = 1); par(cex.axis = 0.8); par(mar = c(3, 12, 2, 2) + 0.1)
barplot(t(tab), col = c("lightgray", "white"), horiz = TRUE, main = "", xlab = "Frequency (males are shaded)", ylab = "")
dev.off()
rm(plotFileName, tab, tabF, tabM)

#
# WASH
#
plotFileName <- paste(FILENAME, ".WASH.png", sep = "")
png(filename = plotFileName, width = 6, height = 6, units = "in", res = 600, pointsize = 10)
par(mfrow = c(2, 2))
par(cex.axis = 0.8)
tab <- table(indicators.ALL$W1)
names(tab) <- c("Not improved", "Improved")
barplot(tab, main = "Source of drinking water", col = c("red", "green"), ylab = "Frequency")
tab <- table(indicators.ALL$W2)
names(tab) <- c("Unsafe", "Safe")
barplot(tab, main = "Safe drinking water", col = c("red", "green"), ylab = "Frequency")
tab <- table(indicators.ALL$W3)
names(tab) <- c("Not improved", "Improved")
barplot(tab, main = "Improved sanitation facility", col = c("red", "green"), ylab = "Frequency")
tab <- table(indicators.ALL$W4)
names(tab) <- c("Not improved\nor shared", "Improved and\nnot shared")
barplot(tab, main = "Improved and non-shared\nsanitation facility", col = c("red", "green"), ylab = "Frequency")
dev.off()
rm(plotFileName, tab)

#
# Dementia screen (CSID)
#
plotFileName <- paste(FILENAME, ".dementia.png", sep = "")
png(filename = plotFileName, width = 6, height = 6, units = "in", res = 600, pointsize = 10)
tab <- table(indicators.ALL$DS)
names(tab) <- c("Normal", "Probable dementia")
barplot(tab, main = "", col = c("green", "red"), ylab = "Frequency")
dev.off()
rm(plotFileName, tab)

#
# Disability (Washington Group)
#
plotFileName <- paste(FILENAME, ".disability.png", sep = "")
png(filename = plotFileName, width = 6, height = 6, units = "in", res = 600, pointsize = 10)
P0 <- table(indicators.ALL$wgP0)["1"]
P1 <- table(indicators.ALL$wgP1)["1"]
P2 <- table(indicators.ALL$wgP2)["1"]
P3 <- table(indicators.ALL$wgP3)["1"]
PM <- table(indicators.ALL$wgPM)["1"]
tab <- as.table(c(P0, P1, P2, P3, PM))
names(tab) <- c("\nP0 : None ", "\nP1 : Any", "P2 : Moderate\nor severe", "\nP3 : Severe", "\nPM : Multiple")
barplot(tab, main = "", col = "lightgray", ylab = "Frequency", cex.names = 0.8)
dev.off()
rm(plotFileName, P0, P1, P2, P3, PM, tab)

#
# Hunger (HHS)
#
plotFileName <- paste(FILENAME, ".HHS.png", sep = "")
png(filename = plotFileName, width = 6, height = 6, units = "in", res = 600, pointsize = 10)
H0 <- table(indicators.ALL$wgP0)["1"]
H1 <- table(indicators.ALL$wgP1)["1"]
H2 <- table(indicators.ALL$wgP2)["1"]
tab <- as.table(c(H0, H1, H2))
names(tab) <- c("Little or none", "Moderate", "Severe")
barplot(tab, main = "", col = c("green", "orange", "red"), ylab = "Frequency", cex.names = 0.8)
dev.off()
rm(plotFileName, H0, H1, H2, tab)

#
# Clean-up
#
rm(sexText, ageGroup)
gc()

