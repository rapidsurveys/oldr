################################################################################
#
#' PROBIT statistics function for bootstrap estimation of older people GAM
#'
#' @param x A data frame with \code{primary sampling unit (PSU)} in column named
#'   \code{psu} and with data column/s containing the continuous variable/s of
#'   interest with column names corresponding to \code{params} values
#' @param params A vector of column names corresponding to the continuous
#'   variables of interest contained in \code{x}
#' @param threshold cut-off value for continuous variable to differentiate
#'   case and non-case. Default is set at 210.
#'
#' @return A numeric vector of the PROBIT estimate of each continuous variable
#'   of interest with length equal to \code{length(params)}
#'
#' @examples
#'
#' # Example call to bootBW function:
#'
#' probit_gam(x = indicators.ALL,
#'            params = "MUAC",
#'            threshold = 210)
#'
#' @export
#'
#
################################################################################

probit_gam <- function(x, params, threshold = 210) {
  ## Get data
  d <- x[[params[1]]]

  ## Shift data to the left to avoid "comutation instability" when :
  ##   max(x) / min(x)
  ## is small (i.e. close to unity).
  shift <- min(min(d, na.rm = TRUE), threshold) - 1
  d <- d - shift
  threshold <- threshold - shift

  ## Box-cox transformation
  lambda <- car::powerTransform(d)$lambda
  d <- car::bcPower(d, lambda)
  threshold <- car::bcPower(threshold, lambda)
  m <- mean(d, na.rm = TRUE)
  s <- stats::sd(d, na.rm = T)

  ## PROBIT estimate
  x <- stats::pnorm(q = threshold, mean = m, sd = s)

  ## Return x
  return(x)
}


################################################################################
#
#' PROBIT statistics function for bootstrap estimation of older people SAM
#'
#' @param x A data frame with \code{primary sampling unit (PSU)} in column named
#'   \code{psu} and with data column/s containing the continuous variable/s of
#'   interest with column names corresponding to \code{params} values
#' @param params A vector of column names corresponding to the continuous
#'   variables of interest contained in \code{x}
#' @param threshold cut-off value for continuous variable to differentiate an
#'   older people with SAM to those with no SAM. Default is set at 185.
#'
#' @return A numeric vector of the PROBIT estimate of each continuous variable
#'   of interest with length equal to \code{length(params)}
#'
#' @examples
#'
#' # Example call to bootBW function:
#'
#' probit_sam(x = indicators.ALL,
#'            params = "MUAC",
#'            threshold = 185)
#'
#' @export
#'
#
################################################################################

probit_sam <- function(x, params, threshold = 185) {
  ## Get data
  d <- x[[params[1]]]

  ## Shift data to the left to avoid "comutation instability" when :
  ##   max(x) / min(x)
  ## is small (i.e. close to unity).
  shift <- min(min(d, na.rm = TRUE), threshold) - 1
  d <- d - shift
  threshold <- threshold - shift

  ## Box-cox transformation
  lambda <- car::powerTransform(d)$lambda
  d <- car::bcPower(d, lambda)
  threshold <- car::bcPower(threshold, lambda)
  m <- mean(d, na.rm = TRUE)
  s <- stats::sd(d, na.rm = T)

  ## PROBIT estimate
  x <- stats::pnorm(q = threshold, mean = m, sd = s)

  ## Return x
  return(x)
}
