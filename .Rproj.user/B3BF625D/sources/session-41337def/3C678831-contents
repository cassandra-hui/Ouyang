#' Reformat Data for Rethomics
#'
#' This function reformats the input data and creates metadata for the Rethomics package.
#'
#' @param data A data frame containing the raw data.
#'
#' @importFrom reshape2 dcast
#' @importFrom dplyr group_by summarize select
#'
#' @return None. The function writes reformatted data and metadata to files.
#'
#' @description This function pivots the input data to have cages as columns, adds additional columns,
#' calculates start and stop datetimes, and creates metadata for the Rethomics package. The reformatted
#' data is written to a tab-separated .txt file and metadata is written to a CSV file.
#'
#' @examples
#' data <- read.csv("your_data.csv")  # Replace with your data file from the reformatted file created in this package
#' reformat_for_Rethomics(data)
#'
#' @export
reformat_for_Rethomics <- function(data) {
  library(reshape2)
  library(dplyr)

  # Pivot the data to have cages as columns
  pivoted_data <- dcast(data, Date + timestamp ~ Cage, value.var = "HopsPerMinute", fill = 0)
  # pivoted_data <- data %>%
  #   pivot_wider(names_from = Cage, values_from = HopsPerMinute, values_fill = 0)
  #Adds too many days for the different cages somehow


  # Convert 'Date' and 'timestamp' columns to datetime objects
  pivoted_data$Date <- as.Date(pivoted_data$Date)
  pivoted_data$timestamp <- as.POSIXct(pivoted_data$timestamp)

  # Convert datetime objects to formatted strings
  pivoted_data$Date <- format(pivoted_data$Date, "%e %b %y")
  pivoted_data$timestamp <- format(pivoted_data$timestamp, "%H:%M:%S")

  # Add an 'activity_indicator' column with all values set to 1
  pivoted_data$activity_indicator <- 1

  # Add the 'extra' column with all values set to 0
  pivoted_data$extra <- 0

  # Add a continuous counting column at the beginning
  pivoted_data$count <- seq_len(nrow(pivoted_data))

  # Reorder the columns
  reordered_columns <- c('count', 'Date', 'timestamp', 'activity_indicator', rep('extra', 6), 1:24, rep('extra', 8))
  pivoted_data <- pivoted_data[reordered_columns]

  # Write the reformatted data to a tab-separated .txt file without column names
  write.table(pivoted_data, file = "Monitor1.txt", sep = "\t", row.names = FALSE, col.names = FALSE, quote = FALSE)

  # Calculate start and stop datetime
  start_datetime <- as.POSIXct(paste(min(data$Date), min(data$LightsOn)), format = "%Y-%m-%d %I:%M %p", tz = "UTC")
  stop_datetime <- as.POSIXct(paste(max(data$Date), max(data$LightsOff)), format = "%Y-%m-%d %I:%M %p", tz = "UTC")

  # Create a data frame for metadata
  metadata <- data %>%
    group_by(Cage) %>%
    summarize(
      individual = first(Cage),
      file = "Monitor1.txt",
      start_datetime = start_datetime,
      stop_datetime = stop_datetime,
      region_id = first(Cage),
      condition = first(Treatment),
      sex = first(Sex)
    ) %>%
    select(-Cage)  # Remove the 'Cage' column


  # Write metadata to a CSV file
  write.csv(metadata, file = "metadata.csv", row.names = FALSE, quote = FALSE)

  cat("Reformatting and metadata creation completed.\n")
}

# Usage
#data <- read.csv("your_data.csv")  # Replace with your data file
#reformat_for_Rethomics(data)
