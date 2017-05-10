# getting-and-cleaning-data: Course Project

# Introduction
This repository shows all of my work for the project from Coursera course "Getting and Cleaning Data."

# About the Raw Data
The features are unlabeled and can be found in the x_test.txt and the activity labels can be found in the y_test.txt file. The test subjects are found in the subject_test.txt file.

# About the Script and Tidy Data Set
I wrote a script called run_analysis.R so that the test and training sets merge. To make this work there are two prerequisites that must be met:
  1. the UCI HAR dataset must be extracted.
  2. the UCI HAR dataset must be available in a directory called "UCI HAR Dataset."

Once the script has been run and the datasets have been merged only the columns associated with the mean and standard deviation are shown and labeled.

The script will create a tidy data set which contains the means of all the columns per test subject and activity.This tidy data set will be written into a file called secTidy.txt, which can be found in this repository.

# About the Codebook
The CodeBook.md file explains the transformations performed and the resulting data and variables.
