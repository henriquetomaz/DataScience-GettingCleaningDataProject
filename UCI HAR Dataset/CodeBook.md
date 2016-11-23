---
title: "CodeBook"
author: "Henrique Amaral Silva"
date: "11/22/2016"
output: pdf_document
---

##### Reashap2 Library
##Flexibly restructure and aggregate data using just two functions: melt and 'dcast' (or 'acast').
library(reshape2)

##read activity_labels.txt and get the activities and theirs respective labels
labels <- read.table("./activity_labels.txt",col.names=c("activity_id","activity_name"))

## read the features from features.txt 
features <- read.table("features.txt")
featureNames <-  features[,2]

## get the test data  
testData <- read.table("./test/X_test.txt")
testSubjectId <- read.table("./test/subject_test.txt")
testActivityId <- read.table("./test/y_test.txt")
colnames(testData) <- feature_names
colnames(testSubjectId) <- "subject_id"
colnames(testActivityId) <- "activity_id"
testData <- cbind(testSubjectId , testActivityId , testData)

## get the training data 
trainningData <- read.table("./train/X_train.txt")
trainningSubjectId <- read.table("./train/subject_train.txt")
trainningActivityId <- read.table("./train/y_train.txt")
colnames(trainningData) <- featureNames
colnames(trainningSubjectId) <- "subject_id"
colnames(trainningActivityId) <- "activity_id"
trainningData <- cbind(trainningSubjectId , trainningActivityId , trainningData)

##Get all data together into the same dataframe
Data <- rbind(trainningData,testData)

## mean and std
mean_col_idx <- grep("mean",names(Data),ignore.case=TRUE)
mean_col_names <- names(Data)[mean_col_idx]
std_col_idx <- grep("std",names(Data),ignore.case=TRUE)
std_col_names <- names(Data)[std_col_idx]
meanstddata <-Data[,c("subject_id","activity_id",mean_col_names,std_col_names)]

##merge  activities and mean/std values  
descrnames <- merge(labels,meanstddata,by.x="activity_id",by.y="activity_id",all=TRUE)

##melt dataset
dataMelt <- melt(descrnames,id=c("activity_id","activity_name","subject_id"))
meanData <- dcast(dataMelt,activity_id + activity_name + subject_id ~ variable,mean)

## create the tidy dataset in a file called "tidy_movement_data"
write.table(meanData,"./tidy_movement_data.txt",row.name=FALSE)