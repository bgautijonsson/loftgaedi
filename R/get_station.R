#' Get info about all stations that have recorded any amount of data
#'
#'
#' @return A tibble containing basic information about the stations in the data
#' @export
#'
#' @examples
#' stations <- get_stations()
get_stations <- function() {

  url <- glue::glue("https://api.ust.is/aq/a/getStations")

  res <- httr::GET(url)

  res$content |>
    rawToChar() |>
    jsonlite::fromJSON() |>
    tibble::tibble()

}



