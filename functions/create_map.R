# Generate map
create_map <- function(data){
    leaflet(data) |>
        addTiles() |>
        addAwesomeMarkers(~longitude, ~latitude, popup = ~content,icon=icons) 
}