## code to prepare `loftgaedi_data` dataset goes here

urls <- glue::glue("https://api.ust.is/static/aq/ust_aq_timeseries_{2015:2019}.csv")

d <- purrr::map_dfr(
  urls,
  vroom::vroom
)


d <- d |>
  dplyr::select(
    name = station_name,
    local_id = station_local_id,
    unit = concentration,
    resolution,
    verification,
    time = endtime,
    variable = pollutantnotation,
    value = the_value
  ) |>
  dplyr::mutate(
    variable = ifelse(variable == "NOX as NO2", "NO2", variable),
    verification = ifelse(verification == 1, "yfirfarin", "óyfirfarin")
  )

start_date <- max(as.Date(d$time)) + 1
end_date <- as.Date("2023-01-01")

d_new <- seq.Date(from = start_date, to = end_date, by = "days") |>
  get_dates()


loftgaedi_data <- dplyr::bind_rows(
  d,
  d_new |>
    dplyr::mutate(
      name = stringr::str_squish(name)
    )
)


loftgaedi_2015 <- loftgaedi_data |> dplyr::filter(lubridate::year(time) == 2015)
loftgaedi_2016 <- loftgaedi_data |> dplyr::filter(lubridate::year(time) == 2016)
loftgaedi_2017 <- loftgaedi_data |> dplyr::filter(lubridate::year(time) == 2017)
loftgaedi_2018 <- loftgaedi_data |> dplyr::filter(lubridate::year(time) == 2018)
loftgaedi_2019 <- loftgaedi_data |> dplyr::filter(lubridate::year(time) == 2019)
loftgaedi_2020 <- loftgaedi_data |> dplyr::filter(lubridate::year(time) == 2020)
loftgaedi_2021 <- loftgaedi_data |> dplyr::filter(lubridate::year(time) == 2021)
loftgaedi_2022 <- loftgaedi_data |> dplyr::filter(lubridate::year(time) == 2022)

usethis::use_data(loftgaedi_2015, overwrite = TRUE)
usethis::use_data(loftgaedi_2016, overwrite = TRUE)
usethis::use_data(loftgaedi_2017, overwrite = TRUE)
usethis::use_data(loftgaedi_2018, overwrite = TRUE)
usethis::use_data(loftgaedi_2019, overwrite = TRUE)
usethis::use_data(loftgaedi_2020, overwrite = TRUE)
usethis::use_data(loftgaedi_2021, overwrite = TRUE)
usethis::use_data(loftgaedi_2022, overwrite = TRUE)
