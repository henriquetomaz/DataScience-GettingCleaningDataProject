# The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis. You will be graded by your peers on a series of yes/no questions related to the project. You will be required to submit: 1) a tidy data set as described below, 2) a link to a Github repository with your script for performing the analysis, and 3) a code book that describes the variables, the data, and any transformations or work that you performed to clean up the data called CodeBook.md. You should also include a README.md in the repo with your scripts. This repo explains how all of the scripts work and how they are connected.
# 
# One of the most exciting areas in all of data science right now is wearable computing - see for example this article . Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained:
#     
#     http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
# 
# Here are the data for the project:
#     
#     https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
# 
# You should create one R script called run_analysis.R that does the following.
# 
# Merges the training and the test sets to create one data set.
# Extracts only the measurements on the mean and standard deviation for each measurement.
# Uses descriptive activity names to name the activities in the data set
# Appropriately labels the data set with descriptive variable names.
# From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

# reshape2: Flexibly restructure and aggregate data 

run_analysis <- function()
{
    library(reshape2)
    
    # read activity_labels.txt and get the activities and theirs respective labels
    labels <- read.table("./activity_labels.txt",col.names=c("activity_id","activity_name"))
    # read features.txt 
    features <- read.table("features.txt")
    featureNames <-  features[,2]
    # get the test data  
    testData <- read.table("./test/X_test.txt")
    testSubjectId <- read.table("./test/subject_test.txt")
    testActivityId <- read.table("./test/y_test.txt")
    colnames(testData) <- feature_names
    colnames(testSubjectId) <- "subject_id"
    colnames(testActivityId) <- "activity_id"
    testData <- cbind(testSubjectId , testActivityId , testData)
    # get the training data 
    trainningData <- read.table("./train/X_train.txt")
    trainningSubjectId <- read.table("./train/subject_train.txt")
    trainningActivityId <- read.table("./train/y_train.txt")
    colnames(trainningData) <- featureNames
    colnames(trainningSubjectId) <- "subject_id"
    colnames(trainningActivityId) <- "activity_id"
    trainningData <- cbind(trainningSubjectId , trainningActivityId , trainningData)
    
    #Get all data together into the same dataframe
    Data <- rbind(trainningData,testData)
    
    # mean and std
    mean_col_idx <- grep("mean",names(Data),ignore.case=TRUE)
    mean_col_names <- names(Data)[mean_col_idx]
    std_col_idx <- grep("std",names(Data),ignore.case=TRUE)
    std_col_names <- names(Data)[std_col_idx]
    meanstddata <-Data[,c("subject_id","activity_id",mean_col_names,std_col_names)]
    
    #merge  activities and mean/std values  
    descrnames <- merge(labels,meanstddata,by.x="activity_id",by.y="activity_id",all=TRUE)
    #melt dataset
    dataMelt <- melt(descrnames,id=c("activity_id","activity_name","subject_id"))
    meanData <- dcast(dataMelt,activity_id + activity_name + subject_id ~ variable,mean)
    
    ## create the tidy dataset
    write.table(meanData,"./tidy_movement_data.txt",row.name=FALSE)
}

