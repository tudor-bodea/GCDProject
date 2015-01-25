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
When the `data` data frame is first computed, it consists of a column `subject` that identifies the study subjects, a column `label` that provides the numeric codes for the activities the study subjects engaged in, and other 561 measurement data columns identified by the names provided in the feature raw data set. Through a series of connected data steps, this data frame is transformed and ultimately used to create the `tidy` data frame. The process that incorporates the interdependent data steps is documented below:

**(i)** As it is unclear from the original documentation how the features were named or constructed, all 86 features that have `Mean`, `mean`, or `std` in their names are retained and considered in the subsequent data steps. The `data` data frame is left with 88 columns (`subject`, `label` and the other 86 qualified features).

**(ii)** The activity codes previously used in `label` are replaced with the corresponding Camel case descriptive activity names. For example, a previous `label` of 5 becomes now `Standing`.

**(iii)** The names of the 88 remaining variables are revisited and changed as per the recommendations provided in Google's R Style Guide for Variable Naming (which is available [here](https://google-styleguide.googlecode.com/svn/trunk/Rguide.xml)). The changes include: (1) `-` are replaced by `.`, (2) `T` and `F` are expanded and replaced by `Time` and `Frequency`, respectively, (3) `Acc` is expanded and replaced by `Acceleration`, (4) `()` is replaced by an empty string, (5) `BodyBody` is replaced by `Body`, (6) `(,`, `)`, and `,` are all replaced by `.`, and, (7) the Camel case format is enforced. The original as well as the revisited variable names are provided in the table from Section 4.

**(iv)** The `tidy` data frame of size 180 by 88 is obtained from the `data` data frame by averaging all the columns in `data` by `Subject` and `Activity` (via `summarise_each` and `group_by` commands from the contributed package [`dplyr`](http://cran.r-project.org/web/packages/dplyr/index.html)). Although the entries in the columns of the `tidy` data frame are averages, the names of the columns are preserved when the summary activities take place (i.e., `data` and `tidy` have both the same variable names).


#### 4. Output Data Dictionary
The table in this section lists and documents the content of the `tidy` data frame (180 rows & 88 columns). Since the original features were normalized between -1 and 1, all average variables in the `tidy` data frame are unit-less.

```
Index|Original Feature Name|Tidy Variable Name|Description|
-----|---------------------|------------------|-----------|
1|subject|Subject|Study subject. Numeric categorical variable with levels 1 thorough 30.
2|label|Activity|Activity the study subjects engaged in. Categorical variable (Laying, Sitting, Standing, Walking, Walking Downstairs, Walking Upstairs).
3|tBodyAcc-mean()-X|TimeBodyAcceleration.Mean.X|
4|tBodyAcc-mean()-Y|TimeBodyAcceleration.Mean.Y|
5|tBodyAcc-mean()-Z|TimeBodyAcceleration.Mean.Z|
6|tBodyAcc-std()-X|TimeBodyAcceleration.Std.X|
7|tBodyAcc-std()-Y|TimeBodyAcceleration.Std.Y|
8|tBodyAcc-std()-Z|TimeBodyAcceleration.Std.Z|
9|tGravityAcc-mean()-X|TimeGravityAcceleration.Mean.X|
10|tGravityAcc-mean()-Y|TimeGravityAcceleration.Mean.Y|
11|tGravityAcc-mean()-Z|TimeGravityAcceleration.Mean.Z|
12|tGravityAcc-std()-X|TimeGravityAcceleration.Std.X|
13|tGravityAcc-std()-Y|TimeGravityAcceleration.Std.Y|
14|tGravityAcc-std()-Z|TimeGravityAcceleration.Std.Z|
15|tBodyAccJerk-mean()-X|TimeBodyAccelerationJerk.Mean.X|
16|tBodyAccJerk-mean()-Y|TimeBodyAccelerationJerk.Mean.Y|
17|tBodyAccJerk-mean()-Z|TimeBodyAccelerationJerk.Mean.Z|
18|tBodyAccJerk-std()-X|TimeBodyAccelerationJerk.Std.X|
19|tBodyAccJerk-std()-Y|TimeBodyAccelerationJerk.Std.Y|
20|tBodyAccJerk-std()-Z|TimeBodyAccelerationJerk.Std.Z|
21|tBodyGyro-mean()-X|TimeBodyGyro.Mean.X|
22|tBodyGyro-mean()-Y|TimeBodyGyro.Mean.Y|
23|tBodyGyro-mean()-Z|TimeBodyGyro.Mean.Z|
24|tBodyGyro-std()-X|TimeBodyGyro.Std.X|
25|tBodyGyro-std()-Y|TimeBodyGyro.Std.Y|
26|tBodyGyro-std()-Z|TimeBodyGyro.Std.Z|
27|tBodyGyroJerk-mean()-X|TimeBodyGyroJerk.Mean.X|
28|tBodyGyroJerk-mean()-Y|TimeBodyGyroJerk.Mean.Y|
29|tBodyGyroJerk-mean()-Z|TimeBodyGyroJerk.Mean.Z|
30|tBodyGyroJerk-std()-X|TimeBodyGyroJerk.Std.X|
31|tBodyGyroJerk-std()-Y|TimeBodyGyroJerk.Std.Y|
32|tBodyGyroJerk-std()-Z|TimeBodyGyroJerk.Std.Z|
33|tBodyAccMag-mean()|TimeBodyAccelerationMag.Mean|
34|tBodyAccMag-std()|TimeBodyAccelerationMag.Std|
35|tGravityAccMag-mean()|TimeGravityAccelerationMag.Mean|
36|tGravityAccMag-std()|TimeGravityAccelerationMag.Std|
37|tBodyAccJerkMag-mean()|TimeBodyAccelerationJerkMag.Mean|
38|tBodyAccJerkMag-std()|TimeBodyAccelerationJerkMag.Std|
39|tBodyGyroMag-mean()|TimeBodyGyroMag.Mean|
40|tBodyGyroMag-std()|TimeBodyGyroMag.Std|
41|tBodyGyroJerkMag-mean()|TimeBodyGyroJerkMag.Mean|
42|tBodyGyroJerkMag-std()|TimeBodyGyroJerkMag.Std|
43|fBodyAcc-mean()-X|FrequencyBodyAcceleration.Mean.X|
44|fBodyAcc-mean()-Y|FrequencyBodyAcceleration.Mean.Y|
45|fBodyAcc-mean()-Z|FrequencyBodyAcceleration.Mean.Z|
46|fBodyAcc-std()-X|FrequencyBodyAcceleration.Std.X|
47|fBodyAcc-std()-Y|FrequencyBodyAcceleration.Std.Y|
48|fBodyAcc-std()-Z|FrequencyBodyAcceleration.Std.Z|
49|fBodyAcc-meanFreq()-X|FrequencyBodyAcceleration.MeanFreq.X|
50|fBodyAcc-meanFreq()-Y|FrequencyBodyAcceleration.MeanFreq.Y|
51|fBodyAcc-meanFreq()-Z|FrequencyBodyAcceleration.MeanFreq.Z|
52|fBodyAccJerk-mean()-X|FrequencyBodyAccelerationJerk.Mean.X|
53|fBodyAccJerk-mean()-Y|FrequencyBodyAccelerationJerk.Mean.Y|
54|fBodyAccJerk-mean()-Z|FrequencyBodyAccelerationJerk.Mean.Z|
55|fBodyAccJerk-std()-X|FrequencyBodyAccelerationJerk.Std.X|
56|fBodyAccJerk-std()-Y|FrequencyBodyAccelerationJerk.Std.Y|
57|fBodyAccJerk-std()-Z|FrequencyBodyAccelerationJerk.Std.Z|
58|fBodyAccJerk-meanFreq()-X|FrequencyBodyAccelerationJerk.MeanFreq.X|
59|fBodyAccJerk-meanFreq()-Y|FrequencyBodyAccelerationJerk.MeanFreq.Y|
60|fBodyAccJerk-meanFreq()-Z|FrequencyBodyAccelerationJerk.MeanFreq.Z|
61|fBodyGyro-mean()-X|FrequencyBodyGyro.Mean.X|
62|fBodyGyro-mean()-Y|FrequencyBodyGyro.Mean.Y|
63|fBodyGyro-mean()-Z|FrequencyBodyGyro.Mean.Z|
64|fBodyGyro-std()-X|FrequencyBodyGyro.Std.X|
65|fBodyGyro-std()-Y|FrequencyBodyGyro.Std.Y|
66|fBodyGyro-std()-Z|FrequencyBodyGyro.Std.Z|
67|fBodyGyro-meanFreq()-X|FrequencyBodyGyro.MeanFreq.X|
68|fBodyGyro-meanFreq()-Y|FrequencyBodyGyro.MeanFreq.Y|
69|fBodyGyro-meanFreq()-Z|FrequencyBodyGyro.MeanFreq.Z|
70|fBodyAccMag-mean()|FrequencyBodyAccelerationMag.Mean|
71|fBodyAccMag-std()|FrequencyBodyAccelerationMag.Std|
72|fBodyAccMag-meanFreq()|FrequencyBodyAccelerationMag.MeanFreq|
73|fBodyBodyAccJerkMag-mean()|FrequencyBodyAccelerationJerkMag.Mean|
74|fBodyBodyAccJerkMag-std()|FrequencyBodyAccelerationJerkMag.Std|
75|fBodyBodyAccJerkMag-meanFreq()|FrequencyBodyAccelerationJerkMag.MeanFreq|
76|fBodyBodyGyroMag-mean()|FrequencyBodyGyroMag.Mean|
77|fBodyBodyGyroMag-std()|FrequencyBodyGyroMag.Std|
78|fBodyBodyGyroMag-meanFreq()|FrequencyBodyGyroMag.MeanFreq|
79|fBodyBodyGyroJerkMag-mean()|FrequencyBodyGyroJerkMag.Mean|
80|fBodyBodyGyroJerkMag-std()|FrequencyBodyGyroJerkMag.Std|
81|fBodyBodyGyroJerkMag-meanFreq()|FrequencyBodyGyroJerkMag.MeanFreq|
82|angle(tBodyAccMean,gravity)|Angle.TimeBodyAccelerationMean.Gravity|
83|angle(tBodyAccJerkMean),gravityMean)|Angle.TimeBodyAccelerationJerkMean.GravityMean|
84|angle(tBodyGyroMean,gravityMean)|Angle.TimeBodyGyroMean.GravityMean|
85|angle(tBodyGyroJerkMean,gravityMean)|Angle.TimeBodyGyroJerkMean.GravityMean|
86|angle(X,gravityMean)|Angle.X.GravityMean|
87|angle(Y,gravityMean)|Angle.Y.GravityMean|
88|angle(Z,gravityMean)|Angle.Z.GravityMean|
```





