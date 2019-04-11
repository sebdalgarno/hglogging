year_pal <- function(x){
  pal <- colorRampPalette(c(rgb(227, 94, 0, maxColorValue = 255), rgb(255, 255, 0, maxColorValue = 255)))
  pal(length(x))
}