#' Helper function to transform API request content to tidy table format
#'
#' @param content The content to be tidied
#'
#' @return A tidied version of the API request content
.process_content <- function(content) {

  out <- content |>
    rawToChar() |>
    jsonlite::fromJSON() |>
    tibble::tibble()

  out <- out |>
    tidyr::unnest_wider(tidyr::everything()) |>
    tidyr::unnest_longer(parameters, indices_to = "variable") |>
    tidyr::unnest_wider(parameters) |>
    tidyr::pivot_longer(c(-(name:resolution), -variable), names_to = "measurement") |>
    tidyr::unnest_wider(value)

  out <- out |>
    dplyr::select(
      station = name,
      station_id = local_id,
      unit,
      resolution,
      verification,
      time = endtime,
      variable,
      value
    ) |>
    dplyr::mutate(
      time = lubridate::as_datetime(time),
      value = readr::parse_number(value),
      verification = ifelse(verification == 1, "yfirfarin", "óyfirfarin")
    )

  out

}
