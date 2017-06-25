# Getting-and-Cleaning-Data-Course-Project
This repo contains my course project for Getting and Cleaning Data course in Data Science specialization with Corsera

The goal of this project is to prepare tidy data set for further analysis.

Original data set was downloaded from:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

The data in this dataset represent data collected from the accelerometers from the Samsung Galaxy S smartphones. A full description is available at the site where the data was obtained:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Original data set comes with it's own README file and additional files describing the structure of data, i.e. features_info.txt

The purpose of created R script (run_analysis.R):
  1. Merge the training and test sets to create one data set
  2. Extract only the measurements on the mean and standard deviation for each measurement
  3. Use descriptive activity names in the data set
  4. Label data set with descriptive variable names
  5. From the data set in step 4, create a second, independent tidy datat set with the average of each variable for each activity and each subject.
  
The result of submitted R script run_analysis.R is a file called TidyTrainAndTest.txt
