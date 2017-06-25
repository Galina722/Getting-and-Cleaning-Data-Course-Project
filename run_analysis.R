##Downloading and unzipping file
if(!file.exists("./data")){dir.create("./data")}
fileurl1 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
dest1 <- "/Users/Galka/Downloads/Coursera/Getting and Cleaning Data/Week4/data/dataset.zip"
download.file (fileurl1, dest1)
unzip(zipfile="./data/dataset.zip",exdir="./data")

##Reading files

## test
x_test <- read.table("./data/UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("./data/UCI HAR Dataset/test/y_test.txt")
subject_test <- read.table("./data/UCI HAR Dataset/test/subject_test.txt")

##train
x_train <- read.table("./data/UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("./data/UCI HAR Dataset/train/y_train.txt")
subject_train <- read.table("./data/UCI HAR Dataset/train/subject_train.txt")

activity_labels <- read.table("./data/UCI HAR Dataset/activity_labels.txt")

features <- read.table("./data/UCI HAR Dataset/features.txt")

##assigning colnames
colnames(x_train) <- features[,2]
colnames(x_test) <- features[,2]
colnames(y_train) <-"activityId"
colnames(y_test) <-"activityId"
colnames(subject_train) <- "subjectId"
colnames(subject_test) <- "subjectId"
colnames(activity_labels) <- c("activityId", "activityType")

##merging
y_train <- merge(y_train, activity_labels, by="activityId")
all_train <- cbind(y_train, subject_train, x_train)
y_test <- merge(y_test, activity_labels, by="activityId")
all_test <- cbind(y_test, subject_test, x_test)
train_and_test <- rbind(all_train, all_test)

##extract mean & std and descriptive activity names
pttrn<-'mean|std'
train_and_test <- train_and_test[,c(1,2,3,grep( pttrn,colnames(train_and_test)))]
mean_and_std   <- colnames(train_and_test)

##use descriptive variable names
## t - Time
## f - Frequency
## Acc - Accelerometer
## Gyro - Gyroscope
## Mag - Magnitude
## std - Standard
## BodyBody - Body
## meanFreq - Mean Frequency

old <- c("^t","^f","BodyBody","Acc","std","Gyro","Mag","meanFreq","-", "\\.\\.", "[()]")
new <- c("Time ", "Frequency ", "Body ", "Accelerometer ", "standard", "Gyroscope ",
	 "Magnitude ", "Mean Frequency", " "," ","")
mas   <- colnames(train_and_test)
for (i in seq_along (old)) {mas <- gsub (old[i], new[i], mas, perl = TRUE)}
colnames(train_and_test) <- mas

##creating second data set
install.packages("plyr")
library(plyr)

tidy_tat <- aggregate(. ~subjectId + activityId, train_and_test, mean)
tidy_tat <- tidy_tat [order(tidy_tat$subjectId, tidy_tat$activityId), ]
tidy_tat <- tidy_tat[-grep("activityType", colnames(tidy_tat))]

##creating txt file for a new tidy data set
write.table(tidy_tat, file = "TidyTrainAndTest.txt", row.name = FALSE)
