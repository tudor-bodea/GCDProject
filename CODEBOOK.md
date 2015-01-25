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
The `tidy` data frame of size 180 by 88 is obtained from the `data` data frame by averaging all the columns in `data` by `Subject` and `Activity` (via `summarise_each` and `group_by` commands from the contributed package [`dplyr`](http://cran.r-project.org/web/packages/dplyr/index.html)). The `tidy` data frame is printed to the pipe delimited file `TudorBodea_tidy.txt` via `write.table`. For convenience, the `write.table` R code snippet together with its complement, which allows one to read the file back in R, is provided below:

```
##### WRITE TO FILE
write.table(x=tidy, file="TudorBodea_tidy.txt", quote=FALSE, sep="|", 
	row.names=FALSE, col.names=TRUE)
##### READ THE FILE BACK IN R
replica <- read.table(file="TudorBodea_tidy.txt", header=TRUE, sep="|", 
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

(subject) **Subject** - Study subject. Numeric categorical variable with levels 1 thorough 30.

(label) **Activity** - Activity the study subjects engaged in. Categorical variable with 6 levels: Laying, Sitting, Standing, Walking, Walking Downstairs, Walking Upstairs.

(tBodyAcc-mean()-X) **TimeBodyAcceleration.Mean.X** - By subject and activity, the mean of the time domain body acceleration in the X direction.

(tBodyAcc-mean()-Y) **TimeBodyAcceleration.Mean.Y** - By subject and activity, the mean of the time domain body acceleration in the Y direction.

(tBodyAcc-mean()-Z) **TimeBodyAcceleration.Mean.Z** - By subject and activity, the mean of the time domain body acceleration in the Z direction.

(tBodyAcc-std()-X) TimeBodyAcceleration.Std.X
(tBodyAcc-std()-Y) TimeBodyAcceleration.Std.Y
(tBodyAcc-std()-Z) TimeBodyAcceleration.Std.Z
(tGravityAcc-mean()-X) TimeGravityAcceleration.Mean.X
(tGravityAcc-mean()-Y) TimeGravityAcceleration.Mean.Y
(tGravityAcc-mean()-Z) TimeGravityAcceleration.Mean.Z
(tGravityAcc-std()-X) TimeGravityAcceleration.Std.X
(tGravityAcc-std()-Y) TimeGravityAcceleration.Std.Y
(tGravityAcc-std()-Z) TimeGravityAcceleration.Std.Z
(tBodyAccJerk-mean()-X) TimeBodyAccelerationJerk.Mean.X
(tBodyAccJerk-mean()-Y) TimeBodyAccelerationJerk.Mean.Y
(tBodyAccJerk-mean()-Z) TimeBodyAccelerationJerk.Mean.Z
(tBodyAccJerk-std()-X) TimeBodyAccelerationJerk.Std.X
(tBodyAccJerk-std()-Y) TimeBodyAccelerationJerk.Std.Y
(tBodyAccJerk-std()-Z) TimeBodyAccelerationJerk.Std.Z
(tBodyGyro-mean()-X) TimeBodyGyro.Mean.X
(tBodyGyro-mean()-Y) TimeBodyGyro.Mean.Y
(tBodyGyro-mean()-Z) TimeBodyGyro.Mean.Z
(tBodyGyro-std()-X) TimeBodyGyro.Std.X
(tBodyGyro-std()-Y) TimeBodyGyro.Std.Y
(tBodyGyro-std()-Z) TimeBodyGyro.Std.Z
(tBodyGyroJerk-mean()-X) TimeBodyGyroJerk.Mean.X
(tBodyGyroJerk-mean()-Y) TimeBodyGyroJerk.Mean.Y
(tBodyGyroJerk-mean()-Z) TimeBodyGyroJerk.Mean.Z
(tBodyGyroJerk-std()-X) TimeBodyGyroJerk.Std.X
(tBodyGyroJerk-std()-Y) TimeBodyGyroJerk.Std.Y
(tBodyGyroJerk-std()-Z) TimeBodyGyroJerk.Std.Z
(tBodyAccMag-mean()) TimeBodyAccelerationMag.Mean
(tBodyAccMag-std()) TimeBodyAccelerationMag.Std
(tGravityAccMag-mean()) TimeGravityAccelerationMag.Mean
(tGravityAccMag-std()) TimeGravityAccelerationMag.Std
(tBodyAccJerkMag-mean()) TimeBodyAccelerationJerkMag.Mean
(tBodyAccJerkMag-std()) TimeBodyAccelerationJerkMag.Std
(tBodyGyroMag-mean()) TimeBodyGyroMag.Mean
(tBodyGyroMag-std()) TimeBodyGyroMag.Std
(tBodyGyroJerkMag-mean()) TimeBodyGyroJerkMag.Mean
(tBodyGyroJerkMag-std()) TimeBodyGyroJerkMag.Std
(fBodyAcc-mean()-X) FrequencyBodyAcceleration.Mean.X
(fBodyAcc-mean()-Y) FrequencyBodyAcceleration.Mean.Y
(fBodyAcc-mean()-Z) FrequencyBodyAcceleration.Mean.Z
(fBodyAcc-std()-X) FrequencyBodyAcceleration.Std.X
(fBodyAcc-std()-Y) FrequencyBodyAcceleration.Std.Y
(fBodyAcc-std()-Z) FrequencyBodyAcceleration.Std.Z
(fBodyAcc-meanFreq()-X) FrequencyBodyAcceleration.MeanFreq.X
(fBodyAcc-meanFreq()-Y) FrequencyBodyAcceleration.MeanFreq.Y
(fBodyAcc-meanFreq()-Z) FrequencyBodyAcceleration.MeanFreq.Z
(fBodyAccJerk-mean()-X) FrequencyBodyAccelerationJerk.Mean.X
(fBodyAccJerk-mean()-Y) FrequencyBodyAccelerationJerk.Mean.Y
(fBodyAccJerk-mean()-Z) FrequencyBodyAccelerationJerk.Mean.Z
(fBodyAccJerk-std()-X) FrequencyBodyAccelerationJerk.Std.X
(fBodyAccJerk-std()-Y) FrequencyBodyAccelerationJerk.Std.Y
(fBodyAccJerk-std()-Z) FrequencyBodyAccelerationJerk.Std.Z
(fBodyAccJerk-meanFreq()-X) FrequencyBodyAccelerationJerk.MeanFreq.X
(fBodyAccJerk-meanFreq()-Y) FrequencyBodyAccelerationJerk.MeanFreq.Y
(fBodyAccJerk-meanFreq()-Z) FrequencyBodyAccelerationJerk.MeanFreq.Z
(fBodyGyro-mean()-X) FrequencyBodyGyro.Mean.X
(fBodyGyro-mean()-Y) FrequencyBodyGyro.Mean.Y
(fBodyGyro-mean()-Z) FrequencyBodyGyro.Mean.Z
(fBodyGyro-std()-X) FrequencyBodyGyro.Std.X
(fBodyGyro-std()-Y) FrequencyBodyGyro.Std.Y
(fBodyGyro-std()-Z) FrequencyBodyGyro.Std.Z
(fBodyGyro-meanFreq()-X) FrequencyBodyGyro.MeanFreq.X
(fBodyGyro-meanFreq()-Y) FrequencyBodyGyro.MeanFreq.Y
(fBodyGyro-meanFreq()-Z) FrequencyBodyGyro.MeanFreq.Z
(fBodyAccMag-mean()) FrequencyBodyAccelerationMag.Mean
(fBodyAccMag-std()) FrequencyBodyAccelerationMag.Std
(fBodyAccMag-meanFreq()) FrequencyBodyAccelerationMag.MeanFreq
(fBodyBodyAccJerkMag-mean()) FrequencyBodyAccelerationJerkMag.Mean
(fBodyBodyAccJerkMag-std()) FrequencyBodyAccelerationJerkMag.Std
(fBodyBodyAccJerkMag-meanFreq()) FrequencyBodyAccelerationJerkMag.MeanFreq
(fBodyBodyGyroMag-mean()) FrequencyBodyGyroMag.Mean
(fBodyBodyGyroMag-std()) FrequencyBodyGyroMag.Std
(fBodyBodyGyroMag-meanFreq()) FrequencyBodyGyroMag.MeanFreq
(fBodyBodyGyroJerkMag-mean()) FrequencyBodyGyroJerkMag.Mean
(fBodyBodyGyroJerkMag-std()) FrequencyBodyGyroJerkMag.Std
(fBodyBodyGyroJerkMag-meanFreq()) FrequencyBodyGyroJerkMag.MeanFreq
(angle(tBodyAccMean,gravity)) Angle.TimeBodyAccelerationMean.Gravity
(angle(tBodyAccJerkMean),gravityMean)) Angle.TimeBodyAccelerationJerkMean.GravityMean
(angle(tBodyGyroMean,gravityMean)) Angle.TimeBodyGyroMean.GravityMean
(angle(tBodyGyroJerkMean,gravityMean)) Angle.TimeBodyGyroJerkMean.GravityMean
(angle(X,gravityMean)) Angle.X.GravityMean
(angle(Y,gravityMean)) Angle.Y.GravityMean
(angle(Z,gravityMean)) Angle.Z.GravityMean






