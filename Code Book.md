---
title: "Code Book"
author: "David Hwang"
date: "4/18/2020"
output: html_document
---

```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = TRUE)
```

## Week 4 Project

The run_analysis.r script prepares tidy data by following the 5 steps listed in the project's directions.

1) **Download the dataset.**

* Download and extract the dataset into a folder called `UCI HAR Dataset`.

2) **Assign data to each variable.**

* `features` <- `features.txt` (561 rows, 2 columns).
    The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ.

* `activities` <- `activity_labels.txt` (6 rows, 2 columns).
    The different activities that were tracked and their corresponding codes/labels.
        
* `subjectTest` <- `test/subject_test.txt` (2947 rows, 1 column).
    The test data of 9/30 participants being observed.
        
* `xTest` <- `test/x_test.txt` (2947 rows, 561 columns).
    The data recorded for features in test subjects.
        
* `yTest` <- `test/y_test.txt` (2947 rows, 1 column).
    The activity code/labels of the `subjectTest` data.
        
* `subjectTrain` <- `train/subject_train.txt` (7352 rows, 1 column).
    The train data of 21/30 participants being observed.
        
* `xTrain` <- `train/x_train.txt` (7352  rows, 561 columns).
    The data recorded for features in train subjects.
        
* `yTrain` <- `train/y_train.txt` (7352 rows, 1 column).
    The activity code/labels of the `subjectTrain` data.
        
3) **Merges the training and test data sets to create one data set.**
        
* `mergedX` (10299 rows, 561 columns) created by row binding (`rbind()`) `xTest` and `xTrain`.
        
* `mergedY` (10299 rows, 1 column) created by row binding (`rbind()`) `yTest` and `yTrain`.
        
* `Subject` (10299 rows, 1 column) created by row binding (`rbind()`) `subjectTest` and `subjectTrain`.
        
* `mergedData` (10299 rows, 563 columns) created by column binding (`cbind()`) `Subject`, `mergedY`, and `mergedX`.
        
4) **Extracts only the measurements on the mean and standard deviation for each measurement.**

* `tidyData` (10299 rows, 88 columns) created by selecting `subject`, `code`, and `mean`/standard deviation measurements (`std`) for each measure in `mergedData`.
        
5) **Uses descriptive activity names to name the activities in the data set.**

* Replace numbers in the `code` column of `tidyData` with the corresponding activity from `activities`.
        
6) **Appropriately labels the data set with descriptive variable names.**

* `code` column in `tidyData` renamed to `Activity`.
        
* All `Acc` in `tidyData` replaced by `Accelorometer`.
        
* All `Gyro` in `tidyData` replaced by `Gyroscope`.
        
* All `BodyBody` in `tidyData` replaced by `Body`.
        
* All `Mag` in `tidyData` replaced by `Magnitude`.
        
* All column names in `tidyData` that start with `f` start with `Frequency`.
        
* All column names in `tidyData` that start with `t` start with `Time`.
        
7) **From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.**

* `Data` (180 rows, 88 columns) created by summarizing `tidyData`. `tidyData` grouped by `subject` and `activity` and summarized `summarize()` by the mean `mean()` of each `Activity` and `subject`.
        
* Exported `Data` into `Data.txt`.
        
        
```{Week 4 Project}
summary(run_analysis.r)
```

