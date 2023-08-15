#' @title reformat_file
#'
#' @param file_path path to one data file
#'
#' @return data frame
#'
#' @description designed to reorganize data files from the Ouyang Lab
#'
#'
#' @export
#'
#' @examples
#' r <- reformat_single_file("~/GitHub/circr/hop_data/July 01, 2021.txt")

# Function to read and reformat a single data file
reformat_file <- function(file_path) {
  # Extract date from the file name
  date <- as.Date(gsub(".txt", "", basename(file_path)), format = "%B %d, %Y")
  
  # Read data from the file
  data <- readLines(file_path)
  
  # Initialize variables
  cage <- 1
  hour <- 0  # Start at 0 for each new file
  hops_per_minute <- numeric()
  
  for (line in data) {
    numbers <- unlist(strsplit(line, "\\s+"))
    for (hops_count in numbers) {
      hops_per_minute <- c(hops_per_minute, as.numeric(hops_count))
      minute <- length(hops_per_minute)
      if (minute > 60) {
        minute <- 1
        hour <- hour + 1
      }
      if (hour > 23) {
        hour <- 0
        cage <- cage + 1
      }
    }
  }
  
  # Create a data frame for the file
  df <- data.frame(
    Date = rep(date, times = length(hops_per_minute)),
    Cage = rep(1:(ceiling(length(hops_per_minute) / (24 * 60))), each = 24 * 60),
    Hour = rep(0:23, each = 60, length.out = length(hops_per_minute)),
    Minute = rep(0:59, times = 24),
    HopsPerMinute = hops_per_minute
  )
  
  # Convert 'Date', 'Hour', and 'Minute' columns to POSIXct format
  df$timestamp <- as.POSIXct(paste(df$Date, df$Hour, df$Minute, sep = " "), format = "%Y-%m-%d %H %M")
  

return(df)
}


# Function to reformat multiple data files
reformat_data_files <- function(file_paths) {
  dfs <- lapply(file_paths, reformat_file)
  combined_df <- do.call(rbind, dfs)
  return(combined_df)
}
