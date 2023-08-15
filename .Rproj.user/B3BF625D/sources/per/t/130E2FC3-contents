#' Attach Metadata to Reformatted Data Frame and Calculate Phase
#'
#' This function reads metadata from a CSV file, attaches it to the reformatted data frame,
#' and calculates the phase based on LightsOn and LightsOff times.
#'
#' @param data A data frame containing reformatted data.
#' @param metadata_file_path The path to the CSV file containing metadata.
#'
#' @return A data frame with attached metadata and calculated phase.
#'
#' @details The function reads the metadata from the specified CSV file and merges it with the
#' reformatted data based on the "Cage" column. It then converts LightsOn and LightsOff times to
#' POSIXct objects, calculates the phase for each row based on the time range defined by LightsOn
#' and LightsOff, and formats LightsOn and LightsOff times without the date.
#'
#' @examples
#' # Load required libraries and data
#' library(dplyr)
#' data <- read.csv("reformatted_data.csv")
#' metadata_path <- "metadata.csv"
#'
#' # Attach metadata and calculate phase
#' merged_data <- attach_meta(data, metadata_path)
#'
#' @importFrom dplyr merge
#' @importFrom lubridate hour
#'
#' @export
#'
#' @seealso \code{\link{reformat_for_Rethomics}}, \code{\link{install_github}}
#'
#' @keywords data manipulation

# Function to attach metadata to reformatted data frame and calculate phase
attach_meta <- function(data, metadata_file_path) {
  metadata <- read.csv(metadata_file_path)
  merged_data <- merge(data, metadata, by = c("Cage"))

  # Convert LightsOn and LightsOff times to POSIXct objects
  merged_data$LightsOn <- as.POSIXct(merged_data$LightsOn, format = "%I:%M %p")
  merged_data$LightsOff <- as.POSIXct(merged_data$LightsOff, format = "%I:%M %p")

  # Calculate the phase
  merged_data$Phase <- ifelse(merged_data$Hour >= lubridate::hour(merged_data$LightsOn) &
                                merged_data$Hour < lubridate::hour(merged_data$LightsOff),
                              "day", "night")

  # Format LightsOn and LightsOff times without the date
  merged_data$LightsOn <- format(merged_data$LightsOn, format = "%I:%M %p")
  merged_data$LightsOff <- format(merged_data$LightsOff, format = "%I:%M %p")

  return(merged_data)
}
