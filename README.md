# getting-and-cleaning-data
This is a course project for coursera getting and cleaning data

# First: Load files into directory: 
Download and unzip the "UCI HAR Dataset" into working directory and use read.table function to read into R

# Second: Cleaning data set

#1. Merges the training and the test sets to create one data set.
rowcombine subject from test with subject from train, x from test and x from train, y from test and y from train.

#2. Extracts only the measurements on the mean and standard deviation for each measurement. 
use dplyr package to extract only mean and std

#3. Uses descriptive activity names to name the activities in the data set
adding names to data set

#4. Appropriately labels the data set with descriptive variable names. 
adding description to variable names.

#5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for #each activity and each subject.
write to txt file
