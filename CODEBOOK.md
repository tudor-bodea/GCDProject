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
This section lists and documents the content of the `tidy` data frame (180 rows & 88 columns). Since the original features were normalized between -1 and 1, all average variables in the `tidy` data frame are unit-less. To facilitate the review of the submission, the following pattern is used when documenting the variables in the tidy data set: 

(Original Feature Name) **Tidy Variable Name** - Description.

The 88 variables in the `tidy` data frame follow next:

(subject) **Subject** - Study subject. Numeric categorical variable with levels 1 thorough 30.

(label) **Activity** - Activity the study subjects engaged in. Categorical variable with 6 levels: Laying, Sitting, Standing, Walking, Walking Downstairs, Walking Upstairs.

(tBodyAcc-mean()-X) **TimeBodyAcceleration.Mean.X** - By subject and activity, the mean of the time domain body acceleration in the X direction.

(tBodyAcc-mean()-Y) **TimeBodyAcceleration.Mean.Y** - By subject and activity, the mean of the time domain body acceleration in the Y direction.

(tBodyAcc-mean()-Z) **TimeBodyAcceleration.Mean.Z** - By subject and activity, the mean of the time domain body acceleration in the Z direction.

(tBodyAcc-std()-X) **TimeBodyAcceleration.Std.X** - By subject and activity, the mean of the standard deviation of the time domain body acceleration in the X direction.

(tBodyAcc-std()-Y) **TimeBodyAcceleration.Std.Y** - By subject and activity, the mean of the standard deviation of the time domain body acceleration in the Y direction.

(tBodyAcc-std()-Z) **TimeBodyAcceleration.Std.Z** - By subject and activity, the mean of the standard deviation of the time domain body acceleration in the Z direction.

(tGravityAcc-mean()-X) **TimeGravityAcceleration.Mean.X** - By subject and activity, the mean of the time domain gravity acceleration in the X direction.

(tGravityAcc-mean()-Y) **TimeGravityAcceleration.Mean.Y** - By subject and activity, the mean of the time domain gravity acceleration in the Y direction.

(tGravityAcc-mean()-Z) **TimeGravityAcceleration.Mean.Z** - By subject and activity, the mean of the time domain gravity acceleration in the Z direction.

(tGravityAcc-std()-X) **TimeGravityAcceleration.Std.X** - By subject and activity, the mean of the standard deviation of the time domain gravity acceleration in the X direction.

(tGravityAcc-std()-Y) **TimeGravityAcceleration.Std.Y** - By subject and activity, the mean of the standard deviation of the time domain gravity acceleration in the Y direction.

(tGravityAcc-std()-Z) **TimeGravityAcceleration.Std.Z** - By subject and activity, the mean of the standard deviation of the time domain gravity acceleration in the Z direction.

(tBodyAccJerk-mean()-X) **TimeBodyAccelerationJerk.Mean.X** - By subject and activity, the mean of the time domain body acceleration jerk in the X direction.

(tBodyAccJerk-mean()-Y) **TimeBodyAccelerationJerk.Mean.Y** - By subject and activity, the mean of the time domain body acceleration jerk in the Y direction.

(tBodyAccJerk-mean()-Z) **TimeBodyAccelerationJerk.Mean.Z** - By subject and activity, the mean of the time domain body acceleration jerk in the Z direction.

(tBodyAccJerk-std()-X) **TimeBodyAccelerationJerk.Std.X** - By subject and activity, the mean of the standard deviation of the time domain body acceleration jerk in the X direction.

(tBodyAccJerk-std()-Y) **TimeBodyAccelerationJerk.Std.Y** - By subject and activity, the mean of the standard deviation of the time domain body acceleration jerk in the Y direction.

(tBodyAccJerk-std()-Z) **TimeBodyAccelerationJerk.Std.Z** - By subject and activity, the mean of the standard deviation of the time domain body acceleration jerk in the Z direction.

(tBodyGyro-mean()-X) **TimeBodyGyro.Mean.X** - By subject and activity, the mean of the time domain body gyro in the X direction.

(tBodyGyro-mean()-Y) **TimeBodyGyro.Mean.Y** - By subject and activity, the mean of the time domain body gyro in the Y direction.

(tBodyGyro-mean()-Z) **TimeBodyGyro.Mean.Z** - By subject and activity, the mean of the time domain body gyro in the Z direction.

(tBodyGyro-std()-X) **TimeBodyGyro.Std.X** - By subject and activity, the mean of the standard deviation of the time domain body gyro in the X direction.

(tBodyGyro-std()-Y) **TimeBodyGyro.Std.Y** - By subject and activity, the mean of the standard deviation of the time domain body gyro in the Y direction.

(tBodyGyro-std()-Z) **TimeBodyGyro.Std.Z** - By subject and activity, the mean of the standard deviation of the time domain body gyro in the Z direction.

(tBodyGyroJerk-mean()-X) **TimeBodyGyroJerk.Mean.X** - By subject and activity, the mean of the time domain body gyro jerk in the X direction.

(tBodyGyroJerk-mean()-Y) **TimeBodyGyroJerk.Mean.Y** - By subject and activity, the mean of the time domain body gyro jerk in the Y direction.

(tBodyGyroJerk-mean()-Z) **TimeBodyGyroJerk.Mean.Z** - By subject and activity, the mean of the time domain body gyro jerk in the Z direction.

(tBodyGyroJerk-std()-X) **TimeBodyGyroJerk.Std.X** - By subject and activity, the mean of the standard deviation of the time domain body gyro jerk in the X direction.

(tBodyGyroJerk-std()-Y) **TimeBodyGyroJerk.Std.Y** - By subject and activity, the mean of the standard deviation of the time domain body gyro jerk in the Y direction.

(tBodyGyroJerk-std()-Z) **TimeBodyGyroJerk.Std.Z** - By subject and activity, the mean of the standard deviation of the time domain body gyro jerk in the Z direction.

(tBodyAccMag-mean()) **TimeBodyAccelerationMag.Mean** - By subject and activity, the mean of the magnitude of the time domain body acceleration.

(tBodyAccMag-std()) **TimeBodyAccelerationMag.Std** - By subject and activity, the mean of the standard deviation of the magnitude of the time domain body acceleration.

(tGravityAccMag-mean()) **TimeGravityAccelerationMag.Mean** - By subject and activity, the mean of the magnitude of the time domain gravity acceleration.

(tGravityAccMag-std()) **TimeGravityAccelerationMag.Std** - By subject and activity, the mean of the standard deviation of the magnitude of the time domain gravity acceleration.

(tBodyAccJerkMag-mean()) **TimeBodyAccelerationJerkMag.Mean** - By subject and activity, the mean of the magnitude of the time domain body acceleration jerk.

(tBodyAccJerkMag-std()) **TimeBodyAccelerationJerkMag.Std** - By subject and activity, the mean of the standard deviation of the magnitude of the time domain body acceleration jerk.

(tBodyGyroMag-mean()) **TimeBodyGyroMag.Mean** - By subject and activity, the mean of the magnitude of the time domain body gyro.

(tBodyGyroMag-std()) **TimeBodyGyroMag.Std** - By subject and activity, the mean of the standard deviation of the magnitude of the time domain body gyro.

(tBodyGyroJerkMag-mean()) **TimeBodyGyroJerkMag.Mean** - By subject and activity, the mean of the magnitude of the time domain body gyro jerk.

(tBodyGyroJerkMag-std()) **TimeBodyGyroJerkMag.Std** - By subject and activity, the mean of the standard deviation of the magnitude of the time domain body gyro jerk.

(fBodyAcc-mean()-X) **FrequencyBodyAcceleration.Mean.X** - By subject and activity, the mean of the frequency domain body acceleration in the X direction.

(fBodyAcc-mean()-Y) **FrequencyBodyAcceleration.Mean.Y** - By subject and activity, the mean of the frequency domain body acceleration in the Y direction.

(fBodyAcc-mean()-Z) **FrequencyBodyAcceleration.Mean.Z** - By subject and activity, the mean of the frequency domain body acceleration in the Z direction.

(fBodyAcc-std()-X) **FrequencyBodyAcceleration.Std.X** - By subject and activity, the mean of the standard deviation of the frequency domain body acceleration in the X direction.

(fBodyAcc-std()-Y) **FrequencyBodyAcceleration.Std.Y** - By subject and activity, the mean of the standard deviation of the frequency domain body acceleration in the Y direction.

(fBodyAcc-std()-Z) **FrequencyBodyAcceleration.Std.Z** - By subject and activity, the mean of the standard deviation of the frequency domain body acceleration in the Z direction.

(fBodyAcc-meanFreq()-X) **FrequencyBodyAcceleration.MeanFreq.X** - By subject and activity, the mean frequency of the frequency domain body acceleration in the X direction.

(fBodyAcc-meanFreq()-Y) **FrequencyBodyAcceleration.MeanFreq.Y** - By subject and activity, the mean frequency of the frequency domain body acceleration in the Y direction.

(fBodyAcc-meanFreq()-Z) **FrequencyBodyAcceleration.MeanFreq.Z** - By subject and activity, the mean frequency of the frequency domain body acceleration in the Z direction.

(fBodyAccJerk-mean()-X) **FrequencyBodyAccelerationJerk.Mean.X** - By subject and activity, the mean of the frequency domain body acceleration jerk in the X direction.

(fBodyAccJerk-mean()-Y) **FrequencyBodyAccelerationJerk.Mean.Y** - By subject and activity, the mean of the frequency domain body acceleration jerk in the Y direction.

(fBodyAccJerk-mean()-Z) **FrequencyBodyAccelerationJerk.Mean.Z** - By subject and activity, the mean of the frequency domain body acceleration jerk in the Z direction.

(fBodyAccJerk-std()-X) **FrequencyBodyAccelerationJerk.Std.X** - By subject and activity, the mean of standard deviation of the frequency domain body acceleration jerk in the X direction.

(fBodyAccJerk-std()-Y) **FrequencyBodyAccelerationJerk.Std.Y** - By subject and activity, the mean of standard deviation of the frequency domain body acceleration jerk in the Y direction.

(fBodyAccJerk-std()-Z) **FrequencyBodyAccelerationJerk.Std.Z** - By subject and activity, the mean of standard deviation of the frequency domain body acceleration jerk in the Z direction.

(fBodyAccJerk-meanFreq()-X) **FrequencyBodyAccelerationJerk.MeanFreq.X** - By subject and activity, the mean frequency of the frequency domain body acceleration jerk in the X direction.

(fBodyAccJerk-meanFreq()-Y) **FrequencyBodyAccelerationJerk.MeanFreq.Y** - By subject and activity, the mean frequency of the frequency domain body acceleration jerk in the Y direction.

(fBodyAccJerk-meanFreq()-Z) **FrequencyBodyAccelerationJerk.MeanFreq.Z** - By subject and activity, the mean frequency of the frequency domain body acceleration jerk in the Z direction.

(fBodyGyro-mean()-X) **FrequencyBodyGyro.Mean.X** - By subject and activity, the mean of the frequency domain body gyro in the X direction.

(fBodyGyro-mean()-Y) **FrequencyBodyGyro.Mean.Y** - By subject and activity, the mean of the frequency domain body gyro in the Y direction.

(fBodyGyro-mean()-Z) **FrequencyBodyGyro.Mean.Z** - By subject and activity, the mean of the frequency domain body gyro in the Z direction.

(fBodyGyro-std()-X) **FrequencyBodyGyro.Std.X** - By subject and activity, the mean of standard deviation of the frequency domain body gyro in the X direction.

(fBodyGyro-std()-Y) **FrequencyBodyGyro.Std.Y** - By subject and activity, the mean of standard deviation of the frequency domain body gyro in the Y direction.

(fBodyGyro-std()-Z) **FrequencyBodyGyro.Std.Z** - By subject and activity, the mean of standard deviation of the frequency domain body gyro in the Z direction.

(fBodyGyro-meanFreq()-X) **FrequencyBodyGyro.MeanFreq.X** - By subject and activity, the mean frequency of the frequency domain body gyro in the X direction.

(fBodyGyro-meanFreq()-Y) **FrequencyBodyGyro.MeanFreq.Y** - By subject and activity, the mean frequency of the frequency domain body gyro in the Y direction.

(fBodyGyro-meanFreq()-Z) **FrequencyBodyGyro.MeanFreq.Z** - By subject and activity, the mean frequency of the frequency domain body gyro in the Z direction.

(fBodyAccMag-mean()) **FrequencyBodyAccelerationMag.Mean** - By subject and activity, the mean magnitude of the frequency domain body acceleration.

(fBodyAccMag-std()) **FrequencyBodyAccelerationMag.Std** - By subject and activity, the mean standard deviation of the magnitude of the frequency domain body acceleration.

(fBodyAccMag-meanFreq()) **FrequencyBodyAccelerationMag.MeanFreq** - By subject and activity, the mean frequency of the magnitude of the frequency domain body acceleration.

(fBodyBodyAccJerkMag-mean()) **FrequencyBodyAccelerationJerkMag.Mean** - By subject and activity, the mean magnitude of the frequency domain body acceleration jerk.

(fBodyBodyAccJerkMag-std()) **FrequencyBodyAccelerationJerkMag.Std** - By subject and activity, the mean standard deviation of the magnitude of the frequency domain body acceleration jerk.

(fBodyBodyAccJerkMag-meanFreq()) **FrequencyBodyAccelerationJerkMag.MeanFreq** - By subject and activity, the mean frequency of the magnitude of the frequency domain body acceleration jerk.

(fBodyBodyGyroMag-mean()) **FrequencyBodyGyroMag.Mean** - By subject and activity, the mean magnitude of the frequency domain body gyro.

(fBodyBodyGyroMag-std()) **FrequencyBodyGyroMag.Std** - By subject and activity, the mean of the standard deviation of the magnitude of the frequency domain body gyro.

(fBodyBodyGyroMag-meanFreq()) **FrequencyBodyGyroMag.MeanFreq** - By subject and activity, the mean frequency of the magnitude of the frequency domain body gyro.

(fBodyBodyGyroJerkMag-mean()) **FrequencyBodyGyroJerkMag.Mean** - By subject and activity, the mean magnitude of the frequency domain body gyro jerk.

(fBodyBodyGyroJerkMag-std()) **FrequencyBodyGyroJerkMag.Std** - By subject and activity, the mean of the standard deviation of the magnitude of the frequency domain body gyro jerk.

(fBodyBodyGyroJerkMag-meanFreq()) **FrequencyBodyGyroJerkMag.MeanFreq** - By subject and activity, the mean frequency of the magnitude of the frequency domain body gyro jerk.

(angle(tBodyAccMean,gravity)) **Angle.TimeBodyAccelerationMean.Gravity** - By subject and activity, the mean angle between the mean time domain body acceleration and gravity.

(angle(tBodyAccJerkMean),gravityMean)) **Angle.TimeBodyAccelerationJerkMean.GravityMean** - By subject and activity, the mean angle between the mean time domain body acceleration jerk and the mean gravity.

(angle(tBodyGyroMean,gravityMean)) **Angle.TimeBodyGyroMean.GravityMean** - By subject and activity, the mean angle between the mean time domain body gyro and the mean gravity.

(angle(tBodyGyroJerkMean,gravityMean)) **Angle.TimeBodyGyroJerkMean.GravityMean** - By subject and activity, the mean angle between the mean time domain body gyro jerk and the mean gravity.

(angle(X,gravityMean)) **Angle.X.GravityMean** - By subject and activity, the mean angle between the X direction and the mean gravity.

(angle(Y,gravityMean)) **Angle.Y.GravityMean** - By subject and activity, the mean angle between the Y direction and the mean gravity.

(angle(Z,gravityMean)) **Angle.Z.GravityMean** - By subject and activity, the mean angle between the Z direction and the mean gravity.
