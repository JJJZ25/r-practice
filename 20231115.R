flights <- readRDS("data/flights_week10.rds")

flightsData <- flights$data[[1]]$data_frame

dplyr::glimpse(flightsData)


# How many departure time zone?

flightsData$DepartureTimeZone |>
  table() |>
  sort(decreasing = T) -> tb_departureTimeZone

flights$dataSummary$DepartureTimeZone <- tb_departureTimeZone

saveRDS(flights, file="data/flights_week10_after.rds")









# 3. parse time with time zone
## split flightsData according to its timezone
flightsData |> split(flightsData$DepartureTimeZone) -> split_flightsData

x=1

split_flightsData[[x]] |> dplyr::glimpse()
split_flightsData[[x]] |> View

lubridate::ydm_hm(
  split_flightsData[[x]]$DepartureTime,
  tz=split_flightsData[[x]]$DepartureTimeZone[[1]]
)
























split_flightsData[[,x]]$DepartureTime <-
  lubridate::ydm_hm(
    split_flightsData[[x]]$DepartureTime,
    tz=split_flightsData[[x]]$DepartureTimeZone[[1]]
  )


dplyr::mutate(
  DepartureTime =
    lubridate::ymd_hm(
      DepartureTime,
      tz = DepartureTimeZone[[1]])
  )

split_flightsData[[,x]] |>
  dplyr::mutate(
    DepartureTime =
      lubridate::ymd_hm(
        DepartureTime,
        tz = DepartureTimeZone[[1]])
  )


# for every x
flightsData <- flights$data[[1]]$data_frame

flightsData |>
  dplyr::group_by(DepartureTimeZone) |>
  dplyr::mutate(
    DepartureTime =
      lubridate::ymd_hm(
        DepartureTime,
        tz = DepartureTimeZone[[1]])
  ) |>
  dplyr::ungroup() ->
  flightsData



saveRDS(flights, file="data/flights_week10_after.rds")
