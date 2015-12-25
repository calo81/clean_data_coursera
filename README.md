### Cleaning Data from the Human Activity Recognition datasets


This repository contains a simple script, that cleans and prepare the data from [here](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip) to make it ready for further analysis.

Please look inside the README.txt inside that zipped file to understand the original data better.

#### What this project does

* Starting from the data in the extracted zip file it combines the training and test data to form a bigger data set.
* It keeps only the variables related to std and mean.
* It renames the variables in the dataset to give more meaningful names.
* It adds the activy by name to the data set
* It adds the subject to the data set
* It also summarises on the mean and the standard deviation for each of the 3 axis.

### What you will find in this repo:

* run_analysis.R: This is the cleaning script itself. To run it simply source it from your R session. **Important:** It is worth noticing however that this script expects [this zipfile](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip) to be already downloaded and extracted into a `data` directory relative to the workinf directory. This scripts does all the work, starting from the raw data files and generating a tidy data in the file `tidyData.txt` set at the end.
* CodeBook.md: This file explains the data itself and how everything fits together. How we got from the raw data extracted from the ZIP file into our clean tidy data set.