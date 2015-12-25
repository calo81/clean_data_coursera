## This script is to be run after the datafile is downloaded and unzipped in the "data" directory relative to the workspace

library(dplyr)
testData = read.table("./data/test/X_test.txt")
trainData = read.table("./data/train/X_train.txt")

# We combine the test and train data together
allData <- rbind(testData, trainData)
colNames <- make.names(columns[, 1])
features <- read.table("./data/features.txt")
columns <- select(features, V2)

# We set new names for the Data Frame variables
names(allData) <- colNames
valid_column_names <- make.names(names=names(allData), unique=TRUE, allow_ = TRUE)
names(allData) <- valid_column_names
allData <- select(allData, contains(".mean."), contains(".std."))
allData <- allData %>% rename_(.dots=setNames(names(.), tolower(gsub("\\.\\.\\.Z", "_z_axis", names(.)))))
allData <- allData %>% rename_(.dots=setNames(names(.), tolower(gsub("\\.\\.\\.y", "_y_axis", names(.)))))
allData <- allData %>% rename_(.dots=setNames(names(.), tolower(gsub("\\.\\.\\.x", "_x_axis", names(.)))))
allData <- allData %>% rename_(.dots=setNames(names(.), tolower(gsub("^t", "time_", names(.)))))
allData <- allData %>% rename_(.dots=setNames(names(.), tolower(gsub("^f", "frequency_", names(.)))))
allData <- allData %>% rename_(.dots=setNames(names(.), tolower(gsub("\\.\\.", "", names(.)))))

testSubjects <- read.table("./data/test/subject_test.txt")
trainSubjects <- read.table("./data/train/subject_train.txt")

# We combine the subjects in test and train
allSubjects <- rbind(testSubjects, trainSubjects)

# We giv a proper name to the subject variable
allSubjects <- dplyr::rename(allSubjects, Subject=V1)


activityLabels <- read.table("./data/activity_labels.txt")
testActivities <- read.table("./data/test/y_test.txt")
trainActivities <- read.table("./data/train/y_train.txt")

# We combine test and train activities
allActivities <- rbind(testActivities, trainActivities)

# We now add the corresponding activity name to the integer value of it. An give the variabel a proper name
library(plyr)
activitiesWithName <- plyr::join(allActivities, activityLabels, type = "inner")
activitiesWithName <- dplyr::rename(activitiesWithName, Activity=V2)

# We add the extra columns for activities and subjects
allData <- cbind(allData, activitiesWithName)
allData <- cbind(allData, allSubjects)

# We select just the relevant variables from the data set, and then extract the tidy data
firstDataSet <- select(allData, Subject, Activity, contains(".mean"), contains(".std"))
grouped <- group_by(firstDataSet, Subject, Activity)
tidyData <- grouped %>% summarise_each(funs(mean))

write.table(tidyData, "./tidyData.txt", row.names = FALSE) 


