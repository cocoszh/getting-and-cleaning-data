## Load test files
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")
x_test <- read.table("./UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt")

## Load train set data files
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")
x_train <- read.table("./UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt")

## Load label data
activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt")
features <- read.table("./UCI HAR Dataset/features.txt")

##### 1. Merge the training and the test sets to create one data set.

## Merge rows of subjects from both data sets
subject_test_train <- rbind(subject_test,subject_train)
x_test_train <- rbind(x_test,x_train)
y_test_train <- rbind(y_test,y_train)

##### 2. Extracts only the measurements on the mean and standard deviation for each measurement

library(dplyr)
featuresMeanStd <- filter(features,grepl('mean\\(\\)',features$V2) | grepl('std\\(\\)',features$V2))
x_test_train <- select(x_test_train, featuresMeanStd$V1)

##### 3. Uses descriptive activity names to name the activities in the data set
activity_labels$V2 <- tolower(activity_labels$V2)
activity_labels$V2 <- gsub('_'," ", activity_labels$V2) 
for (i in 1:nrow(activity_labels)) {
        y_test_train[,1] <- activity_labels$V2[i]
}

##### 4. Appropriately labels the data set with descriptive variable names. 
featuresMeanStd$V2 <- gsub('Acc', "acceleration", featuresMeanStd$V2)
featuresMeanStd$V2 <- gsub('Mag', "magnitude", featuresMeanStd$V2)
featuresMeanStd$V2 <- gsub('Body', "body", featuresMeanStd$V2)
featuresMeanStd$V2 <- gsub('Gyro', "gyro", featuresMeanStd$V2)
featuresMeanStd$V2 <- gsub('Jerk', "jerk", featuresMeanStd$V2)
featuresMeanStd$V2 <- gsub('mean\\(\\)', "mean", featuresMeanStd$V2)
featuresMeanStd$V2 <- gsub('std\\(\\)', "stddeviation", featuresMeanStd$V2)
featuresMeanStd$V2 <- gsub('^t', "time_", featuresMeanStd$V2)
featuresMeanStd$V2 <- gsub('^f', "frequency_", featuresMeanStd$V2)
featuresMeanStd$V2 <- gsub('-', "_", featuresMeanStd$V2)

colnames(subject_test_train) <- "subject"
colnames(y_test_train) <- "activity"
colnames(x_test_train) <- featuresMeanStd$V2

## 5. From the data set in step 4, creates a second, independent tidy data set with the average of each 
## variable for each activity and each subject.Merge by columns data frames subject_test_and_train, 
## y_test_and_train, x_test_and_train into one data frame for test_and_train, group by subject and activity, 
## and summarize each numeric variable

## Create tidy data set
TidyData <- cbind(subject_test_train, y_test_train, x_test_train) %>% 
        group_by(subject, activity) %>% summarise_each(funs(mean))

## Export tidy data set
write.table(TidyData, file = "./UCI HAR Tidy Dataset.txt", row.names = FALSE, sep="|")

