#' Attach Metadata to Reformatted Data and Calculate Phase
#'
#' This function attaches metadata to a reformatted data frame and calculates
#' the phase based on the LightsOn and LightsOff times.
#'
#' @param data A data frame containing reformatted data with Cage column.
#' @param metadata_file_path Path to the CSV metadata file.
#'
#' @return A data frame with metadata attached and phase calculated.
#'
#' @description This function reads a metadata file and attaches the corresponding
#' information to the reformatted data frame. It also calculates the phase based
#' on the LightsOn and LightsOff times and adds a Phase column to the data frame.
#'
#' @details The metadata file should be a CSV file with the following columns:
#'   - Cage: The cage number corresponding to each row in the data.
#'   - Treatment: The treatment assigned to each cage or bird.
#'   - Sex: The sex of each cage or bird.
#'   - LightsOn: The time when the lights were turned on (e.g., "08:00 AM").
#'   - LightsOff: The time when the lights were turned off (e.g., "08:00 PM").
#'
#' @examples
#' # Replace "metadata.csv" with the actual path to your metadata file
#' metadata_file_path <- "metadata.csv"
#' # Make sure you have the attach_meta function defined
#' merged_data <- attach_meta(reformatted_data, metadata_file_path)
#'
#' @import dplyr
#' @importFrom lubridate hour
#'
#' @export
#'
#' @seealso
#' Other functions: \code{\link{reformat_file}},
#' \code{\link{reformat_data_files}}, \code{\link{reformat_for_Rethomics}},
#' \code{\link{remove_empty_cages}}
#'
#' @references
#' For information on the \pkg{dplyr} and \pkg{lubridate} packages, see their
#' documentation.
#'
#' @keywords data manipulation
NULL
\name{attach_meta}
\alias{attach_meta}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
%%  ~~function to do ... ~~
}
\description{
%%  ~~ A concise (1-5 lines) description of what the function does. ~~
}
\usage{
attach_meta(data, metadata_file_path)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{data}{
%%     ~~Describe \code{data} here~~
}
  \item{metadata_file_path}{
%%     ~~Describe \code{metadata_file_path} here~~
}
}
\details{
%%  ~~ If necessary, more details than the description above ~~
}
\value{
%%  ~Describe the value returned
%%  If it is a LIST, use
%%  \item{comp1 }{Description of 'comp1'}
%%  \item{comp2 }{Description of 'comp2'}
%% ...
}
\references{
%% ~put references to the literature/web site here ~
}
\author{
%%  ~~who you are~~
}
\note{
%%  ~~further notes~~
}

%% ~Make other sections like Warning with \section{Warning }{....} ~

\seealso{
%% ~~objects to See Also as \code{\link{help}}, ~~~
}
\examples{
##---- Should be DIRECTLY executable !! ----
##-- ==>  Define data, use random,
##--	or do  help(data=index)  for the standard data sets.

## The function is currently defined as
function (data, metadata_file_path)
{
    metadata <- read.csv(metadata_file_path)
    merged_data <- merge(data, metadata, by = c("Cage"))
    merged_data$LightsOn <- as.POSIXct(merged_data$LightsOn,
        format = "\%I:\%M \%p")
    merged_data$LightsOff <- as.POSIXct(merged_data$LightsOff,
        format = "\%I:\%M \%p")
    merged_data$Phase <- ifelse(merged_data$Hour >= hour(merged_data$LightsOn) &
        merged_data$Hour < hour(merged_data$LightsOff), "day",
        "night")
    merged_data$LightsOn <- format(merged_data$LightsOn, format = "\%I:\%M \%p")
    merged_data$LightsOff <- format(merged_data$LightsOff, format = "\%I:\%M \%p")
    return(merged_data)
  }
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory (show via RShowDoc("KEYWORDS")):
% \keyword{ ~kwd1 }
% \keyword{ ~kwd2 }
% Use only one keyword per line.
% For non-standard keywords, use \concept instead of \keyword:
% \concept{ ~cpt1 }
% \concept{ ~cpt2 }
% Use only one concept per line.
