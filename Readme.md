Getting and Cleaning Data Course - Project
------------------------------------------

This document has the purpose of explaining the functioning of the run_analysis.R script, included in the 
repository https://github.com/paulourbano/GetDataCourseProject.

The script works in isolated fashion, not requiring the source of other R scripts. As a first action, it
tries to download and unzip the data for the project, as linked in the project home page. There is no 
error handling code for situations in which the files could not be retrieved; it is assumed that the 
folder in which run_analysis.R is located contains the unziped data of the project.

The script procedes to read the train and test data from the project folder, merging both in a single
data frame with added variables coresponding to the activity label and subject for each observation. The 
activity label variable uses data from the actvity_labels.txt file; the subject variable uses data from
the y_train.txt and y_text.txt. The total number of variables in this raw data frame is 563.

The script extracts only the measurements on the mean and standard deviation for each measurement, from the
merged data frame described above. This is done by searching the data in features.txt for patterns "mean"
and "std" and subsetting the data frame in order to contain only variables which names include those substrings,
besides the activity label and subject ones. The total number of variables in this first data set is equal to 81.
From the same features.txt data are extrated the descriptive variable names used to identify the first data frame
columns.

In the final part of the script, a second, independent data frame is created, using the original raw, 563 varibles
wide data frame as a basis. In nested for-loops the data frame is subsetted using the subjects (total of 30) and
the activity labels (total of 6), creating the resulting 180 observations contained in the final data frame. In 
order to respect the requirements of a tidy data frame, the variables as properly renamed using the data from
features.txt.

As the last command, the write.table function is used to create a file submitted to evaluation.