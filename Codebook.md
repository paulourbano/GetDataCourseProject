Getting and Cleaning Data Course - Codebook
-------------------------------------------

The tidy data frame submitted to the coursera Getting and Cleaning Data Course project represents
the second, independent data frame requested in the item 5 of the project description.

The data included in it is the merge of the train and test data sets, besides two extra variables:
one containing the textual label identifying the activity; and another, identifying
the subject which produced the observation data.

The 180 observations in the submmited data set were produced by calculating the average of each variable for each activity and each subject. In this way, for each combination of the 30 subjects and the 6 activity labels, the average of the 561 variables was calculated.

The process to do this involved the subsetting of the data by subject and activity label and the calculation, via the colMeans function, of the average of each variable.

Is order to create a tidy data set, the varibles were properly renamed, using data retrieved from the features.txt file. The numeric variables were converted from character to numeric and the activity label variable was converted to factor. Each of the 561 sensor related variables was taken from embedded accelerometer and gyroscope in a human activity recognition projec, on which 3-axial linear acceleration and 3-axial angular velocity were measured at a constant rate of 50Hz. For brevity and clarity, we point the original site as a reference: 

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

