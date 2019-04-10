library(rmapshaper)
library(sf)
library(dplyr)
library(dttr)
library(lwgeom)
library(geojsonio)
library(readr)
library(usethis)

logged <- st_read('inst/extdata/log17-YearHarvest-All-UTM8.gpkg') %>%
  st_make_valid() %>%
  st_cast("POLYGON") %>%
  st_transform(4326) %>%
  transmute(YearHarvested = YearHarv,
            SecondGrowth = if_else(SG == 1, TRUE, FALSE, missing = NA))

logged_simple <- logged %>%
  rmapshaper::ms_simplify(keep = 0.2, keep_shapes = TRUE) 

centroid <- st_centroid(logged_simple %>% st_combine()) %>% st_coordinates()

year_totals <- read_csv('inst/extdata/year_totals.csv')

get_color <- colorRampPalette(c(rgb(227, 94, 0, maxColorValue = 255), rgb(255, 255, 0, maxColorValue = 255)))
year_totals$Colour <- get_color(nrow(year_totals))

geojson_write(input = logged_simple, file = "R/logged_simple.geojson")
geojson_write(input = logged, file = "R/logged.geojson")
saveRDS(logged, 'R/logged.rds')
saveRDS(logged_simple, "R/logged_simple.rds")
saveRDS(centroid, 'R/centroid.rds')
usethis::use_data(year_totals, overwrite = TRUE)

