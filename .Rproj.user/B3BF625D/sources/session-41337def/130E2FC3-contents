# Explanation of Metadata File:
#
#   The metadata file should be a CSV file with the following columns:
#
# Cage: The cage number corresponding to each row in the data.
# Treatment: The treatment assigned to each cage or bird.
# Sex: The sex of each cage or bird.
# LightsOn: The time when the lights were turned on (e.g., "08:00 AM").
# LightsOff: The time when the lights were turned off (e.g., "08:00 PM").
# Here's how the first few lines of a metadata file might look:

# Date,Cage,Treatment,Sex,LightsOn,LightsOff
# 1,Control,Male,06:00 AM,06:00 PM
# 2,Treatment,Female,06:00 AM,06:00 PM
# 3,Control,Male,06:00 AM,06:00 PM
# # ... (more rows)

# Usage of the Function:
#
#   Make sure you have the attach_meta function defined.
# Replace "metadata.csv" with the actual path to your metadata file.
# Use the function like this:


# Function to attach metadata to reformatted data frame and calculate phase
attach_meta <- function(data, metadata_file_path) {
  metadata <- read.csv(metadata_file_path)
  merged_data <- merge(data, metadata, by = c("Cage"))

  # Convert LightsOn and LightsOff times to POSIXct objects
  merged_data$LightsOn <- as.POSIXct(merged_data$LightsOn, format = "%I:%M %p")
  merged_data$LightsOff <- as.POSIXct(merged_data$LightsOff, format = "%I:%M %p")

  # Calculate the phase
  merged_data$Phase <- ifelse(merged_data$Hour >= hour(merged_data$LightsOn) &
                                merged_data$Hour < hour(merged_data$LightsOff),
                              "day", "night")

  # Format LightsOn and LightsOff times without the date
  merged_data$LightsOn <- format(merged_data$LightsOn, format = "%I:%M %p")
  merged_data$LightsOff <- format(merged_data$LightsOff, format = "%I:%M %p")

  return(merged_data)
}
