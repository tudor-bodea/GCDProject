##### Acknowledgement 
Some of the ideas implemented in this work are discussed by David Hood [here] (https://class.coursera.org/getdata-010/forum/thread?thread_id=49).


##### Prerequisites
i. [`cURL`](http://curl.haxx.se/download.html) needs to be installed and made available in the search path for the executables.

ii. The R contributed package `dplyr` needs to be installed and loaded via `library(dplyr)`.

iii. (Possibly) The user needs to be connected to the Internet.


##### Download and Unzip Samsung Archive
To have a clean start, `run_analysis.R` needs to be placed in the working directory set with `setwd`. No other files and/or folders are needed in the working directory. When run,  `run_analysis.R` will download the Samsung archive from the Internet via `download.file` with the `extra` argument set to `curl`.  Subsequently, it will unzip the archive in the working directory via `unzip`. If these steps are successful, the working directory (`.`) should consist of the following files and folders: 

(i) `.\run_analysis.R` (R script), 

(ii) `.\getdata-projectfiles-UCI HAR Dataset.zip` (Samsung archive), and 

(iii) `.\UCI HAR Dataset` (data folder).

Since downloading the Samsung archive from the Internet takes some time, one does not always need to go through a clean start. Instead, through some minimal data validation checks, one usually skips the `download.file` and `unzip` steps. This behaviour is triggered if `getdata-projectfiles-UCI HAR Dataset.zip` (Samsung archive) and `UCI HAR Dataset` (data folder) both exist in the working directory.


##### Task 1. Merge Training and Test Data Sets
Before the actual merge of the training and test data sets is performed, `run_analysis.R` reads the features and the activity labels from their respective locations via `read.table`. To avoid any data type problems, `run_analysis.R` calls `read.table` with the `colClasses` argument specified explicitly (e.g., `colClasses=c("integer", "character")`). Elements of the resulting `f` and `l` data frames will be used later on to name the columns of the merged data set and provide descriptive names for the activities study subjects engaged in, respectively.

For each data set (i.e., training and test), `run_analysis.R` reads sequentially the content of the subject, activity and measurement files via `read.table`. As before, to avoid any data type problems, `run_analysis.R` calls `read.table` with the `colClasses` argument specified explicitly (e.g., colClasses=c("integer")). The resulting data frames are combined by column via `cbind` into data frames conveniently named `tg` (training) and `tt` (test), respectively. Once both data sets get their combined data frames, `run_analysis.R` creates the merged data set `data` via `rbind`. The `data` data frame consists of 10,299 subject - activity - time entries (rows) each of which shows measurements on 561 features. Considering the subject and activity fields, `data` has data organized in 563 columns. 

Since none of the raw data files comes with a header, `run_analysis.R` assigns a header to the `data` data frame based on the content of the feature file (see above for the reference to the data frame `f`). This header follows the structure below:

subject|label|tBodyAcc-mean()-X| ... |angle(Z,gravityMean)|
-------|-----|-----------------|-----|--------------------|














explain how the script works/where it should sit if the reader were to duplicate your work
justify why you chose the variables that you chose - measurements on the mean and standard deviation for each measurement
refer to Google's R Style Guide for variable naming
Was code book submitted to GitHub that modifies and updates the codebooks available to you with the data to indicate all the variables and summaries you calculated, along with units, and any other relevant information?
provide the reader with how the tidy set is to be loaded back in R






