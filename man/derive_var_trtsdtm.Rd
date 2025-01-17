% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/derive_var_trtsdtm.R
\name{derive_var_trtsdtm}
\alias{derive_var_trtsdtm}
\title{Derive Datetime of First Exposure to Treatment}
\usage{
derive_var_trtsdtm(
  dataset,
  dataset_ex,
  filter_ex = (EXDOSE > 0 | (EXDOSE == 0 & str_detect(EXTRT, "PLACEBO"))) &
    nchar(EXSTDTC) >= 10,
  subject_keys = vars(STUDYID, USUBJID)
)
}
\arguments{
\item{dataset}{Input dataset

The variables specified by the \code{by_vars} parameter are expected.}

\item{dataset_ex}{\code{ex} dataset

The variables \code{EXSTDTC}, \code{EXSEQ}, and those specified by the \code{filter_ex}
parameter are expected.}

\item{filter_ex}{Filter condition for the ex dataset

Only observations of the ex dataset which fulfill the specified condition
are considered for the treatment start date.

Default: \verb{EXDOSE > 0 | (EXDOSE == 0 & str_detect(EXTRT, 'PLACEBO')}

Permitted Values: logical expression}

\item{subject_keys}{Variables to uniquely identify a subject

A list of quosures where the expressions are symbols as returned by
\code{vars()} is expected.}
}
\value{
The input dataset with \code{TRTSDTM} variable added
}
\description{
Derives datetime of first exposure to treatment (\code{TRTSDTM})
}
\details{
For each group (with respect to the variables specified for the
\code{by_vars} parameter) the first observation (with respect to the order
specified for the \code{order} parameter) is included in the output dataset.
}
\examples{
library(dplyr, warn.conflicts = FALSE)
library(admiral.test)
data("ex")
data("dm")

dm \%>\%
  derive_var_trtsdtm(dataset_ex = ex) \%>\%
  select(USUBJID, TRTSDTM)
}
\author{
Stefan Bundfuss
}
\keyword{adsl}
\keyword{derivation}
\keyword{timing}
