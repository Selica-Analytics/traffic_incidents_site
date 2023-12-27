
# This file contains the code to wrangle the traffic incidents and construction detours dataset
# v1.0

# Clean the data
traf_constr_wrangling <- function(data) {
    
    stopifnot("`data` must be a data frame" =
                  inherits(data, "data.frame"))
    print("Dataframe not provided")
    
    data |>
        janitor::clean_names() |>
        mutate(
            start_dt = lubridate::ymd_hms(start_dt,tz = "Canada/Mountain"),
            modified_dt = lubridate::ymd_hms(modified_dt,tz = "Canada/Mountain"),
            content = paste(description,incident_info, sep = "<br/>"),
            last_updated = lubridate::ymd_hms(Sys.time(),tz = "Canada/Mountain")
        ) |> 
        filter(start_dt >= beginning_time)
}