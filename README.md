# Using Ouyang R Functions for Data Reformatting and Analysis

This guide provides step-by-step instructions on how to use the provided R functions for data reformatting and analysis. The functions are designed to help with cleaning, organizing, and analyzing automated perch data from the Ouyang Lab.

## Table of Contents
- [Prerequisites](#prerequisites)
- [Installing Required Packages](#installing-required-packages)
- [Reformatting Data](#reformatting-data)
- [Attaching Metadata](#attaching-metadata)
- [Removing Empty Cages](#removing-empty-cages)

## Prerequisites

Before you begin, make sure you have the following prerequisites:
- R installed on your computer.
- Basic familiarity with R programming.

## Installing Required Packages

The provided functions use several R packages. To install them, execute the following code in R:

```r
install.packages(c("reshape2", "dplyr", "lubridate"))
```

## Reformatting Data

### Function: reformat_data_files

This function reorganizes the data files you have in a particular folder.

```r
source("reformat_data_files.R")  # Replace with the actual file path

# Specify a vector of file paths
file_paths <- c("~/path/to/file1.txt", "~/path/to/file2.txt")

# Call the function to reformat data from multiple files
combined_data <- reformat_data_files(file_paths)
```

### Function: reformat_for_Rethomics

This function reformats data and creates metadata.

```r
source("reformat_for_Rethomics.R")  # Replace with the actual file path

# Read your data into a data frame (replace "your_data.csv" with the actual file name)
data <- read.csv("your_data.csv")

# Call the function to reformat data and create metadata
reformat_for_Rethomics(data)
```

## Attaching Metadata

### Function: attach_meta

This function attaches metadata to a reformatted data frame and calculates the phase.

```r
source("attach_meta.R")  # Replace with the actual file path

# Specify the path to the metadata file
metadata_file_path <- "metadata.csv"

# Call the function to attach metadata and calculate phase
merged_data <- attach_meta(reformatted_data, metadata_file_path)
```

## Removing Empty Cages

### Function: remove_empty_cages

This function removes cages with zero HopsPerMinute values.

```r
source("remove_empty_cages.R")  # Replace with the actual file path

# Call the function to remove empty cages
filtered_data <- remove_empty_cages(merged_data)
```

---

By following these instructions, you can effectively use the provided R functions to clean, organize, and analyze your automated perch data from the Ouyang Lab.
```
