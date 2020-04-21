library(dplyr)

URL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
filepath <- "Coursera Week 4 Project.zip"

if (!file.exists(filepath)) {
        download.file(URL, filepath, method = "curl")
}

if (!file.exists("UCI HAR Dataset")) {
        unzip(filepath)
}

activities <- read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("Code", "Activity"))
features <- read.table("UCI HAR Dataset/features.txt", col.names = c("n", "Function"))
subjectTest <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = "Subject")
xTest <- read.table("UCI HAR Dataset/test/X_test.txt", col.names = features$Function)
yTest <- read.table("UCI HAR Dataset/test/y_test.txt", col.names = "Code")
subjectTrain <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = "Subject")
xTrain <- read.table("UCI HAR Dataset/train/X_train.txt", col.names = features$Function)
yTrain <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = "Code")

mergedX <- rbind(xTest, xTrain)
mergedY <- rbind(yTest, yTrain)
Subject <- rbind(subjectTrain, subjectTest)

mergedData <- cbind(Subject, mergedY, mergedX)

tidyData <- select(mergedData, Subject, Code, contains("mean"), contains("std"))
tidyData$Code <- activities[tidyData$Code, 2]

names(tidyData)[2] <- "Activity"
names(tidyData) <- gsub("Acc", "Accelerometer", names(tidyData))
names(tidyData) <- gsub("Gyro", "Gyroscope", names(tidyData))
names(tidyData) <- gsub("BodyBody", "Body", names(tidyData))
names(tidyData) <- gsub("Mag", "Magnitude", names(tidyData))
names(tidyData) <- gsub("^t", "Time", names(tidyData))
names(tidyData) <- gsub("^f", "Frequency", names(tidyData))
names(tidyData) <- gsub("tbody", "TimeBody", names(tidyData))
names(tidyData) <- gsub("-mean()", "Mean", names(tidyData), ignore.case = TRUE)
names(tidyData) <- gsub("-std()", "STD", names(tidyData), ignore.case = TRUE)
names(tidyData) <- gsub("-freq()", "Frequency", names(tidyData), ignore.case = TRUE)
names(tidyData) <- gsub("angle", "Angle", names(tidyData))
names(tidyData) <- gsub("gravity", "Gravity", names(tidyData))


Data <- tidyData %>%
        group_by(Subject, Activity) %>%
        summarise_all(funs(mean))
write.table(Data, "Data.txt", row.name = FALSE)
