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

**(xi)** Data frame `data` of size 10,299 by 563 combines by rows the training and test data frames `tg` and `tt`.

#### 2. Output
The `tidy` data frame is obtained from the `data` data frame by averaging all the columns in `data` by `Subject` and `Activity` (via `summarise_each` and `group_by` commands from the contributed package [`dplyr`](http://cran.r-project.org/web/packages/dplyr/index.html)). 

Describe the tidy data set - pipe delimited

Provide how the file is to be re-read in R

#### 3. Process

#### 4. Output Data Dictionary
