library(plyr)
#Download dataset
if(!file.exists("./data")){dir.create("./data")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl, destfile = "./data/Dataset.zip", method = "curl")
#Unzip dataset to /data directory
unzip(zipfile = "./data/Dataset.zip", exdir = "./data")

#Read trainings tables
x_train <- read.table("./data/UCI HAR Dataset/train/x_train.txt")
y_train <- read.table("./data/UCI HAR Dataset/train/y_train.txt")
subject_train <- read.table("./data/UCI HAR Dataset/train/subject_train.txt")

#Read testing tables
x_test <- read.table("./data/UCI HAR Dataset/test/x_test.txt")
y_test <- read.table("./data/UCI HAR Dataset/test/y_test.txt")
subject_test <- read.table("./data/UCI HAR Dataset/test/subject_test.txt")

#Read feature vector
features <- read.table("./data/UCI HAR Dataset/features.txt")

#Read activity labels
activityLabels = read.table("./data/UCI HAR Dataset/activity_labels.txt")

#Assign column names
colnames(x_train) <- features[,2]
colnames(y_train) <- "activityID"
colnames(subject_train) <- "subjectID"
colnames(x_test) <- features[,2]
colnames(y_test) <- "activityID"
colnames(subject_test) <- "subjectID"
colnames(activityLabels) <- c('activityID', 'activityType')

#Merge datasets
mrg_train <- cbind(y_train, subject_train, x_train)
mrg_test <- cbind(y_test, subject_test, x_test)
AllinOne <- rbind(mrg_train, mrg_test)

#Read column names
colNames <- colnames(AllinOne)

#Vector for ID, mean, standard deviation
mean_and_std <- (grepl("activityID", colNames) | 
                         grepl("subjectID", colNames) | 
                         grepl("mean..", colNames) |
                         grepl("std..", colNames)
                 )
#Subset from AllinOne
setForMeanAndStd <- AllinOne[ , mean_and_std == TRUE]

#Rename activites
setWithActivityNames <- merge(setForMeanAndStd, activityLabels, 
                              by='activityID',
                              all.x = TRUE)

#Second tidy data for average of each variable for each activity
secTidyData <- aggregate(. ~subjectID + activityID, setWithActivityNames, mean)
secTidyData <- secTidyData[order(secTidyData$subjectID,secTidyData$activityID),]

write.table(secTidyData, "secTidyData.txt", row.names = FALSE)
