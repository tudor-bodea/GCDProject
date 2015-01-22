##### Acknowledgement 
Some of the ideas implemented in this work are discussed by David Hood [here] (https://class.coursera.org/getdata-010/forum/thread?thread_id=49).


##### Prerequisites
i. [`cURL`](http://curl.haxx.se/download.html) needs to be installed and made available in the search path for the executables.

ii. The R contributed package `dplyr` needs to be installed and loaded via `library(dplyr)`.

iii. The user needs to be connected to the Internet.


##### 0. Download and Unzip Samsung Archive
To have a clean start, `run_analysis.R` needs to be placed in the working directory set with `setwd`. No other files and/or folders are needed in the working directory. When run, the `run_analysis.R` script will download the Samsung archive from the Internet via `download.file` with the `extra` argument set to `curl`.  Subsequently, it will unzip the archive in the working directory via `unzip`. If these steps are successful, the working directory should consist of the following files and folders: `.\run_analysis.R` (R script), `.\getdata-projectfiles-UCI HAR Dataset.zip` (Samsung archive) and `.\UCI HAR Dataset` (data folder).




explain how the script works/where it should sit if the reader were to duplicate your work
justify why you chose the variables that you chose - measurements on the mean and standard deviation for each measurement
refer to Google's R Style Guide for variable naming
Was code book submitted to GitHub that modifies and updates the codebooks available to you with the data to indicate all the variables and summaries you calculated, along with units, and any other relevant information?
provide the reader with how the tidy set is to be loaded back in R
