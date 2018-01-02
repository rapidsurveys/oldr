################################################################################
#
#' fullTable
#'
#' Fill out a one-dimensional table to include a specified range of values
#'
#' @param x A vector to tabulate
#' @param values A vector of values to be inlcuded in a table
#' @return A one-dimensional table with specified values
#' @examples
#'
#'   xTable <- fullTable(x = sample(100),
#'                       values = paste("a", 1:100, sep = ""))
#'   xTable
#'
fullTable <- function(x, values) {
  tab <- NULL
  for(i in values) {
    tab <-c(tab, table(x)[as.character(i)])
  }
  tab[is.na(tab)] <- 0
  names(tab) <- as.character(values)
  return(tab)
}
