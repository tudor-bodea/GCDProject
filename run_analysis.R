rm(list=ls(all=TRUE))
setwd("C:/Work/Personal/Personal/Coursera/3-GettingAndCleaningData/wk3_Project")
library(dplyr)
options(digits=10)

##################################################################################
####################### DOWNLOAD AND UNZIP SAMSUNG ARCHIVE #######################
##################################################################################
##### TO HAVE A CLEAN START, REMOVE ALL FILES (BUT run_analysis.R) AND FOLDERS
#####	FROM THE WORKING DIRECTORY; cURL NEEDS TO BE INSTALLED AND MADE AVAILABLE
##### IN THE SEARCH PATH FOR THE EXECUTABLES; THIS STEP IS SKIPPED IF 
##### getdata-projectfiles-UCI HAR Dataset.zip AND THE FOLDER UCI HAR Dataset 
##### BOTH EXIST IN THE WORKING FORLDER
##################################################################################
if (!file.exists("./getdata-projectfiles-UCI HAR Dataset.zip")) {
	if (file.exists("./UCI HAR Dataset")) 
		{unlink("./UCI HAR Dataset", recursive=TRUE)}
	download.file(url="https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", 
		destfile="./getdata-projectfiles-UCI HAR Dataset.zip", 
		method="curl", extra="-k")
}
list.files("./")
if (!file.exists("./UCI HAR Dataset")) 
	{unzip(zipfile="./getdata-projectfiles-UCI HAR Dataset.zip", exdir=".")}
list.files("./")

##################################################################################
###################### 1. MERGE TRAINING AND TEST DATA SETS ######################
##################################################################################
##### GET FEATURES 
f <- read.table(file="./UCI HAR Dataset/features.txt", header=FALSE, sep=" ", 
	colClasses=c("integer", "character"))
head(f)
##### GET ACTIVITY LABELS
l <- read.table(file="./UCI HAR Dataset/activity_labels.txt", header=FALSE, 
	sep=" ", colClasses=c("integer", "character"))
head(l)
##### GET TRAINING DATA
# TRAINING DATA SET: GET SUBJECT 
tg.s <- read.table(file="./UCI HAR Dataset/train/subject_train.txt", header=FALSE, 
	colClasses=c("integer"))
# TRAINING DATA SET: GET ACTIVITY LABELS
tg.l <- read.table(file="./UCI HAR Dataset/train/y_train.txt", header=FALSE, 
	colClasses=c("integer"))
# TRAINING DATA SET: GET MEASUREMENT DATA
tg.d <- read.table(file="./UCI HAR Dataset/train/x_train.txt", header=FALSE, 
	colClasses=rep("numeric", times=561))
# TRAINING DATA SET: COMBINE SUBJECT, LABELS, MEASUREMENT DATA
tg <-  cbind(tg.s, tg.l, tg.d)
##### GET TEST DATA
# TEST DATA SET: GET SUBJECT 
tt.s <- read.table(file="./UCI HAR Dataset/test/subject_test.txt", header=FALSE, 
	colClasses=c("integer"))
# TEST DATA SET: GET ACTIVITY LABELS
tt.l <- read.table(file="./UCI HAR Dataset/test/y_test.txt", header=FALSE, 
	colClasses=c("integer"))
# TEST DATA SET: GET MEASUREMENT DATA
tt.d <- read.table(file="./UCI HAR Dataset/test/x_test.txt", header=FALSE, 
	colClasses=rep("numeric", times=561))
# TEST DATA SET: COMBINE SUBJECT, LABELS, MEASUREMENT DATA
tt <-  cbind(tt.s, tt.l, tt.d)
##### COMBINE TRAINING AND TEST DATA & ADD VARIABLE NAMES
data <- rbind(tg, tt)
names(data) <- c("subject","label",f[,2])

##################################################################################
######### 2. EXTRACT MEASUREMENT ON MEAN AND STD DEV FOR EACH MEASUREMENT ########
##################################################################################
##### IDENTIFY WHICH COLUMNS NEED TO STAY - BESIDES subject AND label VARIABLES,
##### RETAIN ALL VARIABLES THAT HAVE IN THEIR NAMES THE WORDS Mean, mean OR std
##################################################################################
ci <- grep("subject|label|[Mm]ean|std",names(data))
data <- data[,ci]

##################################################################################
######################## 3. USE DESCRIPTIVE ACTIVITY NAMES #######################
##################################################################################
##### FORMAT ACTIVITY LABELS
names(l) <- c("label", "activity")
# IMPOSE CAMEL CASE FORMAT
l[,2] <- gsub("(?:\\b|\\_)([[:alpha:]])", " \\U\\1", tolower(l[,2]), perl=TRUE)
# REMOVE LEADING OR TRAILING WHITESPACE
l[,2] <- gsub("^\\s+|\\s+$", "", l[,2])
##### ADD DESCRIPTIVE ACTIVITY VARIABLE; DROP ORIGINAL ACTIVITY LABEL VARIABLE
data <- merge(x=data, y=l, by.x="label", by.y="label", sort=FALSE)
data <- data[,c(2,ncol(data),3:(ncol(data)-1))]

##################################################################################
################ 4. LABEL DATA SET WITH DESCRIPTIVE VARIABLE NAMES ###############
##################################################################################
tmp <- names(data)
# REPLACE - WITH . IN THE VARIABLE NAMES AND IMPOSE CAMEL CASE FORMAT
tmp <- gsub("(?:\\b|\\-)([[:alpha:]])", "\\U.\\1", tmp, perl=TRUE)
# REMOVE . FROM THE BEGINNING OF THE VARIABLE NAMES
tmp <- sub("^.", "", tmp)
# REPLACE T AND F WITH Time AND Frequency
tmp <- sub("^T", "Time", tmp)
tmp <- sub("^F", "Frequency", tmp)
tmp <- sub("\\(.T", "\\(.Time", tmp)
# REPLACE Acc WITH Acceleration
tmp <- sub("Acc", "Acceleration", tmp)
# REPLACE () WITH AN EMPTY STRING
tmp <- sub("\\(\\)", "", tmp)
# REPLACE BodyBody WITH Body
tmp <- sub("BodyBody", "Body", tmp)
# REPLACE (, ) AND , WITH . AS PER GOOGLE'S R STYLE GUIDE
tmp <- gsub("\\(|,|\\)", "", tmp)
# RENAME VARIABLES
names(data) <- tmp

##################################################################################
############################# 5. CREATE TIDY DATA SET ############################
##################################################################################
##### COMPUTE AVERAGE BY SUBJECT AND ACTIVITY
tidy <- summarise_each(group_by(data,Subject,Activity), funs(mean))
##### WRITE TO FILE
write.table(x=tidy, file="TudorBodea_tidy.csv", quote=FALSE, sep="|", 
	row.names=FALSE, col.names=TRUE)
##### READ THE FILE BACK IN R
replica <- read.table(file="TudorBodea_tidy.csv", header=TRUE, sep="|", 
	colClasses=c("integer","character",rep("numeric", times=86)))






