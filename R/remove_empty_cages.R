#' Remove Empty Cages
#'
#' This function removes cages from the input data where the sum of HopsPerMinute is zero.
#'
#' @param data A data frame containing the raw data.
#'
#' @importFrom dplyr aggregate
#'
#' @return A data frame with empty cages removed.
#'
#' @description This function calculates the sum of HopsPerMinute for each cage in the input data,
#' identifies non-empty cages, and returns a filtered data frame with only non-empty cages.
#'
#' @examples
#' data <- read.csv("your_data.csv")  # Replace with your data file
#' filtered_data <- remove_empty_cages(data)
#'
#' @export
remove_empty_cages <- function(data) {
  library(dplyr)

  # Calculate the sum of HopsPerMinute for each Cage
  cage_sum <- aggregate(HopsPerMinute ~ Cage, data = data, FUN = sum)

  # Get the list of cages with non-zero sum of HopsPerMinute
  non_empty_cages <- cage_sum$Cage[cage_sum$HopsPerMinute > 0]

  # Filter the data to keep only non-empty cages
  filtered_data <- data[data$Cage %in% non_empty_cages, ]

  return(filtered_data)
}
