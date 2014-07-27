## Coursera Getting and Cleaning Data course
## July 2014

# Download and unzip files
zipURL = "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(zipURL, "zipFile.zip", method="curl")
unzip("zipFile.zip")
# It is assumed that no errors occured in the statements above.


## Requirement 1: Merge the training and the test sets to create one data set.
# Load data sets
testDF = read.table("UCI HAR Dataset/test/X_test.txt")
trainDF = read.table("UCI HAR Dataset/train/X_train.txt")

# Add activity labels, testDF
testLabels = read.table("UCI HAR Dataset/test/y_test.txt")
testLabels$V1[testLabels$V1 == 1] = "WALKING"
testLabels$V1[testLabels$V1 == 2] = "WALKING_UPSTAIRS"
testLabels$V1[testLabels$V1 == 3] = "WALKING_DOWNSTAIRS"
testLabels$V1[testLabels$V1 == 4] = "SITTING"
testLabels$V1[testLabels$V1 == 5] = "STANDING"
testLabels$V1[testLabels$V1 == 6] = "LAYING"
testDF$Activity.Label = testLabels$V1

# Subject id, testDF
testSubjects = read.table("UCI HAR Dataset/test/subject_test.txt")
testDF$Subject = testSubjects$V1

# Add activity labels, trainDF
trainLabels = read.table("UCI HAR Dataset/train/y_train.txt")
trainLabels$V1[trainLabels$V1 == 1] = "WALKING"
trainLabels$V1[trainLabels$V1 == 2] = "WALKING_UPSTAIRS"
trainLabels$V1[trainLabels$V1 == 3] = "WALKING_DOWNSTAIRS"
trainLabels$V1[trainLabels$V1 == 4] = "SITTING"
trainLabels$V1[trainLabels$V1 == 5] = "STANDING"
trainLabels$V1[trainLabels$V1 == 6] = "LAYING"
trainDF$Activity.Label = trainLabels$V1

# Subject id, testDF
trainSubjects = read.table("UCI HAR Dataset/train/subject_train.txt")
trainDF$Subject = trainSubjects$V1

# Merge test and train data sets
mergeDF = rbind(testDF, trainDF)
mergeDF$Activity.Label = as.factor(mergeDF$Activity.Label)

## Requirement 2: Extracts only the measurements on the mean and standard deviation for each measurement.
# Read the file with the description of the variables
features = read.table("UCI HAR Dataset/features.txt")
variablesMean = grepl("mean", features$V2)
variablesStd = grepl("std", features$V2)

# Create a new data frame with all features related to mean and standard
# deviation measurements, plus the activity label (#562)
filteredDF = mergeDF[,c(which(variablesMean | variablesStd), 562, 563)]

## Requirement 3: Uses descriptive activity names to name the activities in the data set.
# Already done. The filteredDF$Activity.Label variable contains the activity names.

## Requirement 4: Appropriately labels the data set with descriptive variable names. 
names(filteredDF) = c(as.character(features$V2[which(variablesMean | variablesStd)]), "Activity.Label", "Subject")

# Save the first tidy data frame
# write.table(filteredDF, file = "GetData-Project-FirstDataFrame.txt", sep = ",", col.names = colnames(filteredDF))

## Requirement 5: Creates a second, independent tidy data set with the average of each variable 
## for each activity and each subject.

# Names for every variable
names(mergeDF) = c(as.character(features$V2), "Activity.Label", "Subject")

activityLevels = levels(mergeDF$Activity.Label)
subjects = unique(mergeDF$Subject)

# Create empty data frame with all the variables from mergeDF
# finalDF = mergeDF[mergeDF$Subject == 31,]
finalMatrix = matrix(, ncol=563, nrow=0)

for(sub in 1:length(subjects)){
      for (act in 1:length(activityLevels)) {
            localDF = subset (mergeDF, mergeDF$Subject == sub & mergeDF$Activity.Label == activityLevels[act])
            # Calculate means, excluding varibles Subject and Label
            localMeans = colMeans(localDF[,1:561])            
            finalMatrix = rbind(finalMatrix, c(localMeans, activityLevels[act], sub))
      }
}

finalDF = data.frame(finalMatrix)

for(i in 1:561) {
      finalDF[,i] = as.numeric(as.character(finalDF[,i]))
}

finalDF[,562] = as.factor(finalDF[,562])
finalDF[,563] = as.numeric(finalDF[,563])

names(finalDF) = c(as.character(features$V2), "Activity.Label", "Subject")

# Save the final data frame
write.table(finalDF, file = "GetData-Project-FinalDataFrame.txt", sep = ",", col.names = colnames(finalDF))
