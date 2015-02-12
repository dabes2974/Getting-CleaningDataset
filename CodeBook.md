# data collected from the accelerometers from the Samsung Galaxy S smartphone


data obtain from : https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

description from : http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 




## The data

The dataset (zip) includes the following files:

-    'README.txt'
-    'features_info.txt': Shows information about the variables used on the feature vector.
-    'features.txt': List of all features.
-    'activity_labels.txt': Links the class labels with their activity name.
-    'train/X_train.txt': Training set.
-    'train/y_train.txt': Training labels.
-    'test/X_test.txt': Test set.
-    'test/y_test.txt': Test labels.

The following files are available for the train and test data. Their descriptions are equivalent.

-    'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30.
-    'train/Inertial Signals/total_acc_x_train.txt': The acceleration signal from the smartphone accelerometer X axis in standard gravity units 'g'. Every row shows a 128 element vector. The same description applies for the 'total_acc_x_train.txt' and 'total_acc_z_train.txt' files for the Y and Z axis.
-    'train/Inertial Signals/body_acc_x_train.txt': The body acceleration signal obtained by subtracting the gravity from the total acceleration.
-    'train/Inertial Signals/body_gyro_x_train.txt': The angular velocity vector measured by the gyroscope for each window sample. The units are radians/second.




## step follow in the process (used dplyr package)

-    load X, y and subject for train and test
-    bind X, y and subject data for train and test
-    load in features descriptions
-    set descriptive names for all columns in bind X, y and subject
-    select features containing measurements on the mean and standard deviation
-    read in activity descriptions
-    join activity with descriptive labels
-    join measurements with activity labels
-    write this first result data set to csv file "measurements_mean_std.txt"
-    join result with subject id
-    summarise means group by activity and subject
-    write result to csv file "tidy.txt"


## Run run_analysis.R, steps:

set your work directory which contains getdata_projectfiles_UCI HAR Dataset.zip
unzip it here (UCI HAR Dataset folder is create)

run run_analysis.R

-    Require dplyr library.
-    Load both test and train data
-    Load the features and activity labels.
-    Extract the mean and standard deviation column names and data.
-    Merge data set.
-    summarise by mean.
-    labels activity
-    save in tidy.csv