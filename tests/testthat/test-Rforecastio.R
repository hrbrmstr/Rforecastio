context("basic functionality")
test_that("the API call works", {

  expect_that(get_current_forecast(43.2672, -70.8617), is_a("rforecastio"))
  expect_that(get_forecast_for(43.2672, -70.8617, "2013-05-06T12:00:00-0400"), is_a("rforecastio"))

})


