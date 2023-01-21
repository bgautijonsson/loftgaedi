#' Get all air quality data from the last 24 hours
#'
#' @return A tibble containing all air quality data that has been recorded in the last 24 hours
#' @export
#'
#' @examples
#' d <- get_latest()
get_latest <- function() {

  res <- httr::GET("https://api.ust.is/aq/a/getLatest")

  .process_content(res$content)
}




