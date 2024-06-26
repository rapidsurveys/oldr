% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/01-opIndicators.R
\name{create_op_disability}
\alias{create_op_disability}
\title{Create older people indicators dataframe on disability from survey data
collected using the standard RAM-OP questionnaire}
\usage{
create_op_disability(svy)
}
\arguments{
\item{svy}{A dataframe collected using the standard RAM-OP questionnaire}
}
\value{
A tibble of older people indicators on disability
}
\description{
Create older people indicators dataframe on disability from survey data
collected using the standard RAM-OP questionnaire
}
\section{Washington Group on Disability}{


See:

\url{https://www.washingtongroup-disability.com}
\url{https://www.cdc.gov/nchs/washington_group/wg_documents.htm}

for details.

\describe{
\item{\code{wgVisionD0}}{Vision domain 0}
\item{\code{wgVisionD1}}{Vision domain 1}
\item{\code{wgVisionD2}}{Vision domain 2}
\item{\code{wgVisionD3}}{Vision domain 3}
\item{\code{wgHearingD0}}{Hearing domain 0}
\item{\code{wgHearingD1}}{Hearing domain 1}
\item{\code{wgHearingD2}}{Hearing domain 2}
\item{\code{wgHearingD3}}{Hearing domain 3}
\item{\code{wgMobilityD0}}{Mobility domain 0}
\item{\code{wgMobilityD1}}{Mobility domain 1}
\item{\code{wgMobilityD2}}{Mobility domain 2}
\item{\code{wgMobilityD3}}{Mobility domain 3}
\item{\code{wgRememberingD0}}{Remembering domain 0}
\item{\code{wgRememberingD1}}{Remembering domain 1}
\item{\code{wgRememberingD2}}{Remembering domain 2}
\item{\code{wgRememberingD3}}{Remembering domain 3}
\item{\code{wgSelfCareD0}}{Self-care domain 0}
\item{\code{wgSelfCareD1}}{Self-care domain 1}
\item{\code{wgSelfCareD2}}{Self-care domain 2}
\item{\code{wgSelfCareD3}}{Self-care domain 3}
\item{\code{wgCommunicatingD0}}{Communication domain 0}
\item{\code{wgCommunicatingD1}}{Communication domain 1}
\item{\code{wgCommunicatingD2}}{Communication domain 2}
\item{\code{wgCommunicatingD3}}{Communication domain 3}
\item{\code{wgP0}}{Overall 0}
\item{\code{wgP1}}{Overall 1}
\item{\code{wgP2}}{Overall 2}
\item{\code{wgP3}}{Overall 3}
\item{\code{wgPM}}{Any disability}
}
}

\examples{
# Create disability indicators dataset from RAM-OP survey data
# collected from Addis Ababa, Ethiopia
create_op_disability(testSVY)

}
\author{
Mark Myatt
}
