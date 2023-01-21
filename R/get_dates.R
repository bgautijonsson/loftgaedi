#' Get all air quality data for a given date
#'
#' @param dates A vector that is or can be coerced to a Date vector
#'
#' @return A tibble containing the data for all chosen dates
#' @export
#'
#' @examples
#' my_date <- "2022-01-01"
#' d <- get_dates(my_date)
#'
#' my_dates <- seq.Date(from = as.Date("2023-01-01"), to = as.Date("2023-01-11"), by = "days")
#' d <- get_dates(my_date)
get_dates <- function(dates) {

  if (is.character(dates)) dates <- lubridate::as_date(dates)

  stopifnot(
    class(dates) %in% "Date"
  )

  purrr::map_dfr(
    dates,
    .get_date,
    .progress = TRUE
  )

}


#' Helper function that is called by the exported function get_dates()
#'
#' @param date The single date for which data is to be queried
#'
#' @return A tibble containing all air quality data for that specific date
.get_date <- function(date) {

  url <- glue::glue("https://api.ust.is/aq/a/getDate/date/{date}")

  res <- httr::GET(url)

  .process_content(res$content)
}
