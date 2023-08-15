# Using Ouyang R Functions for Data Reformatting and Analysis

This guide provides step-by-step instructions on how to use the provided R functions for data reformatting and analysis. The functions are designed to help organize and analyze automated perch data from the Ouyang Lab.

## Table of Contents
- [Prerequisites](#prerequisites)
- [Installing Required Packages](#installing-required-packages)
- [Reformatting Data](#reformatting-data)
- [Attaching Metadata](#attaching-metadata)
- [Optional Functions](#optional-functions)
- [Plot Activity](#plot-activity)
- [Rethomics Workflow](#rethomics-workflow)

## Prerequisites

Before you begin, make sure you have the following prerequisites:
- R installed on your computer.
- Basic familiarity with R programming.

## Installing Required Packages

The provided functions use several R packages. To install them and this package, execute the following code in R:

```r
install.packages(c("devtools", "reshape2", "dplyr", "lubridate"))
devtools::install_github("cassandra-hui/Ouyang")
library(Ouyang)
```

## Reformatting Data

### Function: reformat_data_files

This function reorganizes the data files you have in a particular folder. First you need to designate that folder and the files contained, then you can run the reformatting function.

```r


# Specify the directory containing the data files
data_dir <- "~/my_path/Raw Data"

# Get a list of all the data files in the directory
file_paths <- list.files(data_dir, full.names = TRUE)

# Reformat data files
data <- reformat_data_files(file_paths)
```


## Attaching Metadata

### Function: attach_meta

This function attaches metadata to the reformatted data frame and calculates the phase. You will need to have a metadata file in your working directory like the sample shown. Let's assume it is called "meta.csv".

```r
# Attach metadata and calculate phase
data <- attach_meta(data, "meta.csv")

# Print the final data frame with metadata and phase
print(data)
```

## Optional Functions 

There are a couple of additional functions you may want to use. 

### Function: remove_empty_cages

This function removes cages with zero hops over all the files used.

```r
filtered_data <- remove_empty_cages(data)
```
### Function: bin_data

This function allows the user to bin data into 5, 10, 15, ... ect. minutes for more compressed files and easier use. 

```r
binned_data <- bin_data(data, minutes_per_bin = 5)
```

## Plot Activity

You can use this new data frame for analysis and plots. Here is a simple plot you can use to look at activity levels.

```r
library(ggplot2)
act_plot <- ggplot(data, aes(x = Hour, y = Date, fill = HopsPerMinute)) +
  geom_tile() +
  facet_wrap(~ Cage, scales = "free_y") +
  labs(x = "Hour", y = "Date", fill = "Hops") +
  theme_minimal()

act_plot
```

## Rethomics Workflow

If you would like to use more in-depth circadian and sleep analysis packages, you will need to reformat your data (again) to fit the standard output files. One common R analysis is Rethomics (https://rethomics.github.io/).

### Function: reformat_for_Rethomics

You can use this function to reformat your data frame for this type of analysis. The output of this function is a data file containing activity, called "Monitor1.txt" and a new metadata file reformated to work with Rethomics, called "metadata.csv". This function will not work if you have any missing dates, be sure your data files are sequential. This function will also not work with the remove_empty_cages() or bin_data() functions. 

```r
# Assuming your data frame is named 'data'
reformat_for_Rethomics(data)
```

---

By following these instructions, you can effectively use the provided R functions to organize and analyze your automated perch data from the Ouyang Lab.
