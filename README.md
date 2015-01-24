#### Acknowledgement 
Some of the ideas implemented in this work are discussed by David Hood [here] (https://class.coursera.org/getdata-010/forum/thread?thread_id=49).


#### Prerequisites
**i.** [`cURL`](http://curl.haxx.se/download.html) needs to be installed and made available in the search path for the executables.

**ii.** The R contributed package `dplyr` needs to be installed and loaded via `library(dplyr)`.

**iii.** (Possibly) The user needs to be connected to the Internet.


#### Download and Unzip Samsung Archive
To have a clean start, `run_analysis.R` needs to be placed in the working directory set with `setwd`. No other files and/or folders are needed in the working directory. When run,  `run_analysis.R` will download the Samsung archive from the Internet via `download.file` with the `extra` argument set to `curl`.  Subsequently, it will unzip the archive in the working directory via `unzip`. If these steps are successful, the working directory (`.`) should consist of the following files and folders: 

**i.** `.\run_analysis.R` (R script), 

**ii.** `.\getdata-projectfiles-UCI HAR Dataset.zip` (Samsung archive), and, 

**iii.** `.\UCI HAR Dataset` (data folder).

Since downloading the Samsung archive from the Internet takes some time, one does not always need to go through a clean start. Instead, through some minimal data validation checks, one usually skips the `download.file` and `unzip` steps. This behaviour is triggered if `getdata-projectfiles-UCI HAR Dataset.zip` (Samsung archive) and `UCI HAR Dataset` (data folder) both exist in the working directory.


#### Task 1. Merge Training and Test Data Sets
Before the actual merge of the training and test data sets is performed, `run_analysis.R` reads the features and the activity labels from their respective locations via `read.table`. To avoid any data type problems, `run_analysis.R` calls `read.table` with the `colClasses` argument specified explicitly (e.g., `colClasses=c("integer", "character")`). Elements of the resulting `f` and `l` data frames are used later on to name the columns of the merged data set and provide descriptive names for the activities study subjects engaged in, respectively.

For each data set (i.e., training and test), `run_analysis.R` reads sequentially the content of the subject, activity and measurement files via `read.table`. As before, to avoid any data type problems, `run_analysis.R` calls `read.table` with the `colClasses` argument specified explicitly (e.g., `colClasses=c("integer")`). The resulting data frames are combined by column via `cbind` into data frames conveniently named `tg` (training) and `tt` (test), respectively. Once both data sets get their combined data frames, `run_analysis.R` creates the merged data set `data` via `rbind`. The `data` data frame consists of 10,299 subject - activity - time entries (rows) each of which shows measurements on 561 features. Considering the subject and activity label fields, `data` has data organized in 563 columns. 

Since none of the raw data files comes with a header, `run_analysis.R` assigns a header to the `data` data frame based on the content of the feature file (see above for the reference to the data frame `f`). This header follows the structure below:

subject|label|tBodyAcc-mean()-X| ... |angle(Z,gravityMean)|
-------|-----|-----------------|-----|--------------------|


#### Task 2. Extract Measurements on Mean and Standard Deviation for each Measurement
Selecting the measurements on the mean and standard deviation for each measurement is a subtle undertaking as it is unclear from the available information how the variables/features were named and/or computed. For the purpose of this project, it is assumed that all variables/features that have the words `Mean`, `mean` and `std` anywhere in their names would qualify for the task. Since there are no variants of `std` in the feature file that show any upper case letters, these instances are not considered explicitly in the match. To this end, `run_analysis.R` uses `grep` with the regular expression `"subject|label|[Mm]ean|std"` to subset the `data` data frame. Of the 561 original features, `grep` retains 86. Considering the subject and activity label fields, `data` has now 10,299 rows and 88 columns.

#### Task 3. Use Descriptive Activity Names
Through a series of `gsub` commands, `run_analysis.R` formats the activity labels from the `l` data frame by enforcing a Camel case format. In doing so, the unpleasant `WALKING_DOWNSTAIRS` label, for example, becomes now the more appealing `Walking Downstairs`. Then, via the `merge` command, `run_analysis.R` merges the `data` and `l` data frames to associate the descriptive activity names from `l` to the corresponding activity codes from `data`. Through some other simple subsetting operations, `data` shows now entries that look just like the below:

subject|activity|tBodyAcc-mean()-X| ... |angle(Z,gravityMean)|
-------|--------|-----------------|-----|--------------------|
1|Standing|0.28858451|...|-0.058626924|
...|||||


#### Task 4. Label Data Set with Descriptive Variable Names
Through a series of `gsub` and `sub` commands, `run_analysis.R` formats the names of the variables in the `data` data frame such that:

**i.** `-` are replaced by `.`,

**ii.** `T` and `F` are expanded and replaced by `Time` and `Frequency`,

**iii.** `Acc` is expanded and replaced by `Acceleration`,

**iv.** `()` is replaced by an empty string,

**v.** `BodyBody` is replaced by `Body`,

**vi.** `(,`, `)`, and `,` are all replaced by `.`, and,

**vii.** the Camel case format is enforced.

All these changes are inspired by the Google's R Style Guide for Variable Naming available [here](https://google-styleguide.googlecode.com/svn/trunk/Rguide.xml).

The data frame `data` shows now entries that look as follows:

Subject|Activity|TimeBodyAcceleration.Mean.X| ... |Angle.Z.GravityMean|
-------|--------|---------------------------|-----|-------------------|
1|Standing|0.28858451|...|-0.058626924|
...|||||


#### Task 5. Create Tidy Data Set
`run_analysis.R` creates the tidy data set via the `summarise_each` and `group_by` commands from the `dplyr` contributed package. This data set is printed to a file via `write.table` and can be re-read in R using the `read.table` command. Both of these commands, as they are used in `run_analysis.R`, are provided below:

```
##### WRITE TO FILE
write.table(x=tidy, file="TudorBodea_tidy.csv", quote=FALSE, sep="|", 
	row.names=FALSE, col.names=TRUE)
##### READ THE FILE BACK IN R
replica <- read.table(file="TudorBodea_tidy.csv", header=TRUE, sep="|", 
	colClasses=c("integer","character",rep("numeric", times=86)))
```









Was code book submitted to GitHub that modifies and updates the codebooks available to you with the data to indicate all the variables and summaries you calculated, along with units, and any other relevant information?







