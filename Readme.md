Getting and Cleaning Data Course - Project
------------------------------------------

This document has the purpose of explaining the functioning of the run_analysis.R script, included in the 
repository https://github.com/paulourbano/GetDataCourseProject.

The script works in isolated fashion, not requiring the source of other R scripts. As a first action, it
tries to download and unzip the data for the project, as linked in the project home page. There is no 
error handling code for situations in which the files could not be retrieved; it is assumed that the 
folder in which run_analysis.R is located contains the unziped data of the project.

