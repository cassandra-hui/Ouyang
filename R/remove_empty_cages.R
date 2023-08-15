remove_empty_cages <- function(data) {
  # Calculate the sum of HopsPerMinute for each Cage
  cage_sum <- aggregate(HopsPerMinute ~ Cage, data = data, FUN = sum)
  
  # Get the list of cages with non-zero sum of HopsPerMinute
  non_empty_cages <- cage_sum$Cage[cage_sum$HopsPerMinute > 0]
  
  # Filter the data to keep only non-empty cages
  filtered_data <- data[data$Cage %in% non_empty_cages, ]
  
  return(filtered_data)
}
