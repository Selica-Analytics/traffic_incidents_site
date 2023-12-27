library(targets)

# This is an example _targets.R file. Every
# {targets} pipeline needs one.
# Use tar_script() to create _targets.R and tar_edit()
# to open it again for editing.
# Then, run tar_make() to run the pipeline
# and tar_read(data_summary) to view the results.

# Define custom functions and other global objects.
# This is where you write source(\"R/functions.R\")
# if you keep your functions in external scripts.

source("functions/traf_constr_wrangling.R")
source("functions/download_file.R")
source("functions/create_map.R")


# Set target-specific options such as packages:
# tar_option_set(packages = "utils") # nolint
targets::tar_option_set(
    packages = c("dplyr",  
                 "lubridate",
                 "janitor",
                 "tarchetypes",
                 "leaflet",
                 "fontawesome",
                 "httr2"
    )
)

# Set up variables
url <- "https://data.calgary.ca/resource/35ra-9556.csv?limit=10000000"
time_frame_min <- 90
current_date_time <- Sys.time()
beginning_time <- current_date_time - lubridate::minutes(time_frame_min)

# Generate icons for map
icons <- leaflet::awesomeIconList(
    crash = leaflet::makeAwesomeIcon(text = fontawesome::fa("car-burst"), iconColor = "black", markerColor = "red")
)

# End this file with a list of target objects.
list(
    tar_target(
        download_data,
        download_file(url),
        format = "file"
     ),
    tar_target(
        read_data,
        readr::read_csv(download_data,show_col_types = FALSE)
    ),
    tar_target(
        data_wrangle,
        traf_constr_wrangling(read_data)
    ),
    tar_target(
        plot_traffic_incidents,
        create_map(data_wrangle)
    ),
    tarchetypes::tar_render(
        analyze_data,
        "traffic_incidents.Rmd",
        output_dir = "_site/"
    )
)