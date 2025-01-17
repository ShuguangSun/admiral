.datasets <- new.env(parent = emptyenv())

#' Get Duplicate Records that Lead to a Prior Error
#'
#' @export
#'
#' @author Thomas Neitmann
#'
#' @details
#' Many {admiral} function check that the input dataset contains only one record
#' per `by_vars` group and throw an error otherwise. The `get_duplicates_dataset()`
#' function allows one to retrieve the duplicate records that lead to an error.
#'
#' Note that the function always returns the dataset of duplicates from the last
#' error that has been thrown in the current R session. Thus, after restarting the
#' R sessions `get_duplicates_dataset()` will return `NULL` and after a second error
#' has been thrown, the dataset of the first error can no longer be accessed (unless
#' it has been saved in a variable).
#'
#' @keywords user_utility
#'
#' @examples
#' data(adsl)
#'
#' # Duplicate the first record
#' adsl <- rbind(adsl[1L, ], adsl)
#'
#' signal_duplicate_records(adsl, vars(USUBJID), cnd_type = "warning")
#'
#' get_duplicates_dataset()
get_duplicates_dataset <- function() {
  .datasets$duplicates
}

#' Extract Duplicate Records
#'
#' @param dataset A data frame
#' @param by_vars A list of variables created using `vars()` identifying groups of
#'   records in which to look for duplicates
#'
#' @export
#' @keywords dev_utility
#' @author Thomas Neitmann
#'
#' @examples
#' data(adsl)
#'
#' # Duplicate the first record
#' adsl <- rbind(adsl[1L, ], adsl)
#'
#' extract_duplicate_records(adsl, vars(USUBJID))
extract_duplicate_records <- function(dataset, by_vars) {
  assert_that(
    is.data.frame(dataset),
    is_vars(by_vars)
  )

  data_by <- dataset %>%
    ungroup() %>%
    select(!!!by_vars)

  is_duplicate <- duplicated(data_by) | duplicated(data_by, fromLast = TRUE)

  dataset %>%
    ungroup() %>%
    select(!!!by_vars, dplyr::everything()) %>%
    filter(is_duplicate) %>%
    arrange(!!!by_vars)
}

#' Signal Duplicate Records
#'
#' @param dataset A data frame
#' @param by_vars A list of variables created using `vars()` identifying groups of
#'   records in which to look for duplicates
#' @param msg The condition message
#' @param cnd_type Type of condition to signal when detecting duplicate records.
#'   One of `"message"`, `"warning"` or `"error"`. Default is `"error"`.
#'
#' @export
#' @keywords dev_utility
#' @author Thomas Neitmann
#'
#' @examples
#' data(adsl)
#'
#' # Duplicate the first record
#' adsl <- rbind(adsl[1L, ], adsl)
#'
#' signal_duplicate_records(adsl, vars(USUBJID), cnd_type = "message")
signal_duplicate_records <- function(dataset,
                                     by_vars,
                                     msg = paste("Dataset contains duplicate records with respect to", enumerate(vars2chr(by_vars))), # nolint
                                     cnd_type = "error") {
  assert_that(
    is.data.frame(dataset),
    is_vars(by_vars),
    rlang::is_scalar_character(msg),
    rlang::is_scalar_character(cnd_type)
  )
  cnd_funs <- list(message = inform, warning = warn, error = abort)
  arg_match(cnd_type, names(cnd_funs))

  duplicate_records <- extract_duplicate_records(dataset, by_vars)
  if (nrow(duplicate_records) >= 1L) {
    .datasets$duplicates <- structure(
      duplicate_records,
      class = union("duplicates", class(duplicate_records)),
      by_vars = vars2chr(by_vars)
    )
    full_msg <- paste0(msg, "\nRun `get_duplicates_dataset()` to access the duplicate records")
    cnd_funs[[cnd_type]](full_msg)
  }
}

print.duplicates <- function(x, ...) {
  cat(
    "Dataset contains duplicate records with respect to ",
    enumerate(attr(x, "by_vars")),
    ".\n",
    sep = ""
  )
  NextMethod()
}
