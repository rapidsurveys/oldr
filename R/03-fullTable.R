################################################################################
#
#' Fill out a one-dimensional table to include a specified range of values
#'
#' @param x A vector to tabulate
#' @param values A vector of values to be inlcuded in a table
#' @return A one-dimensional table with specified values
#' @examples
#'
#'   xTable <- fullTable(x = sample(x = 5,
#'                                  size = 100,
#'                                  replace = TRUE),
#'                       values = 1:5)
#'   xTable
#' @export
#'
#
################################################################################

fullTable <- function(x, values) {
  tab <- NULL
  for(i in values) {
    tab <-c(tab, table(x)[as.character(i)])
  }
  tab[is.na(tab)] <- 0
  names(tab) <- as.character(values)
  return(tab)
}
