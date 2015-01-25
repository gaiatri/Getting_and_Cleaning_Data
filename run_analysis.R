
# #################### Code for Course Project -- Getting and Cleaning Data ########################## #

setwd("./UCI HAR Dataset")

# Reading all test data
x_test <- read.table("test/X_test.txt") # dimensions are 2947 * 561
y_test <- read.table("test/Y_test.txt") # dimensions are 2947 * 1
subject_test <- read.table("test/subject_test.txt") # dimensions are 2947 * 1

# Adding activity labels(y_test) and subject(subject_test) to x_test
test <- cbind(subject_test,  y_test, x_test) # dimensions are 2947 * 563

# Reading all train data
x_train <- read.table("train/X_train.txt") # dimensions are 7352 * 561
y_train <- read.table("train/Y_train.txt") # dimensions are 7352 * 1
subject_train <- read.table("train/subject_train.txt") # dimensions are 7352 * 1

# Adding activity labels(y_train) and subject data(subject_train) to x_train
train <- cbind(subject_train, y_train, x_train) # dimensions are 7352 * 563

# ********** Step 1 of Cleaning Data *************
# Merge the training and the test sets to create one data set.
full_dataset <- rbind(test, train) # dimensions are 10,299 * 563
#dim(full_dataset)

# ********** Step 2 of Cleaning Data *************
#Extract only the measurements on the mean and standard deviation for each measurement. 

features <- read.table("features.txt") # dimensions are 561*2 
#dim(features)
names(full_dataset)[1] <- "subject"
names(full_dataset)[2] <- "activity"
names(full_dataset)[3:563] <- as.character(features[,2])

mean_std_data <- full_dataset[, grep("subject|activity|mean\\(\\)|std\\(\\)", colnames(full_dataset))] # dimensions are 10,299 * 68
#dim(mean_std_data)

# ********** Step 3 of Cleaning Data *************
# Use descriptive activity names to name the activities in the data set

activity_labels <- read.table("activity_labels.txt")
activity_factor <- factor(mean_std_data[,2], labels = activity_labels[,2])
mean_std_data[,2] <- activity_factor

# ********** Step 4 of Cleaning Data *************
#Appropriately label the data set with descriptive variable names. 

names(mean_std_data) <- gsub("-", "", names(mean_std_data)) # Removing "-" in variable names
names(mean_std_data) <- gsub("\\()", "", names(mean_std_data)) # Removing "()" in variable names
names(mean_std_data) <- gsub("mean", "Mean", names(mean_std_data)) # Making all variables camel case
names(mean_std_data) <- gsub("std", "Std", names(mean_std_data)) # Making all variables camel case
names(mean_std_data) <- gsub("BodyBody", "Body", names(mean_std_data)) # Fixing a naming error
names(mean_std_data) <- gsub("^t", "time", names(mean_std_data)) # making variable names more descriptive
names(mean_std_data) <- gsub("^f", "freq", names(mean_std_data)) # making variable names more descriptive


# ********** Step 5 of Cleaning Data *************
#From the data set in step 4, create a second, independent tidy data set with the average of each variable for each activity and each subject.

library(dplyr) # Install dplyr package if you haven't already, and then load the package

tidy_data <-
        mean_std_data %>%
        group_by(subject, activity) %>%
        summarise_each(funs(mean)) %>%
        print(tidy_data)

# Dimensions of tidy_data are 180 * 68

# Finally, output the data to a text file
write.table(tidy_data, "../tidy_data.txt", row.names = FALSE)




