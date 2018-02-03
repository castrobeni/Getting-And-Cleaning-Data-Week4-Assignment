# Code Book

This code book describes the variables, the data, and methodologies that led to the data clean up.

The information below for the data set and attributes are excerpted from the source website of the data found here: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones. Description from the guide files (.txt files) that were retrieved along with the input data were also imported for documentation.

## Data Set Information

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time (t) and frequency (f) domain.

The dataset includes the following files:

* 'README.txt'

* 'features_info.txt': Shows information about the variables used on the feature vector.

* 'features.txt': List of all features.

* 'activity_labels.txt': Links the class labels with their activity name.

* 'train/X_train.txt': Training set.

* 'train/y_train.txt': Training labels.

* 'test/X_test.txt': Test set.

* 'test/y_test.txt': Test labels.

The following files are available for the train and test data. Their descriptions are equivalent. 

- 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 

- 'test/subject_test.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 

### Feature Selection

The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 

These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

* tBodyAcc-XYZ
* tGravityAcc-XYZ
* tBodyAccJerk-XYZ
* tBodyGyro-XYZ
* tBodyGyroJerk-XYZ
* tBodyAccMag
* tGravityAccMag
* tBodyAccJerkMag
* tBodyGyroMag
* tBodyGyroJerkMag
* fBodyAcc-XYZ
* fBodyAccJerk-XYZ
* fBodyGyro-XYZ
* fBodyAccMag
* fBodyAccJerkMag
* fBodyGyroMag
* fBodyGyroJerkMag

The set of variables that were estimated from these signals are: 

* mean(): Mean value
* std(): Standard deviation
* mad(): Median absolute deviation 
* max(): Largest value in array
* min(): Smallest value in array
* sma(): Signal magnitude area
* energy(): Energy measure. Sum of the squares divided by the number of values. 
* iqr(): Interquartile range 
* entropy(): Signal entropy
* arCoeff(): Autorregresion coefficients with Burg order equal to 4
* correlation(): correlation coefficient between two signals
* maxInds(): index of the frequency component with largest magnitude
* meanFreq(): Weighted average of the frequency components to obtain a mean frequency
* skewness(): skewness of the frequency domain signal 
* kurtosis(): kurtosis of the frequency domain signal 
* bandsEnergy(): Energy of a frequency interval within the 64 bins of the FFT of each window.
* angle(): Angle between to vectors.

### Attribute Information

For each record in the dataset it is provided: 
* Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration. 
* Triaxial Angular velocity from the gyroscope. 
* A 561-feature vector with time and frequency domain variables. 
* Its activity label. 
* An identifier of the subject who carried out the experiment.

## Script (run_analysis.R) Information

This details the procedures used in cleaning up the data. This follows the goals listed below as instructed in the course assignment.

* Merge the test and the training data sets to create one data set
* Extract only the measurements on the mean and standard deviation for each measurement
* Use descriptive activity names to name the activities in the data set
* Appropriately label the data set with descriptive variable names
* Create a second and independent tidy data set with the average of each variable for each activity and each subject

An initial step was done which checks if the data to be used are already present in the working directory. It would be downloaded, otherwise. The data sets (in text files) imported are enumerated below.

* 'activity_labels.txt'
* 'features.txt'
* 'X_test.txt'
* 'y_test.txt'
* 'subject_test.txt'
* 'X_train.txt'
* 'y_train.txt'
* 'subject_train.txt'

### Merging the Test and Training Sets

Data sets that correspond to test and training sets were initially merged respectively. That is, three data sets were produced: the combined test and training set, the combined labels set, and the combined subject set. Another merging process was then performed to combine the test and training sets into a larger dataset. However, the latter was done after filtering only the variables needed as will be discussed next.

### Extracting Mean and Standard Deviation Measurements

An index vector was created by using the grep function to the features data to look for entries containing the text mean and std. The index vector was then used to subset the features and merged data set so that only the needed columns were kept.

### Labelling the Data Set

After merging the initially combined data sets, labelling of the variable names was then made. The feature names were first edited using the gsub function in order to make them more understandable. As for the variable/column names, descriptive names were used, including the edited feature names. The columns pertaining to the subject and activity variables were then transformed to factor class for better representation.

### Creating the Tidy Data

A new object was then created which now exhibits the tidy data. It was done by averaging each variable for each activity and each subject. The dplyr package was the main workforce in this section, particularly the group_by and summarize_all functions. This tidy data set was then written and saved into a text file named 'tidydata.txt'.
