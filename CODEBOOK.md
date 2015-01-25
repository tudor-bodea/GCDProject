#### 1. Raw Data Sources, Inputs and Intermediate Data Sets
The following inputs are used to create the intermediate, support data sets:

**(i)** Data frame `f` of size 561 x 2 reads the features from the raw data set `./UCI HAR Dataset/features.txt`,

**(ii)** Data frame `l` of size 6 x 2 reads the features from the raw data set `./UCI HAR Dataset/activity_labels.txt`,

**(iii)** Data frame `tg.s` of size 7,352 x 1 reads the subjects for the training set from the raw data set `./UCI HAR Dataset/train/subject_train.txt`,

**(iv)** Data frame `tg.l` of size 7,352 x 1 reads the activity labels for the training set from the raw data set `./UCI HAR Dataset/train/y_train.txt`,

**(v)** Data frame `tg.d` of size 7,352 x 561 reads the measurement data for the training set from the raw data set `./UCI HAR Dataset/train/x_train.txt`,

**(vi)** Data frame `tt.s` of size 2,947 x 1 reads the subjects for the test set from the raw data set `./UCI HAR Dataset/test/subject_train.txt`,

**(vii)** Data frame `tt.l` of size 2,947 x 1 reads the activity labels for the test set from the raw data set `./UCI HAR Dataset/test/y_train.txt`, and,

**(viii)** Data frame `tt.d` of size 2,947 x 561 reads the measurement data for the test set from the raw data set `./UCI HAR Dataset/test/x_train.txt`.

The following intermediate, support data sets are used to create the tidy data set:

**(ix)** Data frame `tg` of size 7,352 by 563 combines by columns training data frames `tg.s`, `tg.l`, and, `tg.d`,

**(x)** Data frame `tt` of size 2,947 by 563 combines by columns test data frames `tt.s`, `tt.l`, and, `tt.d`,

**(xi)** Data frame `data`, with an original size of 10,299 by 563, combines by rows the training and test data frames `tg` and `tt`. Through the process discussed below, data frame `data` goes from 563 columns to 88 columns. Its number of rows, however, stays unchanged at 10,299.


#### 2. Outputs
The `tidy` data frame of size 180 by 88 is obtained from the `data` data frame by averaging all the columns in `data` by `Subject` and `Activity` (via `summarise_each` and `group_by` commands from the contributed package [`dplyr`](http://cran.r-project.org/web/packages/dplyr/index.html)). The `tidy` data frame is printed to the pipe delimited file `TudorBodea_tidy.csv` via `write.table`. For convenience, the `write.table` R code snippet together with its complement, which allows one to read the file back in R, is provided below:

```
##### WRITE TO FILE
write.table(x=tidy, file="TudorBodea_tidy.csv", quote=FALSE, sep="|", 
	row.names=FALSE, col.names=TRUE)
##### READ THE FILE BACK IN R
replica <- read.table(file="TudorBodea_tidy.csv", header=TRUE, sep="|", 
	colClasses=c("integer","character",rep("numeric", times=86)))
```


#### 3. Process
When the `data` data frame is first computed, it consists of a column `subject` that identifies the study subjects, a column `label` that provides the numeric codes for the activities the study subjects engaged in, and other 561 measurement data columns identified by the names provided in the feature raw data set. Through a series of intuitive data steps, this data frame is transformed and ultimately used to create the `tidy` data frame. These data steps are documented below:

**(i)** Test



!!!!! We preserve the names of the columns

#### 4. Output Data Dictionary






