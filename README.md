# Using run_analysis.R

In order to use run_analysis() to create the tidy data set, first unzip the file getdata-projectfiles-UCI HAR Dataset.zip in the working directory. This will create a subdirectory called getdata-projectfiles-UCI HAR Dataset. Do not modify the locations of the files in this directory or any of its subdirectories.

Next, run the function run_analysis(), which outputs the tidy data set. This is the only function required to produce the tidy data set. It should have fairly thorough comments, but some important information about the function follows:
* The tidy data set keeps the original names for the variables and the activity codes, since I believe they are quite descriptive.
* Per the instructions, the only variables from the input data that are kept in the tidy data set are those that are means or standard deviations, and hence have 'mean()' or 'std()' as part of their name. Note that I did not consider MeanFrequency to be a mean.
* Each observation represents a combination of subject and activity. For example, one observation (row) is labeled 1.WALKING, hence, it is from subject 1, while the subject was walking.

