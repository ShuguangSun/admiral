% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/derive_date_vars.R
\name{compute_tmf}
\alias{compute_tmf}
\title{Derive the Time Imputation Flag}
\usage{
compute_tmf(dtc, dtm)
}
\arguments{
\item{dtc}{The date character vector (\code{'--DTC'}).

A character date is expected in a format like \code{yyyy-mm-ddThh:mm:ss} (partial or complete).}

\item{dtm}{The Date vector to compare (\code{'--DTM'}).

A datetime object is expected.}
}
\value{
The time imputation flag (\code{'--TMF'}) (character value of \code{'H'}, \code{'M'} , \code{'S'} or \code{NA})
}
\description{
Derive the time imputation flag (\code{'--TMF'}) comparing a date character vector
(\code{'--DTC'}) with a Datetime vector (\code{'--DTM'}).
}
\examples{
compute_tmf(dtc = "2019-07-18T15:25", dtm = as.POSIXct("2019-07-18T15:25:00"))
compute_tmf(dtc = "2019-07-18T15", dtm = as.POSIXct("2019-07-18T15:25:00"))
compute_tmf(dtc = "2019-07-18", dtm = as.POSIXct("2019-07-18"))
}
\author{
Samia Kabi
}
\keyword{computation}
\keyword{timing}
