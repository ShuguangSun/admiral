% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/assertions.R
\name{is_timeunit}
\alias{is_timeunit}
\title{Is Time Unit?}
\usage{
is_timeunit(arg)
}
\arguments{
\item{arg}{The argument to check}
}
\value{
\code{TRUE} if the argument is a time unit, \code{FALSE} otherwise
}
\description{
Checks if a string is a time unit, i.e., 'years', 'months', 'days', 'hours',
'minutes', or 'seconds'.
}
\examples{
unit <- "days"
assertthat::assert_that(admiral:::is_timeunit(unit))
}
\author{
Stefan Bundfuss
}
\keyword{check}
