# download traffic incident data
download_file <- function(url) {
    dest <- tempfile()
    
    httr2::req_perform(
        request("https://data.calgary.ca/resource/35ra-9556.csv?$limit=10000000"), 
        path = dest
    )
    # download.file(url, dest)
    dest
}