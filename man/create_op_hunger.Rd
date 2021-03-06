% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/01-opIndicators.R
\name{create_op_hunger}
\alias{create_op_hunger}
\title{Create older people indicators for severe food insecurity from survey data
collected using the standard RAM-OP questionnaire}
\usage{
create_op_hunger(svy)
}
\arguments{
\item{svy}{A dataframe collected using the standard RAM-OP questionnaire}
}
\value{
A dataframe of older people indicators on household hunger
}
\description{
Create older people indicators for severe food insecurity from survey data
collected using the standard RAM-OP questionnaire
}
\section{Household Hunger Scale (HHS)}{


The HHS is described in:

\cite{Ballard T, Coates J, Swindale A, Deitchler M (2011). Household Hunger
Scale: Indicator Definition and Measurement Guide. Washington DC,
FANTA-2 Bridge, FHI 360
\url{https://www.fantaproject.org/monitoring-and-evaluation/household-hunger-scale-hhs}}

\describe{
\item{\code{HHS1}}{Little or no hunger in household}
\item{\code{HHS2}}{Moderate hunger in household}
\item{\code{HHS3}}{Severe hunger in household}
}
}

\examples{
# Create household hunger indicators dataset from RAM-OP survey data
# collected from Addis Ababa, Ethiopia
create_op_hunger(testSVY)

}
\author{
Mark Myatt
}
