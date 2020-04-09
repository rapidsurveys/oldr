################################################################################
#
#' Age by sex (pyramid plot)
#'
#' @param x Indicators dataset produced by createOP
#' @param filename Prefix to add to output chart filename
#'
#' @return Age by sex pyramid plot in PNG format saved in the current working
#'     directory
#'
#' @examples
#'   # Create age by sex pyramid plot using \code{indicators.ALL} dataset
#'   chartAge(x = indicators.ALL, filename = "TEST")
#'
#' @export
#'
#
################################################################################

chartAge <- function(x, filename) {
  #
  # Temporary variables
  #
  sexText <- ifelse(x$sex1 == 1, "Male", "Female")
  ageGroup <- bbw::recode(x$age, "50:59='50:59'; 60:69='60:69'; 70:79='70:79'; 80:89='80:89'; 90:hi='90+'; else=NA")
  #
  # Age BY sex (pyramid plot)
  #
  plotFileName <- paste(filename, ".AgeBySex.png", sep = "")
  #
  # Open PNG graphics device
  #
  png(filename = plotFileName,
      width = 6, height = 6, units = "in",
      res = 600, pointsize = 12)
  #
  # Set graphical parameers
  #
  par(pty = "m"); par(mar = c(5, 4, 2, 2) + 0.1)
  #
  # Create age by sex pyramid plot
  #
  pyramid.plot(x = ageGroup,
               g = sexText,
               main = "",
               xlab = "Sex (Females | Males)",
               ylab = "Age group (years)")
  #
  # Close graphics device
  #
  dev.off()
}


################################################################################
#
#' Distribution of MUAC (overall and by sex)
#'
#' @param x Indicators dataset produced by createOP
#' @param filename Prefix to add to output chart filename
#' @return Histogram of MUAC distribution in PNG format and saved in the current
#'     working directory
#' @examples
#'   # Create MUAC histogram using \code{indicators.ALL} dataset
#'   chartMUAC(x = indicators.ALL, filename = "TEST")
#' @export
#'
#
################################################################################

chartMUAC <- function(x, filename) {
  #
  # Temporary variables
  #
  sexText <- ifelse(x$sex1 == 1, "Male", "Female")
  #
  #
  #
  plotFileName <- paste(filename, ".MUAC.png", sep = "")
  #
  # Open PNG graphics device
  #
  png(filename = plotFileName,
      width = 6, height = 3.5, units = "in",
      res = 600, pointsize = 10)
  #
  # Set graphical parameters
  #
  par(mfrow = c(1, 2)); par(pty = "m");
  par(cex.axis = 0.8); par(mar = c(5, 4, 2, 2) + 0.1)
  #
  # Create MUAC histogram by sex
  #
  hist(x$MUAC, breaks = 20,
       xlim = c(160, max(x$MUAC, na.rm = TRUE)),
       main = "", xlab = "MUAC (mm)", ylab = "Frequency", col = "lightgray")
  #
  # Create boxplot of MUAC by sex
  #
  boxplot(x$MUAC ~ sexText,
          main = "", xlab = "Sex", ylab = "MUAC", frame.plot = FALSE)
  #
  # Close graphics device
  #
  dev.off()
}


################################################################################
#
#' Distribution of meal frequency (overall and by sex)
#'
#' @param x Indicators dataset produced by createOP
#' @param filename Prefix to add to output chart filename
#' @return Barplot of meal frequency in PNG format saved in current working
#'     directory
#' @examples
#'   # Create meal frequency chart using \code{indicators.ALL} dataset
#'   chartMF(x = indicators.ALL, filename = "TEST")
#' @export
#'
#
################################################################################

chartMF <- function(x, filename) {
  #
  # Temporary variables
  #
  sexText <- ifelse(x$sex1 == 1, "Male", "Female")
  #
  #
  #
  plotFileName <- paste(filename, ".MF.png", sep = "")
  #
  # Open PNG graphics device
  #
  png(filename = plotFileName,
      width = 6, height = 3.5, units = "in",
      res = 600, pointsize = 10)
  #
  # Set graphical parameters
  #
  par(mfrow = c(1, 2)); par(pty = "m");
  par(cex.axis = 0.8); par(mar = c(5, 4, 2, 2) + 0.1)
  #
  # Create barplot
  #
  barplot(fullTable(x = x$MF,
                    values = 0:max(x$MF, na.rm = TRUE)),
          main = "",
          xlab = "Meal frequency", ylab = "Frequency",
          col = "lightgray")
  #
  # Create boxplot
  #
  boxplot(x$MF ~ sexText,
          main = "",
          xlab = "Sex", ylab = "Meal frequency", frame.plot = FALSE)
  #
  # Close graphics device
  #
  dev.off()
}


################################################################################
#
#' Distribution of DDS (overall and by sex)
#'
#' @param x Indicators dataset produced by createOP
#' @param filename Prefix to add to output chart filename
#' @return Barplot of dietary diversity score in PNG format saved in current
#'     working directory
#' @examples
#'   # Create DDS chart using \code{indicators.ALL} dataset
#'   chartDDS(x = indicators.ALL, filename = "TEST")
#' @export
#'
#
################################################################################

chartDDS <- function(x, filename) {
  #
  # Temporary variables
  #
  sexText <- ifelse(x$sex1 == 1, "Male", "Female")
  #
  #
  #
  plotFileName <- paste(filename, ".DDS.png", sep = "")
  #
  # Open PNG graphics device
  #
  png(filename = plotFileName,
      width = 6, height = 3.5, units = "in",
      res = 600, pointsize = 10)
  #
  # Set graphical parameters
  #
  par(mfrow = c(1, 2)); par(pty = "m");
  par(cex.axis = 0.8); par(mar = c(5, 4, 2, 2) + 0.1)
  #
  # Create barplot
  #
  barplot(fullTable(x = x$DDS,
                    values = 0:max(x$DDS)),
          main = "",
          xlab = "Dietary diversity score",
          ylab = "Frequency",
          col = "lightgray")
  #
  # Create boxplot
  #
  boxplot(x$DDS ~ sexText,
          main = "",
          xlab = "Sex", ylab = "Dietary diversity score", frame.plot = FALSE)
  #
  # Close graphics device
  #
  dev.off()
}


################################################################################
#
#' Distribution of K6 (overall and by sex)
#'
#' @param x Indicators dataset produced by createOP
#' @param filename Prefix to add to output chart filename
#' @return Histogram of K6 score in PNG format saved in current
#'     working directory
#' @examples
#'   # Create chart using \code{indicators.ALL} dataset
#'   chartK6(x = indicators.ALL, filename = "TEST")
#' @export
#'
#
################################################################################

chartK6 <- function(x, filename) {
  #
  # Temporary variables
  #
  sexText <- ifelse(x$sex1 == 1, "Male", "Female")
  #
  #
  #
  plotFileName <- paste(filename, ".K6.png", sep = "")
  #
  # Open PNG graphics device
  #
  png(filename = plotFileName,
      width = 6, height = 3.5, units = "in", res = 600, pointsize = 10)
  #
  # Set graphical parameters
  #
  par(mfrow = c(1, 2)); par(pty = "m")
  par(cex.axis = 0.8)
  par(mar = c(5, 4, 2, 2) + 0.1)
  #
  # Create histogram
  #
  hist(x$K6, main = "", xlab = "K6", ylab = "Frequency", col = "lightgray")
  #
  # Create boxplot
  #
  boxplot(x$K6 ~ sexText, main = "", xlab = "Sex", ylab = "K6", frame.plot = FALSE)
  #
  # Close graphics device
  #
  dev.off()
}


################################################################################
#
#' Distribution of ADL (overall and by sex)
#'
#' @param x Indicators dataset produced by createOP
#' @param filename Prefix to add to output chart filename
#' @return Bar plot of ADL in PNG format saved in current working directory
#' @examples
#'   # Create chart using \code{indicators.ALL} dataset
#'   chartADL(x = indicators.ALL, filename = "TEST")
#' @export
#'
#
################################################################################

chartADL <- function(x, filename) {
  #
  # Temporary variables
  #
  sexText <- ifelse(x$sex1 == 1, "Male", "Female")
  #
  #
  #
  plotFileName <- paste(filename, ".ADL.png", sep = "")
  #
  # Open PNG graphics device
  #
  png(filename = plotFileName,
      width = 6, height = 3.5, units = "in", res = 600, pointsize = 10)
  #
  # Set graphical parameters
  #
  par(mfrow = c(1, 2)); par(pty = "m")
  par(cex.axis = 0.8); par(mar = c(5, 4, 2, 2) + 0.1)
  #
  # Create bar plot
  #
  barplot(fullTable(x = x$scoreADL, values = 0:6),
          main = "",  xlab = "Katz ADL Score", ylab = "Frequency", col = "lightgray")
  #
  # Create boxplot
  #
  boxplot(x$scoreADL ~ sexText,
          main = "", xlab = "Sex", ylab = "Katz ADL Score", frame.plot = FALSE)
  #
  # Close graphics device
  #
  dev.off()
}


################################################################################
#
#' Chart WASH indicators
#'
#' @param x Indicators dataset produced by createOP
#' @param filename Prefix to add to output chart filename
#' @return Bar plot of ADL in PNG format saved in current working directory
#' @examples
#'   # Create chart using \code{indicators.ALL} dataset
#'   chartWASH(x = indicators.ALL, filename = "TEST")
#' @export
#'
#
################################################################################

chartWASH <- function(x, filename) {
  plotFileName <- paste(filename, ".WASH.png", sep = "")
  #
  # Open PNG graphics device
  #
  png(filename = plotFileName,
      width = 6, height = 6, units = "in", res = 600, pointsize = 10)
  #
  # Set graphical parameters
  #
  par(mfrow = c(2, 2))
  par(cex.axis = 0.8)
  #
  # Tabulate WASH results - source of drinking water
  #
  tab <- table(x$W1)
  names(tab) <- c("Not improved", "Improved")
  #
  # Create bar plot - source of drinking water
  #
  barplot(tab, main = "Source of drinking water",
          col = c("red", "green"), ylab = "Frequency")
  #
  # Tabulate WASH results - Safe drinking water
  #
  tab <- table(x$W2)
  names(tab) <- c("Unsafe", "Safe")
  #
  # Create bar plot - safe drinking water
  #
  barplot(tab, main = "Safe drinking water",
          col = c("red", "green"), ylab = "Frequency")
  #
  # Tabulate WASH results - sanitation facility
  #
  tab <- table(x$W3)
  names(tab) <- c("Not improved", "Improved")
  #
  # Create bar plot - sanitation facility
  #
  barplot(tab, main = "Improved sanitation facility",
          col = c("red", "green"), ylab = "Frequency")
  #
  # Tabulate WASH results - improved non-shared sanitation facility
  #
  tab <- table(x$W4)
  names(tab) <- c("Not improved\nor shared", "Improved and\nnot shared")
  #
  # Create bar plot - improved non-shared sanitation facility
  #
  barplot(tab, main = "Improved and non-shared\nsanitation facility",
          col = c("red", "green"), ylab = "Frequency")
  #
  # Close graphics device
  #
  dev.off()
}


################################################################################
#
#' Chart dementia screen (CSID) indicators
#'
#' @param x Indicators dataset produced by createOP
#' @param filename Prefix to add to output chart filename
#' @return Bar plot of CSID in PNG format saved in current working directory
#' @examples
#'   # Create chart using \code{indicators.ALL} dataset
#'   chartCSID(x = indicators.ALL, filename = "TEST")
#' @export
#'
#
################################################################################

chartCSID <- function(x, filename) {
  plotFileName <- paste(filename, ".dementia.png", sep = "")
  #
  # Open PNG graphics device
  #
  png(filename = plotFileName,
      width = 6, height = 6, units = "in", res = 600, pointsize = 10)
  #
  # Tabulate dementia score
  #
  tab <- table(x$DS)
  names(tab) <- c("Normal", "Probable dementia")
  #
  # Create barplot
  #
  barplot(tab, main = "", col = c("green", "red"), ylab = "Frequency")
  #
  # Close graphics device
  #
  dev.off()
}


################################################################################
#
#' Chart disability (Washington Group - WG) indicators
#'
#' @param x Indicators dataset produced by createOP
#' @param filename Prefix to add to output chart filename
#' @return Bar plot of Disability Score in PNG format saved in current working
#'     directory
#' @examples
#'   # Create chart using \code{indicators.ALL} dataset
#'   chartWG(x = indicators.ALL, filename = "TEST")
#' @export
#'
#
################################################################################

chartWG <- function(x, filename) {
  plotFileName <- paste(filename, ".disability.png", sep = "")
  #
  # Open PNG graphics device
  #
  png(filename = plotFileName,
      width = 6, height = 6, units = "in", res = 600, pointsize = 10)
  #
  # Tabulate WG scores by dimensions
  #
  P0 <- table(x$wgP0)["1"]
  P1 <- table(x$wgP1)["1"]
  P2 <- table(x$wgP2)["1"]
  P3 <- table(x$wgP3)["1"]
  PM <- table(x$wgPM)["1"]
  tab <- as.table(c(P0, P1, P2, P3, PM))
  names(tab) <- c("\nP0 : None ", "\nP1 : Any", "P2 : Moderate\nor severe",
                  "\nP3 : Severe", "\nPM : Multiple")
  #
  # Create barplot
  #
  barplot(tab, main = "", col = "lightgray", ylab = "Frequency", cex.names = 0.8)
  #
  # Close graphics device
  #
  dev.off()
}


################################################################################
#
#' Chart household hunger scale (HHS) indicators
#'
#' @param x Indicators dataset produced by createOP
#' @param filename Prefix to add to output chart filename
#' @return Bar plot of HHS in PNG format saved in current working directory
#' @examples
#'   # Create chart using \code{indicators.ALL} dataset
#'   chartHHS(x = indicators.ALL, filename = "TEST")
#' @export
#'
#
################################################################################

chartHHS <- function(x, filename) {
  plotFileName <- paste(filename, ".HHS.png", sep = "")
  #
  # Open PNG graphics device
  #
  png(filename = plotFileName,
      width = 6, height = 6, units = "in", res = 600, pointsize = 10)
  #
  # Tabulate HHS
  #
  H0 <- table(x$wgP0)["1"]
  H1 <- table(x$wgP1)["1"]
  H2 <- table(x$wgP2)["1"]
  tab <- as.table(c(H0, H1, H2))
  names(tab) <- c("Little or none", "Moderate", "Severe")
  #
  # Create bar plot
  #
  barplot(tab, main = "", col = c("green", "orange", "red"), ylab = "Frequency", cex.names = 0.8)
  #
  # Close graphics device
  #
  dev.off()
}


################################################################################
#
#' Chart income indicators
#'
#' @param x.male Male subset of indicator dataset
#' @param x.female Female subset of indicator dataset
#' @param filename Prefix to add to output chart filename
#' @return Bar chart of sources of income by sex
#' @examples
#'   # Create chart using \code{indicators.FEMALES} and \code{indicators.MALES}
#'   # dataset
#'   chartIncome(x.male = indicators.MALES,
#'               x.female = indicators.FEMALES,
#'               filename = "TEST")
#' @export
#'
#
################################################################################

chartIncome <- function(x.male, x.female, filename) {
  #
  # Sources of income (by sex)
  #
  tabM <- NULL
  tabM <- c(tabM, table(x.male$M2A)["1"])
  tabM <- c(tabM, table(x.male$M2B)["1"])
  tabM <- c(tabM, table(x.male$M2C)["1"])
  tabM <- c(tabM, table(x.male$M2D)["1"])
  tabM <- c(tabM, table(x.male$M2E)["1"])
  tabM <- c(tabM, table(x.male$M2F)["1"])
  tabM <- c(tabM, table(x.male$M2G)["1"])
  tabM <- c(tabM, table(x.male$M2H)["1"])
  tabM <- c(tabM, table(x.male$M2I)["1"])
  tabM[is.na(tabM)] <- 0
  tabF <- NULL
  tabF <- c(tabF, table(x.female$M2A)["1"])
  tabF <- c(tabF, table(x.female$M2B)["1"])
  tabF <- c(tabF, table(x.female$M2C)["1"])
  tabF <- c(tabF, table(x.female$M2D)["1"])
  tabF <- c(tabF, table(x.female$M2E)["1"])
  tabF <- c(tabF, table(x.female$M2F)["1"])
  tabF <- c(tabF, table(x.female$M2G)["1"])
  tabF <- c(tabF, table(x.female$M2H)["1"])
  tabF <- c(tabF, table(x.female$M2I)["1"])
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
  plotFileName <- paste(filename, ".Incomes.png", sep = "")
  png(filename = plotFileName, width = 6, height = 6, units = "in", res = 600, pointsize = 10)
  par(pty = "m"); par(las = 1); par(cex.axis = 0.8); par(mar = c(3, 12, 2, 2) + 0.1)
  barplot(t(tab), col = c("lightgray", "white"), horiz = TRUE, main = "", xlab = "Frequency (males are shaded)", ylab = "")
  dev.off()
}
