rm(list=ls())
library(dplyr)

###############################################################################

## This section of the code checks if the input data set is already in the
## working directory (the UCI HAR Dataset folder with corresponding input files).
## It would be downloaded from the web source, otherwise.

filename_folder <- "UCI HAR Dataset"
filename_zip <- "assignment_dataset.zip"


if (file.exists(filename_folder)){
        print("Dataset already in working directory")
} else if (!file.exists(filename_zip)){
        file_url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
        download.file(file_url, filename_zip)
        unzip(filename_zip)
}

###############################################################################

## This section of the code loads/reads the data sets for processing and 
## analysis

# Load the data sets describing the activity labels and features

activity_labels <- read.table("UCI HAR Dataset2/activity_labels.txt")
features <- read.table("UCI HAR Dataset2/features.txt")

# Load the train and test data sets

test <- read.table("UCI HAR Dataset2/test/X_test.txt")
test_labels <- read.table("UCI HAR Dataset2/test/y_test.txt")
test_subjects <- read.table("UCI HAR Dataset2/test/subject_test.txt")

train <- read.table("UCI HAR Dataset2/train/X_train.txt")
train_labels <- read.table("UCI HAR Dataset2/train/y_train.txt")
train_subjects <- read.table("UCI HAR Dataset2/train/subject_train.txt")

###############################################################################

## This section of the code merges the datasets and filters the variables/
## features needed for analysis

# Merge the test and training data sets to form a single data set

merged_data <- rbind(test, train)
merged_labels <- rbind(test_labels, train_labels)
merged_subjects <- rbind(test_subjects, train_subjects)

# Extract only the data corresponding to mean and standard deviation 
# measurements for each measurement type

filter_index <- grep(".*mean.*|.*std.*", features[,2])
features_needed <- features[filter_index,2]
merged_data <- merged_data[filter_index]

# Perform another merge process involving the merged subjects, merged labels,
# and merged data (the filtered one)

merged_all <- cbind(merged_subjects, merged_labels, merged_data)

###############################################################################

## This section modifies feature and variable names using appropriate labels for 
## better understanding of the final merged data set

features_needed <- gsub("[-()]", "", features_needed)
features_needed <- gsub("mean", "Mean", features_needed)
features_needed <- gsub("std", "Std", features_needed)
features_needed <- gsub("BodyBody", "Body", features_needed)
colnames(merged_all) <- c("Subject", "Activity", as.character(features_needed))
merged_all$Subject <- as.factor(merged_all$Subject)
merged_all$Activity <- factor(merged_all$Activity, labels = as.character(activity_labels[,2]))

###############################################################################

## This section of the code creates a second, independent tidy data set with the
## average of each variable for each activity and each subject

merged_all.mean <- merged_all %>% group_by(Activity, Subject) %>% summarise_all(funs(mean))
write.table(merged_all.mean, "tidydata.txt", row.names = FALSE, quote = FALSE)