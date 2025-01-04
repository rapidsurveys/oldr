#' 
#' Age by sex (pyramid plot)
#'
#' A wrapper function to the [pyramid.plot()] function to create an age by
#' sex pyramid plot
#'
#' @param x Indicators dataset produced by [create_op()]
#' @param save_chart Logical. Should chart be saved? Default is TRUE.
#' @param filename Prefix to add to output chart filename or a directory
#'   path to save output to instead of working directory. Default is a path to
#'   a temporary directory and a filename starting with
#'   `populationPyramid`. Ignored if `save_chart` is FALSE.
#'
#' @return Age by sex pyramid plot in PNG format saved in the current working
#'     directory or in a specified directory if `filename` is a path unless
#'     when `save_chart` is FALSE in which case the plot is shown on current
#'     graphics device
#'
#' @examples
#'   # Create age by sex pyramid plot using indicators.ALL dataset
#'   chart_age(x = indicators.ALL)
#'
#' @export
#'

chart_age <- function(x,
                      save_chart = TRUE,
                      filename = paste(tempdir(),
                                       "populationPyramid",
                                       sep = "/")) {
  ## Temporary variables
  sexText <- ifelse(x$sex1 == 1, "Male", "Female")
  ageGroup <- bbw::recode(
    var = x$age,
    recodes = "50:59='50:59'; 60:69='60:69'; 70:79='70:79'; 80:89='80:89'; 90:hi='90+'; else=NA"
  )

  ## Age BY sex (pyramid plot)
  plotFileName <- paste(filename, ".AgeBySex.png", sep = "")

  ## Check whether to save chart
  if(save_chart) {

    ## Open PNG graphics device
    grDevices::png(filename = plotFileName,
                   width = 6, height = 6, units = "in",
                   res = 600, pointsize = 12)

    ## Set graphical parameters
    withr::with_par(
      list(pty = "m", mar = c(5, 4, 2, 2) + 0.1),

      ## Create age by sex pyramid plot
      pyramid.plot(x = ageGroup,
                   g = sexText,
                   main = "",
                   xlab = "Sex (Females | Males)",
                   ylab = "Age group (years)")
    )

    ## Close graphics device
    grDevices::dev.off()
  } else {
    ## Set graphical parameters
    withr::with_par(
      list(pty = "m", mar = c(5, 4, 2, 2) + 0.1),

      ## Create age by sex pyramid plot
      pyramid.plot(x = ageGroup,
                   g = sexText,
                   main = "",
                   xlab = "Sex (Females | Males)",
                   ylab = "Age group (years)")
    )
  }
}



#' 
#' Distribution of MUAC (overall and by sex)
#'
#' @param x Indicators dataset produced by [create_op()]
#' @param save_chart Logical. Should chart be saved? Default is TRUE.
#' @param filename Prefix to add to output chart filename or a directory
#'   path to save output to instead of working directory. Default is a path to
#'   a temporary directory and a filename starting with `chart`. Ignored
#'   if `save_chart` is FALSE.
#'
#' @return Histogram of MUAC distribution in PNG format and saved in the current
#'     working directory or in a specified directory if `filename` is a
#'     path unless when `save_chart` is FALSE in which case chart is
#'     shown on current graphics device.
#'
#' @examples
#'   # Create MUAC histogram using indicators.ALL dataset
#'   chart_muac(x = indicators.ALL)
#'
#' @export
#'

chart_muac <- function(x,
                       save_chart = TRUE,
                       filename = paste(tempdir(), "chart", sep = "/")) {
  ## Temporary variables
  sexText <- ifelse(x$sex1 == 1, "Male", "Female")

  ## Create filename
  plotFileName <- paste(filename, ".MUAC.png", sep = "")

  ## Check whether to save chart
  if(save_chart) {

    ## Open PNG graphics device
    grDevices::png(filename = plotFileName,
                   width = 6, height = 3.5, units = "in",
                   res = 600, pointsize = 10)

    ## Set graphical parameters
    withr::with_par(
      list(mfrow = c(1, 2),
           pty = "m",
           cex.axis = 0.8,
           mar = c(5, 4, 2, 2) + 0.1),

      {
        ## Create MUAC histogram by sex
        hist(x$MUAC, breaks = 20,
             xlim = c(160, max(x$MUAC, na.rm = TRUE)),
             main = "", xlab = "MUAC (mm)", ylab = "Frequency", col = "lightgray")

        ## Create boxplot of MUAC by sex
        boxplot(x$MUAC ~ sexText,
                main = "", xlab = "Sex", ylab = "MUAC", frame.plot = FALSE)
      }
    )

    ## Close graphics device
    grDevices::dev.off()
  } else {
    ## Set graphical parameters
    withr::with_par(
      list(mfrow = c(1, 2),
           pty = "m",
           cex.axis = 0.8,
           mar = c(5, 4, 2, 2) + 0.1),

      {
        ## Create MUAC histogram by sex
        hist(x$MUAC, breaks = 20,
             xlim = c(160, max(x$MUAC, na.rm = TRUE)),
             main = "", xlab = "MUAC (mm)", 
             ylab = "Frequency", col = "lightgray")

        ## Create boxplot of MUAC by sex
        boxplot(x$MUAC ~ sexText,
                main = "", xlab = "Sex", ylab = "MUAC", frame.plot = FALSE)
      }
    )
  }
}


#' 
#' Distribution of meal frequency (overall and by sex)
#'
#' @param x Indicators dataset produced by [create_op()]
#' @param save_chart Logical. Should chart be saved? Default is TRUE.
#' @param filename Prefix to add to output chart filename or a directory
#'   path to save output to instead of working directory. Default is a path to
#'   a temporary directory and a filename starting with `chart`. Ignored
#'   if `save_chart` is FALSE.
#'
#' @return Barplot of meal frequency in PNG format saved in current working
#'     directory or in a specified directory if `filename` is a path unless
#'     when `save_chart` is FALSE in which case chart is shown in current
#'     graphics device.
#'
#' @examples
#'   # Create meal frequency chart using indicators.ALL dataset
#'   chart_mf(x = indicators.ALL)
#'
#' @export
#'

chart_mf <- function(x,
                     save_chart = TRUE,
                     filename = paste(tempdir(), "chart", sep = "/")) {
  ## Temporary variables
  sexText <- ifelse(x$sex1 == 1, "Male", "Female")

  ## Create filename
  plotFileName <- paste(filename, ".MF.png", sep = "")

  ## Check if save_chart
  if(save_chart){
    ## Open PNG graphics device
    grDevices::png(filename = plotFileName,
                   width = 6, height = 3.5, units = "in",
                   res = 600, pointsize = 10)

    ## Set graphical parameters
    withr::with_par(
      list(mfrow = c(1, 2),
           pty = "m",
           cex.axis = 0.8,
           mar = c(5, 4, 2, 2) + 0.1),

      {
        ## Create barplot
        barplot(fullTable(x = x$MF,
                          values = 0:max(x$MF, na.rm = TRUE)),
                main = "",
                xlab = "Meal frequency", ylab = "Frequency",
                col = "lightgray")

        ## Create boxplot
        boxplot(x$MF ~ sexText,
                main = "",
                xlab = "Sex", ylab = "Meal frequency", frame.plot = FALSE)
      }
    )

    ## Close graphics device
    grDevices::dev.off()
  } else {
    ## Set graphical parameters
    withr::with_par(
      list(mfrow = c(1, 2),
           pty = "m",
           cex.axis = 0.8,
           mar = c(5, 4, 2, 2) + 0.1),

      {
        ## Create barplot
        barplot(fullTable(x = x$MF,
                          values = 0:max(x$MF, na.rm = TRUE)),
                main = "",
                xlab = "Meal frequency", ylab = "Frequency",
                col = "lightgray")

        ## Create boxplot
        boxplot(x$MF ~ sexText,
                main = "",
                xlab = "Sex", ylab = "Meal frequency", frame.plot = FALSE)
      }
    )
  }
}


#' 
#' Distribution of DDS (overall and by sex)
#'
#' @param x Indicators dataset produced by [create_op()]
#' @param save_chart Logical. Should chart be saved? Default is TRUE.
#' @param filename Prefix to add to output chart filename or a directory
#'   path to save output to instead of working directory. Default is a path to
#'   a temporary directory and a filename starting with `chart`. Ignored if
#'   `save_chart` is FALSE.
#'
#' @returns Barplot of dietary diversity score in PNG format saved in current
#'   working directory or in a specified directory if `filename` is a
#'   path unless when `save_chart` is FALSE in which case chart is shown
#'   in current graphic device.
#'
#' @examples
#'   # Create DDS chart using indicators.ALL dataset
#'   chart_dds(x = indicators.ALL)
#'
#' @export
#'

chart_dds <- function(x,
                      save_chart = TRUE,
                      filename = paste(tempdir(), "chart", sep = "/")) {
  ## Temporary variables
  sexText <- ifelse(x$sex1 == 1, "Male", "Female")

  ## Create filename
  plotFileName <- paste(filename, ".DDS.png", sep = "")

  ## Check if save_chart
  if(save_chart) {

    ## Open PNG graphics device
    grDevices::png(filename = plotFileName,
                   width = 6, height = 3.5, units = "in",
                   res = 600, pointsize = 10)

    ## Set graphical parameters
    withr::with_par(
      list(mfrow = c(1, 2),
           pty = "m",
           cex.axis = 0.8,
           mar = c(5, 4, 2, 2) + 0.1),

      {
        ## Create barplot
        barplot(fullTable(x = x$DDS,
                          values = 0:max(x$DDS)),
                main = "",
                xlab = "Dietary diversity score",
                ylab = "Frequency",
                col = "lightgray")

        ## Create boxplot
        boxplot(
          x$DDS ~ sexText,
          main = "",
          xlab = "Sex", ylab = "Dietary diversity score", 
          frame.plot = FALSE
        )
      }
    )

    ## Close graphics device
    grDevices::dev.off()
  } else {
    ## Set graphical parameters
    withr::with_par(
      list(mfrow = c(1, 2),
           pty = "m",
           cex.axis = 0.8,
           mar = c(5, 4, 2, 2) + 0.1),

      {
        ## Create barplot
        barplot(fullTable(x = x$DDS,
                          values = 0:max(x$DDS)),
                main = "",
                xlab = "Dietary diversity score",
                ylab = "Frequency",
                col = "lightgray")

        ## Create boxplot
        boxplot(
          x$DDS ~ sexText,
          main = "",
          xlab = "Sex", 
          ylab = "Dietary diversity score", 
          frame.plot = FALSE
        )
      }
    )
  }
}



#' 
#' Distribution of K6 (overall and by sex)
#'
#' @param x Indicators dataset produced by [create_op()]
#' @param save_chart Logical. Should chart be saved? Default is TRUE.
#' @param filename Prefix to add to output chart filename or a directory
#'   path to save output to instead of working directory. Defaults to a path to
#'   a temporary directory and a filename starting with `chart`. Ignored if
#'   `save_chart` is FALSE.
#'
#' @return Histogram of K6 score in PNG format saved in current
#'     working directory or in a specified directory if `filename` is a
#'     path unless when `save_chart` is FALSE in which case chart is shown
#'     in current graphics device.
#'
#' @examples
#'   # Create chart using indicators.ALL dataset
#'   chart_k6(x = indicators.ALL)
#'
#' @export
#'
#
################################################################################

chart_k6 <- function(x,
                     save_chart = TRUE,
                     filename = paste(tempdir(), "chart", sep = "/")) {
  ## Temporary variables
  sexText <- ifelse(x$sex1 == 1, "Male", "Female")

  ## Create filename
  plotFileName <- paste(filename, ".K6.png", sep = "")

  ## Check whether save_chart
  if(save_chart) {

    ## Open PNG graphics device
    grDevices::png(filename = plotFileName,
                   width = 6, height = 3.5,
                   units = "in", res = 600,
                   pointsize = 10)

    ## Set graphical parameters
    withr::with_par(
      list(mfrow = c(1, 2),
           pty = "m",
           cex.axis = 0.8,
           mar = c(5, 4, 2, 2) + 0.1),

      {
        ## Create histogram
        hist(
          x$K6, main = "", xlab = "K6", ylab = "Frequency", col = "lightgray"
        )

        ## Create boxplot
        boxplot(x$K6 ~ sexText, main = "",
                xlab = "Sex", ylab = "K6",
                frame.plot = FALSE)
      }
    )
    ## Close graphics device
    grDevices::dev.off()
  } else {
    ## Set graphical parameters
    withr::with_par(
      list(mfrow = c(1, 2),
           pty = "m",
           cex.axis = 0.8,
           mar = c(5, 4, 2, 2) + 0.1),

      {
        ## Create histogram
        hist(
          x$K6, main = "", xlab = "K6", ylab = "Frequency", col = "lightgray"
        )

        ## Create boxplot
        boxplot(x$K6 ~ sexText, main = "",
                xlab = "Sex", ylab = "K6",
                frame.plot = FALSE)
      }
    )
  }
}


#' 
#' Distribution of ADL (overall and by sex)
#'
#' @param x Indicators dataset produced by [create_op()]
#' @param save_chart Logical. Should chart be saved? Default is TRUE.
#' @param filename Prefix to add to output chart filename or a directory
#'   path to save output to instead of working directory. Defaults to a path to
#'   a temporary directory and a filename starting with `chart`. Ignored if
#'   `save_chart` is FALSE.
#'
#' @return Bar plot of ADL in PNG format saved in current working directory
#'   or in a specified directory if `filename` is a path unless when
#'   `save_chart` is FALSE in which case chart is shown in current
#'   graphic device.
#'
#' @examples
#'   # Create chart using indicators.ALL dataset
#'   chart_adl(x = indicators.ALL)
#'
#' @export
#'

chart_adl <- function(x,
                      save_chart = TRUE,
                      filename = paste(tempdir(), "chart", sep = "/")) {
  ## Temporary variables
  sexText <- ifelse(x$sex1 == 1, "Male", "Female")

  ## Create filename
  plotFileName <- paste(filename, ".ADL.png", sep = "")

  ## Check whether save_chart
  if(save_chart) {
    ## Open PNG graphics device
    grDevices::png(filename = plotFileName,
                   width = 6, height = 3.5,
                   units = "in", res = 600,
                   pointsize = 10)

    ## Set graphical parameters
    withr::with_par(
      list(mfrow = c(1, 2),
           pty = "m",
           cex.axis = 0.8,
           mar = c(5, 4, 2, 2) + 0.1),

      {
        ## Create bar plot
        barplot(fullTable(x = x$scoreADL, values = 0:6),
                main = "",
                xlab = "Katz ADL Score", ylab = "Frequency",
                col = "lightgray")

      ## Create boxplot
      boxplot(x$scoreADL ~ sexText,
              main = "",
              xlab = "Sex", ylab = "Katz ADL Score",
              frame.plot = FALSE)
      }
    )

    ## Close graphics device
    grDevices::dev.off()
  } else {
    ## Set graphical parameters
    withr::with_par(
      list(mfrow = c(1, 2),
           pty = "m",
           cex.axis = 0.8,
           mar = c(5, 4, 2, 2) + 0.1),

      {
        ## Create bar plot
        barplot(fullTable(x = x$scoreADL, values = 0:6),
                main = "",
                xlab = "Katz ADL Score", ylab = "Frequency",
                col = "lightgray")

        ## Create boxplot
        boxplot(x$scoreADL ~ sexText,
                main = "",
                xlab = "Sex", ylab = "Katz ADL Score",
                frame.plot = FALSE)
      }
    )
  }
}


#' 
#' Chart WASH indicators
#'
#' @param x Indicators dataset produced by [create_op()]
#' @param save_chart Logical. Should chart be saved? Default is TRUE.
#' @param filename Prefix to add to output chart filename or a directory
#'   path to save output to instead of working directory. Defaults to a path to
#'   a temporary directory and a filename starting with \code{chart}. Ignored if
#'   \code{save_chart} is FALSE.
#'
#' @return Bar plot of ADL in PNG format saved in current working directory
#'   or in a specified directory if \code{filename} is a path unless when
#'   \code{save_chart} is FALSE in which case chart is shown in current
#'   graphic device
#'
#' @examples
#'   # Create chart using indicators.ALL dataset
#'   chart_wash(x = indicators.ALL)
#'
#' @export
#'

chart_wash <- function(x,
                       save_chart = TRUE,
                       filename = paste(tempdir(), "chart", sep = "/")) {
  ## Create filename
  plotFileName <- paste(filename, ".WASH.png", sep = "")

  ## Tabulate WASH results - source of drinking water
  tab1 <- table(x$W1)
  names(tab1) <- c("Not improved", "Improved")

  ## Tabulate WASH results - Safe drinking water
  tab2 <- table(x$W2)
  names(tab2) <- c("Unsafe", "Safe")

  ## Tabulate WASH results - sanitation facility
  tab3 <- table(x$W3)
  names(tab3) <- c("Not improved", "Improved")

  ## Tabulate WASH results - improved non-shared sanitation facility
  tab4 <- table(x$W4)
  names(tab4) <- c("Not improved\nor shared", "Improved and\nnot shared")

  labs <- c("Source of drinking water",
            "Safe drinking water",
            "Improved sanitation facility",
            "Improved and non-shared\nsanitation facility")

  ## Check if save_chart
  if(save_chart) {
    ## Open PNG graphics device
    grDevices::png(filename = plotFileName,
                   width = 6, height = 6,
                   units = "in", res = 600,
                   pointsize = 10)

    ## Set graphical parameters
    withr::with_par(
      list(mfrow = c(2, 2),
           cex.axis = 0.8),

      for(i in seq_len(4)) {
        barplot(get(paste("tab", i, sep = "")),
                main = labs[i],
                col = c("red", "green"),
                ylab = "Frequency")
      }
    )

    ## Close graphics device
    grDevices::dev.off()
  } else {
    ## Set graphical parameters
    withr::with_par(
      list(mfrow = c(2, 2),
           cex.axis = 0.8),

      for(i in seq_len(4)) {
        barplot(get(paste("tab", i, sep = "")),
                main = labs[i],
                col = c("red", "green"),
                ylab = "Frequency")
      }
    )
  }
}


################################################################################
#
#' Chart dementia screen (CSID) indicators
#'
#' @param x Indicators dataset produced by [create_op()]
#' @param save_chart Logical. Should chart be saved? Default is TRUE.
#' @param filename Prefix to add to output chart filename or a directory
#'   path to save output to instead of working directory. Defaults to a path to
#'   a temporary directory and a filename starting with \code{chart}. Ignored if
#'   \code{save_chart} is FALSE.
#'
#' @return Bar plot of CSID in PNG format saved in current working directory
#'   or in a specified directory if \code{filename} is a path unless when
#'   \code{save_chart} is FALSE in which case chart is shown in current
#'   graphic device.
#'
#' @examples
#'   # Create chart using indicators.ALL dataset
#'   chart_csid(x = indicators.ALL)
#'
#' @export
#'
#
################################################################################

chart_csid <- function(x,
                       save_chart = TRUE,
                       filename = paste(tempdir(), "chart", sep = "/")) {
  ## Create filename
  plotFileName <- paste(filename, ".dementia.png", sep = "")

  ## Tabulate dementia score
  tab <- table(x$DS)
  names(tab) <- c("Normal", "Probable dementia")

  ## Check if save_chart
  if(save_chart) {
    ## Open PNG graphics device
    grDevices::png(filename = plotFileName,
                   width = 6, height = 6,
                   units = "in", res = 600,
                   pointsize = 10)

    ## Create barplot
    barplot(tab, main = "", col = c("green", "red"), ylab = "Frequency")

    ## Close graphics device
    grDevices::dev.off()
  } else {
    ## Create barplot
    barplot(tab, main = "", col = c("green", "red"), ylab = "Frequency")
  }
}


################################################################################
#
#' Chart disability (Washington Group - WG) indicators
#'
#' @param x Indicators dataset produced by [create_op()]
#' @param save_chart Logical. Should chart be saved? Default is TRUE.
#' @param filename Prefix to add to output chart filename or a directory
#'   path to save output to instead of working directory. Defaults to a path to
#'   a working directory and a filename starting with \code{chart}. Ignored if
#'   \code{save_chart} is FALSE.
#'
#' @return Bar plot of Disability Score in PNG format saved in current working
#'     directory or in a specified directory if \code{filename} is a path
#'     unless when \code{save_chart} is FALSE in which case chart is shown in
#'     current graphic device.
#'
#' @examples
#'   # Create chart using indicators.ALL dataset
#'   chart_wg(x = indicators.ALL)
#'
#' @export
#'
#
################################################################################

chart_wg <- function(x,
                     save_chart = TRUE,
                     filename = paste(tempdir(), "chart", sep = "/")) {
  ## Create filename
  plotFileName <- paste(filename, ".disability.png", sep = "")

  ## Tabulate WG scores by dimensions
  P0 <- table(x$wgP0)["1"]
  P1 <- table(x$wgP1)["1"]
  P2 <- table(x$wgP2)["1"]
  P3 <- table(x$wgP3)["1"]
  PM <- table(x$wgPM)["1"]
  tab <- as.table(c(P0, P1, P2, P3, PM))
  names(tab) <- c("\nP0 : None ", "\nP1 : Any", "P2 : Moderate\nor severe",
                  "\nP3 : Severe", "\nPM : Multiple")

  ## Check if save_chart
  if(save_chart) {
    ## Open PNG graphics device
    grDevices::png(filename = plotFileName,
                   width = 6, height = 6,
                   units = "in", res = 600,
                   pointsize = 10)

    ## Create barplot
    barplot(tab, main = "", col = "lightgray",
            ylab = "Frequency", cex.names = 0.8)

    ## Close graphics device
    grDevices::dev.off()
  } else {
    ## Create barplot
    barplot(tab, main = "", col = "lightgray",
            ylab = "Frequency", cex.names = 0.8)
  }
}


################################################################################
#
#' Chart household hunger scale (HHS) indicators
#'
#' @param x Indicators dataset produced by [create_op()]
#' @param save_chart Logical. Should chart be saved? Default is TRUE.
#' @param filename Prefix to add to output chart filename or a directory
#'   path to save output to instead of working directory. Defaults to a path to
#'   a temporary directory and a filename starting with \code{chart}. Ignored if
#'   \code{save_chart} is FALSE.
#'
#' @return Bar plot of HHS in PNG format saved in current working directory
#'   or in a specified directory if \code{filename} is a path unless when
#'   \code{save_chart} is FALSE in which case chart is shown in current
#'   graphic device.
#'
#' @examples
#'   # Create chart using indicators.ALL dataset
#'   chart_hhs(x = indicators.ALL)
#'
#' @export
#'
#
################################################################################

chart_hhs <- function(x,
                      save_chart = TRUE,
                      filename = paste(tempdir(), "chart", sep = "/")) {
  ## Create filename
  plotFileName <- paste(filename, ".HHS.png", sep = "")

  ## Tabulate HHS
  H0 <- table(x$HHS1)["1"]
  H1 <- table(x$HHS2)["1"]
  H2 <- table(x$HHS3)["1"]
  tab <- as.table(c(H0, H1, H2))
  names(tab) <- c("Little or none", "Moderate", "Severe")

  ## Check if save_chart
  if(save_chart) {

    ## Open PNG graphics device
    grDevices::png(filename = plotFileName,
                   width = 6, height = 6,
                   units = "in", res = 600,
                   pointsize = 10)

    ## Create bar plot
    barplot(tab, main = "", col = c("green", "orange", "red"),
            ylab = "Frequency", cex.names = 0.8)

    ## Close graphics device
    grDevices::dev.off()
  } else {
    ## Create bar plot
    barplot(tab, main = "", col = c("green", "orange", "red"),
            ylab = "Frequency", cex.names = 0.8)
  }
}


################################################################################
#
#' Chart income indicators
#'
#' @param x.male Male subset of indicator dataset
#' @param x.female Female subset of indicator dataset
#' @param save_chart Logical. Should chart be saved? Default is TRUE.
#' @param filename Prefix to add to output chart filename or a directory
#'   path to save output to instead of working directory. Defaults to a path to
#'   a temporary directory and a filename starting with \code{chart}. Ignored if
#'   \code{save_chart} is FALSE.
#'
#' @return Bar chart of sources of income by sex in PNG format saved in current
#'   working directory or in a specified directory if \code{filename} is a path
#'   unless when \code{save_chart} is FALSE in which case chart is shown in
#'   current graphics device.
#'
#' @examples
#'   # Create chart using indicators.FEMALES and indicators.MALES
#'   # dataset
#'   chart_income(x.male = indicators.MALES,
#'                x.female = indicators.FEMALES)
#'
#' @export
#'
#
################################################################################

chart_income <- function(x.male,
                         x.female,
                         save_chart = TRUE,
                         filename = paste(tempdir(), "chart", sep = "/")) {

  ## Sources of income (by sex)
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

  ## Merge data for males (tabM) and females (tabF)
  tab <- data.frame(tabM, tabF)
  names(tab) <- c("M", "F")
  tab$SUM <- tab$M + tab$F

  ## Label rows with income source
  rownames(tab) <- c("Agriculture / fishing / livestock",
                     "Wage / salary",
                     "Sales of charcoal / bricks / &c.",
                     "Trading (e.g. market or shop)",
                     "Investments",
                     "Spending savings / sales of assets",
                     "Charity",
                     "Cash transfer / social security",
                     "Other source(s) of income")

  ## Sort by frequency of income source (descending)
  tab <- tab[rev(order(tab$SUM)), ]

  ## Convert data.frame to a table for plotting using the 'barplot()' function
  tab <- as.table(as.matrix(tab[ ,1:2]))

  ## Plot income sources by sex
  plotFileName <- paste(filename, ".incomes.png", sep = "")

  ## Check if save_chart
  if(save_chart) {

    ## Open graphics device
    grDevices::png(filename = plotFileName, width = 6, height = 6,
                   units = "in", res = 600, pointsize = 10)

    ## Set plot paramaters
    withr::with_par(
      list(pty = "m",
           las = 1,
           cex.axis = 0.8,
           mar = c(3, 12, 2, 2) + 0.1),

      ## Create plot
      barplot(t(tab),
              col = c("lightgray", "white"),
              horiz = TRUE, main = "",
              xlab = "Frequency (males are shaded)",
              ylab = "")
    )

    ## Close graphics device
    grDevices::dev.off()
  } else {
    ## Set plot paramaters
    withr::with_par(
      list(pty = "m",
           las = 1,
           cex.axis = 0.8,
           mar = c(3, 12, 2, 2) + 0.1),

      ## Create plot
      barplot(t(tab),
              col = c("lightgray", "white"),
              horiz = TRUE, main = "",
              xlab = "Frequency (males are shaded)",
              ylab = "")
    )
  }
}
