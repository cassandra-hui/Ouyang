#' Reformat Data Files from the Ouyang Lab
#'
#' This script provides functions to read and reformat data files from the Ouyang Lab.
#'
#' @export
#'
#' @seealso \code{\link{reformat_file}}, \code{\link{reformat_data_files}}
#'
#' @keywords data reformatting, data processing
#'
#' @title Reformat a Single Data File
#'
#' @param file_path A character string specifying the path to a data file.
#'
#' @return A data frame containing reformatted data.
#'
#' @description This function reads a single data file from the Ouyang Lab, extracts the date from the
#' file name, and reorganizes the data into a data frame with columns for Date, Cage, Hour, Minute,
#' and HopsPerMinute.
#'
#' @examples
#' file_path <- "~/GitHub/circr/hop_data/July 01, 2021.txt"
#' reformat_file(file_path)
#'
#' @importFrom base basename
#'
#' @export
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


#' @title Reformat Multiple Data Files
#'
#' @param file_paths A character vector specifying the paths to multiple data files.
#'
#' @return A combined data frame containing reformatted data from all files.
#'
#' @description This function reads and reformats multiple data files from the Ouyang Lab using the
#' \code{\link{reformat_file}} function. It combines the reformatted data frames into a single data frame.
#'
#' @examples
#' file_paths <- list("~/GitHub/circr/hop_data/July 01, 2021.txt", "~/GitHub/circr/hop_data/July 02, 2021.txt")
#' reformat_data_files(file_paths)
#'
#' @importFrom base do.call
#'
#' @export
# Function to reformat multiple data files
reformat_data_files <- function(file_paths) {
  dfs <- lapply(file_paths, reformat_file)
  combined_df <- do.call(rbind, dfs)
  return(combined_df)
}
