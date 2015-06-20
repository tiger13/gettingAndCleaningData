run_analysis <- function(){
  ## This function collects all the Samsung data, which is spread across numerous
  ## files, and forms one tidy data set. It assumes that the data is in a
  ## subdirectory of the working directory, called 
  ## 'getdata-projectfiles-UCI HAR Dataset'. It also assumes that the 
  ## subdirectories of 'getdata-projectfiles-UCI HAR Dataset' are organized in the
  ## same way as they are when they are extracted from 
  ## getdata-projectfiles-UCI HAR Dataset.zip.
  
  ## Concatenate X_train and X_test, which have 561 measurements
  ## for each observation.
  X_train <- read.table("getdata-projectfiles-UCI HAR Dataset\\UCI HAR Dataset\\train\\X_train.txt")
  
  X_test <- read.table("getdata-projectfiles-UCI HAR Dataset\\UCI HAR Dataset\\test\\X_test.txt")
  
  fullDataSet <- rbind(X_train, X_test)
  
  ## The y_test and y_train files give the activity code for each measurement.
  ## They should be appended to the data set as the first column.
  y_train <- read.table("getdata-projectfiles-UCI HAR Dataset\\UCI HAR Dataset\\train\\y_train.txt")
  
  y_test <- read.table("getdata-projectfiles-UCI HAR Dataset\\UCI HAR Dataset\\test\\y_test.txt")
  
  fullDataSet <- cbind(rbind(y_train, y_test), fullDataSet)
  
  ## Next, the subject_train and subject_test files identify the subject for 
  ## each row (observation). Append the subject file as the new first column.
  subject_train <- read.table("getdata-projectfiles-UCI HAR Dataset\\UCI HAR Dataset\\train\\subject_train.txt")
  
  subject_test <- read.table("getdata-projectfiles-UCI HAR Dataset\\UCI HAR Dataset\\test\\subject_test.txt")
  
  fullDataSet <- cbind(rbind(subject_train, subject_test), fullDataSet)
  
  ## The file features.txt has the names for all 561 variables.
  features <- read.table("getdata-projectfiles-UCI HAR Dataset\\UCI HAR Dataset\\features.txt", as.is=TRUE)
  
  names(fullDataSet) <- c("subject", "activity", features[,2])
  
  ## Keep only the columns that have "mean()" or "std()" as part of their name. Ok,
  ## keep the first two columns as well.
  selector <- c(1, 2, grep("mean[(]|std", names(fullDataSet)))
  fullDataSet <- fullDataSet[,selector]
  
  ## Add descriptive activity names. The names from the activity_labels.txt file
  ## seem descriptive enough to me.
  activity_labels <- read.table("getdata-projectfiles-UCI HAR Dataset\\UCI HAR Dataset\\activity_labels.txt", as.is=TRUE)
  for(i in 1:nrow(activity_labels)){
    fullDataSet[fullDataSet[,2]==i,2] <- activity_labels[i,2]
  }
  
  ## Now create the tidy data set. 
  
  ## First, take the mean of each variable for each combination of subject and 
  ## activity. The output is an array.
  tidyArray <- sapply(split(fullDataSet[,-1:-2], fullDataSet[,1:2]), colMeans, na.rm=TRUE)
  
  ## tidyArray contains all the column means, but it has them along the row axis.
  ## In order to make the tidy data frame, with each observation a row, and each
  ## variable a column, we must transpose the array before we create the data
  ## frame.
  tidyDataframe <- data.frame(t(tidyArray))
  
  tidyDataframe
}