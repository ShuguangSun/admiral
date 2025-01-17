% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/derive_vars_duration.R
\name{derive_vars_duration}
\alias{derive_vars_duration}
\title{Derive Duration}
\usage{
derive_vars_duration(
  dataset,
  new_var,
  new_var_unit = NULL,
  start_date,
  end_date,
  in_unit = "days",
  out_unit = "days",
  floor_in = TRUE,
  add_one = TRUE,
  trunc_out = FALSE
)
}
\arguments{
\item{dataset}{Input dataset

The columns specified by the \code{start_date} and the \code{end_date} parameter are
expected.}

\item{new_var}{Name of variable to create}

\item{new_var_unit}{Name of the unit variable
If the parameter is not specified, no variable for the unit is created.}

\item{start_date}{The start date

A date or date-time object is expected.}

\item{end_date}{The end date

A date or date-time object is expected.}

\item{in_unit}{Input unit

See floor_in and add_one parameter for details.

Default: 'days'

Permitted Values: 'years', 'months', 'days', 'hours', 'minutes', 'seconds'}

\item{out_unit}{Output unit

The duration is derived in the specified unit

Default: 'days'

Permitted Values: 'years', 'months', 'days', 'hours', 'minutes', 'seconds'}

\item{floor_in}{Round down input dates?

The input dates are round down with respect to the input unit, e.g., if the
input unit is 'days', the time of the input dates is ignored.

Default: `TRUE``

Permitted Values: \code{TRUE}, \code{FALSE}}

\item{add_one}{Add one input unit?

If the duration is non-negative, one input unit is added. I.e., the
duration can not be zero.

Default: \code{TRUE}
Permitted Values: \code{TRUE}, \code{FALSE}}

\item{trunc_out}{Return integer part

The fractional part of the duration (in output unit) is removed, i.e., the
integer part is returned.

Default: \code{FALSE}

Permitted Values: \code{TRUE}, \code{FALSE}}
}
\value{
The input dataset with the duration and unit variable added
}
\description{
Derives duration between two dates, e.g., duration of adverse events, relative
day, age, ...
}
\details{
The duration is derived as time from start to end date in the
specified output unit. If the end date is before the start date, the duration
is negative.
}
\examples{
data <- tibble::tribble(
  ~BRTHDT, ~RANDDT,
  lubridate::ymd("1984-09-06"), lubridate::ymd("2020-02-24")
)

derive_vars_duration(data,
  new_var = AAGE,
  new_var_unit = AAGEU,
  start_date = BRTHDT,
  end_date = RANDDT,
  out_unit = "years",
  add_one = FALSE,
  trunc_out = TRUE
)
}
\seealso{
\code{\link[=compute_duration]{compute_duration()}}
}
\author{
Stefan Bundfuss
}
\keyword{adam}
\keyword{derivation}
\keyword{timing}
