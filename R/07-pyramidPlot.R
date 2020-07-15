###############################################################################
#
#' Function to create a pyramid plot
#'
#' @param x A vector (numeric, factor, character) holding age-groups
#' @param g A binary categorical variable (usually sex)
#' @param main Plot title
#' @param xlab x-axis label
#' @param ylab y-axis label
#'
#' @return Pyramid plot
#'
#' @examples
#' \dontrun{
#'   pyramid.plot(x = testSVY, g = "sex")
#' }
#'
#' @export
#'
#
################################################################################

pyramid.plot <- function(x,
                         g,
                         main = paste("Pyramid plot of",
                                      deparse(substitute(x)), "by",
                                      deparse(substitute(g))),
                         xlab = paste(deparse(substitute(g)),
                                      "(", levels(g)[1], "/", levels(g)[2],")"),
                         ylab = deparse(substitute(x))) {
  tab <- table(x, g); tab[ ,1] <- -tab[ ,1]
  barplot(tab,
          horiz = TRUE,
          beside = TRUE,
          space = c(0, -nrow(tab)),
          names.arg = c(dimnames(tab)$x, dimnames(tab)$x),
          xlim = c(min(tab) * 1.2, max(tab) * 1.2),
          col = "white",
          main = main,
          xlab = xlab,
          ylab = ylab,
          axes = FALSE)
  axis(side = 1,
       labels = abs(axTicks(side = 1)),
       at = (axTicks(side = 1)))
}
