#' 
#' Apply bootstrap to RAM-OP indicators using a PROBIT estimator.
#'
#' @param x Indicators dataset produced by [create_op()] with primary sampling
#'   unit (PSU) in column named *"psu"*.
#' @param w A data frame with primary sampling unit (PSU) in column named
#'   *"psu"* and survey weight (i.e. PSU population) in column named *"pop"*.
#' @param gam.stat A function operating on data in `x` to estimate GAM 
#'   prevalence for older people. Fixed to [probit_gam()].
#' @param sam.stat A function operating on data in `x` to estimate
#'   SAM prevalence for older people. Fixed to [probit_sam()].
#' @param params Parameters (named columns in `x`) passed to the function
#'   specified in `statistic`; fixed to *"MUAC"* as indicator amenable
#'   to probit estimation.
#' @param outputColumns Names of columns in output data frame.
#' @param replicates Number of bootstrap replicate case and non-case.
#'
#' @returns A [tibble::tibble()] of boot estimates using PROBIT.
#'
#' @examples
#' test <- estimate_probit(x = indicators.ALL, w = testPSU, replicates = 3)
#'
#' test
#'
#' @export
#'

estimate_probit <- function(x,
                            w,
                            gam.stat = probit_gam,
                            sam.stat = probit_sam,
                            params = "MUAC",
                            outputColumns = params,
                            replicates = 399) {
  ## Blocking weighted bootstrap (GAM) - ALL
  bootGAM.ALL <- bbw::bootBW(
    x = x, w = w, statistic = gam.stat, params = params, 
    outputColumns = params, replicates = replicates
  )

  ## Blocking weighted bootstrap (GAM) - MALES
  bootGAM.MALES <- bbw::bootBW(
    x = x[x$sex1 == 1, ], w = w, statistic = gam.stat, params = params,
    outputColumns = params, replicates = replicates
  )

  ## Blocking weighted bootstrap (GAM) - FEMALES
  bootGAM.FEMALES <- bbw::bootBW(
    x = x[x$sex2 == 1, ], w = w, statistic = gam.stat, params = params,
    outputColumns = params, replicates = replicates
  )

  ## Rename results
  names(bootGAM.ALL) <- names(bootGAM.MALES) <- names(bootGAM.FEMALES) <- "GAM"

  ## Blocking weighted bootstrap (SAM) - ALL
  bootSAM.ALL <- bbw::bootBW(
    x = x, w = w, statistic = sam.stat, params = params,
    outputColumns = params, replicates = replicates
  )

  ## Blocking weighted bootstrap (SAM) - MALES
  bootSAM.MALES <- bbw::bootBW(
    x = x[x$sex1 ==1, ], w = w, statistic = sam.stat, params = params,
    outputColumns = params, replicates = replicates
  )

  ## Blocking weighted bootstrap (SAM) - FEMALES
  bootSAM.FEMALES <- bbw::bootBW(
    x = x[x$sex2 ==1, ], w = w, statistic = sam.stat, params = params,
    outputColumns = params, replicates = replicates
  )

  ## Rename results
  names(bootSAM.ALL) <- names(bootSAM.MALES) <- names(bootSAM.FEMALES) <- "SAM"

  ## MAM is GAM - SAM
  bootMAM.ALL <- bootGAM.ALL - bootSAM.ALL
  bootMAM.MALES <- bootGAM.MALES - bootSAM.MALES
  bootMAM.FEMALES <- bootGAM.FEMALES - bootSAM.FEMALES
  names(bootMAM.ALL) <- names(bootMAM.MALES) <- names(bootMAM.FEMALES) <- "MAM"

  ## Fix for MAM < 0 (may occur if bootstrap GAM < bootstrap SAM)
  bootMAM.ALL$MAM[bootMAM.ALL$MAM < 0] <- 0
  bootMAM.MALES$MAM[bootMAM.MALES$MAM < 0] <- 0
  bootMAM.FEMALES$MAM[bootMAM.FEMALES$MAM < 0] <- 0

  ## Combine 'bootGAM.*', 'bootMAM.*', and 'bootSAM.*'
  ## data.frames (ALL, MALES, FEMALES)
  boot.ALL <- data.frame(bootGAM.ALL, bootMAM.ALL, bootSAM.ALL)
  boot.MALES <- data.frame(bootGAM.MALES, bootMAM.MALES, bootSAM.MALES)
  boot.FEMALES <- data.frame(bootGAM.FEMALES, bootMAM.FEMALES, bootSAM.FEMALES)

  ## Clean-up
  rm(bootGAM.ALL, bootMAM.ALL, bootSAM.ALL,
     bootGAM.MALES, bootMAM.MALES, bootSAM.MALES,
     bootGAM.FEMALES, bootMAM.FEMALES, bootSAM.FEMALES)

  ## Extract estimates from 'boot.ALL' data.frames
  estimates.ALL <- data.frame(
    t(
      apply(
        X = boot.ALL, MARGIN = 2, FUN = quantile, 
        probs = c(0.025, 0.5, 0.975), na.rm = TRUE
      )
    )
  )

  ## Extract estimates from 'boot.MALES' data.frames
  estimates.MALES <- data.frame(
    t(
      apply(
        X = boot.MALES, MARGIN = 2, FUN = quantile,
        probs = c(0.025, 0.5, 0.975), na.rm = TRUE
      )
    )
  )

  ## Extract estimates from 'boot.FEMALES' data.frames
  estimates.FEMALES <- data.frame(
    t(
      apply(
        X = boot.FEMALES, MARGIN = 2, FUN = quantile,
        probs = c(0.025, 0.5, 0.975), na.rm = TRUE
      )
    )
  )

  ## Join 'estimates.*' data.frames side-by-side
  probitEstimates <- data.frame(
    estimates.ALL, estimates.MALES, estimates.FEMALES
  )

  ## Clean-up row and column names
  probitEstimates$indicator <- row.names(probitEstimates)
  row.names(probitEstimates) <- NULL
  names(probitEstimates) <- c(
    "LCL.ALL", "EST.ALL", "UCL.ALL", "LCL.MALES", "EST.MALES", "UCL.MALES",
    "LCL.FEMALES", "EST.FEMALES", "UCL.FEMALES", "INDICATOR"
  )

  ## Re-order columns
  col_order <- c(
    "INDICATOR", 
    "EST.ALL", "LCL.ALL", "UCL.ALL",
    "EST.MALES", "LCL.MALES", "UCL.MALES",
    "EST.FEMALES", "LCL.FEMALES", "UCL.FEMALES"
  )

  probitEstimates <- probitEstimates[ , col_order]

  ## Convert to tibble
  probitEstimates <- tibble::tibble(probitEstimates)

  ## Return probitEstimates
  probitEstimates
}
