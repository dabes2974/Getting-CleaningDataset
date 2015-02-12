setwd("I:/Tmp/R/Getting&CleaningDataset/")

if (!require("dplyr")) {
install.packages("dplyr")
}


library(dplyr)



# save getdata_projectfiles_UCI HAR Dataset.zip in your work directory
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl, destfile = "getdata_projectfiles_UCI HAR Dataset.zip", method = "curl")

# unzip forder and start
unzip("getdata_projectfiles_UCI HAR Dataset.zip")

# load test
subject_test 	<- as.tbl(read.table("UCI HAR Dataset/test/subject_test.txt"))
X_test 			<- as.tbl(read.table("UCI HAR Dataset/test/X_test.txt"))
Y_test 			<- as.tbl(read.table("UCI HAR Dataset/test/y_test.txt"))

# load train 
subject_train 	<- as.tbl(read.table("UCI HAR Dataset/train/subject_train.txt"))
X_train 		<- as.tbl(read.table("UCI HAR Dataset/train/X_train.txt"))
Y_train 		<- as.tbl(read.table("UCI HAR Dataset/train/y_train.txt"))

# load activity names
activity_labels <- as.tbl(read.table("UCI HAR Dataset/activity_labels.txt"))

# load feature names
features 		<- as.tbl(read.table("UCI HAR Dataset/features.txt"))
headers 	<- features %>% select(V2) %>% t %>% as.vector

# name test and train features
names(X_test) <- headers
names(X_train) <- headers

# select only mean and std headers
mean_and_std <- grepl("mean\\(\\)|std\\(\\)", headers)

# filter mean and std columns on test and train
X_test_mean_and_std <- X_test[,mean_and_std]
X_train_mean_and_std <- X_train[,mean_and_std]


# bind all test and train rows and ceate one single dataset
dts <- bind_cols(bind_rows(subject_test, subject_train),bind_rows(Y_test, Y_train),bind_rows(X_test_mean_and_std, X_train_mean_and_std))
names(dts)[1] <- "Subject"
names(dts)[2] <- "Activity"


# summarise by subject and activity

dts_means <- dts %>% 
		#  group by subject and activity
		group_by(Subject,Activity) %>%
		# means
		summarise_each(funs(mean)) %>%
		# ungroup
		ungroup() %>%
		# change activity label
		left_join(select(activity_labels, Activity = V1, activity_Label =V2)) %>%
		mutate(Activity = activity_Label) %>%
		select(-activity_Label)
		
		

		
#give activities better names

write.table(dts_means, file="./tidy.txt", sep="\t", row.names=FALSE)
