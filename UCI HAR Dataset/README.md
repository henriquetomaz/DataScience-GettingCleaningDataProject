---
title: "README"
author: "Henrique Amaral Silva"
date: "11/22/2016"
output: html_document
---

#####  Getting and Cleaning Data Course Project

#####  How to run
Source de scrip: source("run_analysis.R")
Run the sript: run_analysis()

######  About
Project: Human Activity Recognition Using Smartphones Dataset Version 1.0
Experiments carried out with a group of 30 volunteers within an age bracket of 19-48 years from which each person performed six activities

(a) WALKING
(b) WALKING_UPSTAIRS
(c) WALKING_DOWNSTAIRS
(d) SITTING
(e) STANDING
(f) LAYING

##### Feature Selection

tBodyAcc-XYZ
tGravityAcc-XYZ
tBodyAccJerk-XYZ
tBodyGyro-XYZ
tBodyGyroJerk-XYZ
tBodyAccMag
tGravityAccMag
tBodyAccJerkMag
tBodyGyroMag
tBodyGyroJerkMag
fBodyAcc-XYZ
fBodyAccJerk-XYZ
fBodyGyro-XYZ
fBodyAccMag
fBodyAccJerkMag
fBodyGyroMag
fBodyGyroJerkMag
angle
gravityMean
tBodyAccMean
tBodyAccJerkMean
tBodyGyroMean
tBodyGyroJerkMean

##### Variable Description

mean() : mean values of multiple measurements of the original variables. 

std(): Standard deviation of multiple measurements of the original variables. 

activity_id: Identifier, identifying the activity of each subject 

activity_name: Descriptive name of each subject's activity Type: Factor Values: WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING

subject_id : Identifier, identifying each subject Type: Integer Values: 1 : 30