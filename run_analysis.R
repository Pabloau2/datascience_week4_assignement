
# THIS IS THE CODE BOOK FOR ASSIGNEMENT OF WEEK 4
# It contains the code used to perform the transformations on the basic data provided
# to obtain a FINAL DATA FRAME ("df_final"), with the desired information.
# For detailed information on Variables, Data and Workflow, see README.TXT
############################
# DESCRIPTION
############################
# Read into R and display "subject_train.txt".
# Has subject ID's and is of size 7352 x 1
my_subject_train <- read.table("subject_train.txt",header=F)
dim(my_subject_train)
str(my_subject_train)

# Read into R and display "y_train.txt"
# Has Code of activities as 1 - 6. Of Size 7352 x 1
my_y_train <- read.table("y_train.txt",header=F)
dim(my_y_train)
str(my_y_train)

# Read into R and display "X_train.txt"
# Is a dataframe with measurements. Size 7352 x 561
my_X_train <- read.table("X_train.txt",header=F)
dim(my_X_train)
str(my_X_train)

# Features.txt has the names of the columns of "X_train.txt"
# Here we substitute the column names ("V1-..."V561") for the descriptive names in "Features.txt"
my_features <- read.table("features.txt",header=F)
dim(my_features)
str(my_features)

######################################
# CODE : To facilitate comprehension, the code has been setup in "processes"
######################################

# Process 1
# 1.  Create a dataframe with "train" data (7352 x 1)
df_train <- read.table("X_train.txt",header=F)
dim(df_train)
str(df_train)

# 1.1 Capture 561 colnames from "features.txt"
mycols <- read.table("features.txt", header = F, stringsAsFactors = F)
mycolnames <- as.vector(t(as.matrix(mycols[-1])))

# 1.2 Change colnames of "X_train.txt" using "features.txt" -> df_train1 (7352 x 561)
df_train1 <- setNames(df_train, c(mycolnames))
dim(df_train1)
str(df_train1)

# 1.3 Join data from "subject_train.txt" with "y_train.txt" with "df_train1" -> df_train2
my_subject_train <- read.table("subject_train.txt",header=F)
str(my_subject_train)
my_y_train <- read.table("y_train.txt",header=F)
str(my_y_train)
df_train2 <- cbind.data.frame(my_subject_train,my_y_train, df_train1)
dim(df_train2)
str(df_train2)

## RESULTS IN A DATAFRAME "df_train2" which has all data from "train" observations (7352 x 563)

# Process 2
# 2.  Create a dataframe with "test" data (2947 x 561)
df_test <- read.table("X_test.txt",header=F)
dim(df_test)
str(df_test)

# 2.1 Capture 561 colnames from "features.txt"
mycols <- read.table("features.txt", header = F, stringsAsFactors = F)
mycolnames <- as.vector(t(as.matrix(mycols[-1])))

# 2.2 Change colnames of "X_test.txt" using "features.txt" -> df_test1
df_test1 <- setNames(df_test, c(mycolnames))
dim(df_test1)
str(df_test1)

# 2.3 Join data from "subject_test.txt" + "y_test.txt" with "df_test1" -> df_test2
my_subject_test <- read.table("subject_test.txt",header=F)
str(my_subject_test)
my_y_test <- read.table("y_test.txt",header=F)
str(my_y_test)
df_test2 <- cbind.data.frame(my_subject_test,my_y_test, df_test1)
dim(df_test2)
str(df_test2)

## RESULTS IN A DATAFRAME "df_test2" which has all data from "test" observations (2947 x 563)

# Process 3 Join "df_train2" and "df_test2" dataframes
# 3.1 Correct first two column labels (they are both "V1") renaming to "id" and "code"
# for "Train"
names(df_train2)[1:2] <- c("id","code")
str(df_train2)
names(df_test2)[1:2] <- c("id","code")
str(df_test2)

# 3.2 merge the dataframes to obtain "total" dataframe dimension 10,299 x 563
total <- rbind(df_train2, df_test2)
dim(total)
str(total)

# Process 4 filter columns keeping only "means and std deviations" columns
# 4.1 filter dataframes
my_colnames1 <- colnames(total)
#str(my_colnames1)
my_colnames2 <- grep("id|code|mean|Mean|std", my_colnames1)
str(my_colnames2)
# 4.2  Select cols that have "mean" or "std" only. Keep "id" and "code"
my_colnames_final <- my_colnames1[c(my_colnames2)]
str(my_colnames_final)

# Process 5 create a smaller data frame as result of selection in Process 4. THIS IS THE FINAL OUTPUT (df_final) of the assigment
df_final <- total[, my_colnames_final]
dim(df_final)
str(df_final)

## RESULTS IN A DATAFRAME "df_final" which has all data from "test" observations (10,299 x 88)
