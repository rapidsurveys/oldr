#' 
#' Concatenate classic and PROBIT estimates into a single data.frame
#'
#' @param x Classic estimates data frame
#' @param y Probit estimates data frame
#' @param prop2percent Logical. Should proportion type indicators be converted
#'   to percentage? Default is FALSE.
#'
#' @return Data frame of combined classic and probit estimates
#'
#' @author Ernest Guevarra
#'
#' @examples
#'   #
#'   \dontrun{
#'   test <- merge_estimates(x = classicEstimates,
#'                           y = probitEstimates)
#'   }
#'
#' @export
#'

merge_estimates <- function(x, y, prop2percent = FALSE) {

  ## Merge rows
  estimates <- rbind(x, y)

  ## Merge 'estimates' data.frame and 'language' data.frame in preparation for
  ## reporting and maintaining the original row ordering of the 'language'
  ## data.frame ...
  temp <- subset(language, subset = language$INDICATOR %in% estimates$INDICATOR)

  temp$originalOrder <- seq_len(nrow(estimates))

  estimates <- merge(temp, estimates, by = "INDICATOR")
  estimates <- estimates[order(estimates$originalOrder), ]
  estimates <- subset(estimates, select = -originalOrder)

  if (prop2percent) {
    estimates$EST.ALL <- ifelse(
      estimates$TYPE == "Proportion", 
      estimates$EST.ALL * 100, 
      estimates$EST.ALL
    )
    
    estimates$LCL.ALL <- ifelse(
      estimates$TYPE == "Proportion",
      estimates$LCL.ALL * 100, 
      estimates$LCL.ALL
    )
    
    estimates$UCL.ALL <- ifelse(
      estimates$TYPE == "Proportion",
      estimates$UCL.ALL * 100,
      estimates$UCL.ALL
    )

    estimates$EST.MALES <- ifelse(
      estimates$TYPE == "Proportion",
      estimates$EST.MALES * 100, 
      estimates$EST.MALES
    )
    
    estimates$LCL.MALES <- ifelse(
      estimates$TYPE == "Proportion",
      estimates$LCL.MALES * 100, 
      estimates$LCL.MALES
    )
    
    estimates$UCL.MALES <- ifelse(
      estimates$TYPE == "Proportion",
      estimates$UCL.MALES * 100, 
      estimates$UCL.MALES
    )
    
    estimates$EST.FEMALES <- ifelse(
      estimates$TYPE == "Proportion",
      estimates$EST.FEMALES * 100, 
      estimates$EST.FEMALES
    )
    
    estimates$LCL.FEMALES <- ifelse(
      estimates$TYPE == "Proportion",
      estimates$LCL.FEMALES * 100, 
      estimates$LCL.FEMALES
    )
    
    estimates$UCL.FEMALES <- ifelse(
      estimates$TYPE == "Proportion",
      estimates$UCL.FEMALES * 100, 
      estimates$UCL.FEMALES
    )
  }

  ## Convert to tibble
  estimates <- tibble::tibble(estimates)

  ## Return
  estimates
}


#' 
#' Fill out a one-dimensional table to include a specified range of values
#'
#' @param x A vector to tabulate
#' @param values A vector of values to be included in a table
#'
#' @return A one-dimensional table with specified values
#'
#' @author Mark Myatt
#' 
#' @keywords internal
#'

fullTable <- function(x, values) {
  tab <- NULL
  for(i in values) {
    tab <-c(tab, table(x)[as.character(i)])
  }
  tab[is.na(tab)] <- 0
  names(tab) <- as.character(values)
  tab
}


#' 
#' Get appropriate RAM-OP indicator variable names given a specified indicator
#' set
#'
#' @param indicators A character vector of indicator set names. Indicator set
#'   names are *"demo"*, *"food"*, *"hunger"*, *"disability"*, *"adl"*,
#'   *"mental"*, *"dementia"*, *"health"*, *"income"*, *"wash"*, *"anthro"*, 
#'   *"screening"*, *"visual"*, and *"misc"*. Default is all indicator sets.
#'
#' @return A vector of variable names
#'
#' @keywords internal
#'

get_variables <- function(indicators = c("demo", "food", "hunger", "adl",
                                         "disability", "mental", "dementia",
                                         "health", "income", "wash", "anthro",
                                         "oedema", "screening", "visual", 
                                         "misc")) {
  vars <- NULL
  
  if ("demo" %in% indicators) {
    vars <- c(
      vars, "resp1", "resp2", "resp3", "resp4", "age", "ageGrp1", "ageGrp2", 
      "ageGrp3", "ageGrp4", "ageGrp5", "sex1", "sex2", "marital1", "marital2", 
      "marital3", "marital4", "marital5", "marital6", "alone"
    )
  }
  
  if ("food" %in% indicators) {
    vars <- c(
      vars, "MF", "DDS", "FG01", "FG02", "FG03", "FG04", "FG05", "FG06", "FG07", 
      "FG08", "FG09", "FG10", "FG11", "proteinRich", "pProtein", "aProtein", 
      "pVitA", "aVitA", "xVitA", "ironRich", "caRich", "znRich", "vitB1", 
      "vitB2", "vitB3", "vitB6", "vitB12", "vitBcomplex"
    )
  }

  
  if ("hunger" %in% indicators) vars <- c(vars, "HHS1", "HHS2", "HHS3")

  if ("adl" %in% indicators) {
    vars <- c(vars, "ADL01", "ADL02", "ADL03", "ADL04", "ADL05", "ADL06",
              "scoreADL", "classADL1", "classADL2", "classADL3", "hasHelp",
              "unmetNeed")
  }
  
  if ("disability" %in% indicators) {
    vars <- c(
      vars, "wgVisionD0", "wgVisionD1", "wgVisionD2", "wgVisionD3", 
      "wgHearingD0", "wgHearingD1", "wgHearingD2", "wgHearingD3", 
      "wgMobilityD0", "wgMobilityD1", "wgMobilityD2", "wgMobilityD3",
      "wgRememberingD0", "wgRememberingD1", "wgRememberingD2", 
      "wgRememberingD3", "wgSelfCareD0", "wgSelfCareD1", "wgSelfCareD2",
      "wgSelfCareD3", "wgCommunicatingD0", "wgCommunicatingD1",
      "wgCommunicatingD2", "wgCommunicatingD3", "wgP0", "wgP1", "wgP2", "wgP3", 
      "wgPM"
    )
  }
  
  if ("mental" %in% indicators) vars <- c(vars, "K6", "K6Case")
  
  if ("dementia" %in% indicators) vars <- c(vars, "DS")
  
  if ("health" %in% indicators) {
    vars <- c(
      vars, "H1", "H2", "H31", "H32", "H33", "H34", "H35", "H36", "H37", "H38", 
      "H39", "H4", "H5", "H61", "H62", "H63", "H64", "H65", "H66", "H67", "H68", 
      "H69"
    )
  }
  
  if ("income" %in% indicators) {
    vars <- c(
      vars, "M1", "M2A", "M2B", "M2C", "M2D", "M2E", "M2F", "M2G", "M2H", "M2I"
    )
  }
  
  if ("wash" %in% indicators) vars <- c(vars, "W1", "W2", "W3", "W4")
    
  if ("anthro" %in% indicators) vars <- c(vars, "MUAC")
  
  if ("oedema" %in% indicators) vars <- c(vars, "oedema")
  
  if ("screening" %in% indicators) vars <- c(vars, "screened")

  if ("visual" %in% indicators) vars <- c(vars, "poorVA")

  if ("misc" %in% indicators) vars <- c(vars, "chew", "food", "NFRI")

  ## Return vars ----
  vars
}
