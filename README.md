
ReadMe
================

The basic principles of tidy data<sup>1</sup>, as outlined in Wickham's paper, are:
  1. Each observation forms a row
  2. Each variable forms a column
  3. Each type of observational unit forms a table

To understand the idea of tidy data more clearly, it helps to know the other side of the coin, i.e. messy data.
From the same paper, we know that messy data has the following characteristics:

  1. Column headers are values, not variable names
  2. Multiple variables are stored in one column
  3. Variables are stored in both rows and columns
  4. Multiple types of observational units are stored in the same table.
  5. A single observational unit is stored in multiple tables.
  
Looking at the "raw" data set given to us in the problem, it is apparent that it does not violate any of the tidy data principles, nor does it qualify as messy data for any reason.  
However, as we go on to look at the various data sets provided to us, we notice a few issues at large:

  1. There are too many data sets to draw data from, and therefore it looks like the data is scattered and/or fragmented.
  2. The unnamed columns makes the data tough to understand. The values in x_test and x_train do not make sense without any labels on them.
  3. The data, in their scattered form, lack context. The readMe file provided with the data lets us know that readings on different subjects and activities are recorded in the x_test 
     and x_train data sets, but as stand alone, these two files provide little understanding on which reading comes from which subject/activity.
  4. The feature names in features.txt does not seem to follow R naming conventions for variables. Characters like "()" and "-" are reserved special characters in R and are best avoided
     in variable names.
  5. There are a few errors that can be classified as duplication errors or typos in feature names.
  6. Activities represented as numbers do not make much sense.
  7. Finally, the data does not look "prepared" to answer a specific question. Data analysis always starts with the question to be answered, and it's the single most important entity
     for cleaning and analyzing data. To that end, it's important for the data to look complete, readable and easy to analyze.
	 
In a nutshell, while the raw data itself is not exactly messy, there's ample potential to clean it and make it more tidy. We do not live in a perfect world, and there's probably no such  
thing as "perfect data". That is why I prefer to think of data (and almost everything in this world) on a relative scale. After reshaping and transforming data to make it more clear and 
readable, I think I have succeeded in creating a "tidier" data set.

### Reasons why tidy_data data set is tidier

    This section illustrates the transformation of messier data into tidier data using every step of the problem.

      Step 1 of cleaning data: Merge the training and the test sets to create one data set
  
      - Only the files that would be used in the process/end of producing tidy data are read. This helps in cutting the clutter.
	    For example, the files from the inertial folder are not read because they simply do not contribute to solving the specific problem asked.
		
	  - While merging the subject and activity together with the corresponding reading values for test and train, it's done in the order of subject, activity and the values. 
	    This is done to ensure that the resulting data set is clear and readable, with the larger problem in mind.
		
	  - The test and train data sets are merged to make processing of data easier and to avoid redundancy.
	  
	  - The resultant data set, named full_dataset has 10299 observations and 563 variables, and it pretty much contains all the data we need for analysis.
	  
      Step 2 of cleaning data: Extract only the measurements on the mean and standard deviation for each measurement
  
      - Extracting specific columns necessitates assigning names to the columns in the data set. This provides more meaning to the data, and therefore makes it tidier
	  
	  - The resultant data set, mean_std_data, has 10299 observations and 68 rows, and contains just the right amount of data we need to answer questions on mean and standard deviation measurements.
	  
     Step 3 of cleaning data: Use descriptive activity names to name the activities in the data set
  
      - The activity numbers, which did not make sense before, are now given descriptive names to make it more tidy
	  
     Step 4 of cleaning data: Appropriately label the data set with descriptive variable names
  
      - The attached variable names are made tidier by getting rid of naming styles that do not conform to R naming conventions. Here, characters such as "()" and "-"
	    are removed. 
		
	  - Camel casing is adopted to make it consistent and readable
	  
	  - A few of the variable names had the pattern "BodyBody" which was clearly a naming error. These instances were replaced with "Body"
	  
    Step 5 of cleaning data: From the data set in step 4, create a second, independent tidy data set with the average of each variable for each activity and each subject
  
      - The already "quite tidy" dataset from the previous step is condensed to produce average values for each unique subject-activity combination. 
	    This makes the data less long(less narrow) than before and also makes it easier to interpret the context of the experiment.
		
	  - The resultant data set, tidy_data, has only 180 observations (30 subjects * 6 activities) and 68 variables.
		

### Choice of narrow(long) or wide data set

      - From reading the discussion thread on tidy data<sup>2</sup>, I realized that the choice of a wide or narrow tidy data set depends on the specific problem.
	  
      - My final tidy data set, tidy_data, is considered wide since the observations are spread across several columns.
	  
	  - In wide format, each observation includes all the measurement features for an observation of an activity at a moment, wheread in narrow format it is a 
	    specific subject/activity/observation combination<sup>2</sup>
		
      - In the context of the problem, I think it makes sense to keep it this way instead of melting the data to make it narrow. In the process of making data tidier,
        the length of the data set has significantly reduced from 10,299 rows to 180 rows, making the data set look more balanced.
		
      - Melting the data set would make it very long, with dimensions 11,880*3, making it more difficult to read. I prefer the wide format for this particular problem.		
		

### General coding steps for run_analysis.R

1. The files from the following zip folder are unzipped and extracted to "UCI HAR Dataset" folder in the working directory.
    https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

2. In R Studio, the current working directory is set to "UCI HAR Dataset".

3. The required files from test and train folders are read using read.table() function. 
   The files in the inertial folder are not read because they are not used to produce the tidy data set.
   
4. A series of transformations are applied in the form of merging data sets, pattern searching and renaming variable names, extracting subsets of the data to produce new data sets, and performing numeric calculations and aggregations.  

5. The output for every line is validated by viewing it in the console, often using dim function to verify the size of new and/or transformed data sets.

6. The script is executed using source("run_analysis.R") command in RStudio. Alternatively, the GUI "Run" option can be used.

7. The tidy data set is written to a text file using write.table(). The output file is generated in the current working directory.
   tidy_data.txt contains a data frame called tidy_data with 180 observations and 68 variables.

8. The text file can be opened and viewed on a text editor such as Notepad++. Alternatively, it can be viewed on the R console using
   data <- read.table("tidy_data.txt", header = TRUE) 
   View(data) 

9. codeBook.md contains information about the variables and values in the tidy data set.


### Expected Output

"tidy_data.txt" -- a text file saved to your working directory, containing the tidy data set with the afore-mentioned variables, and with correct calculations of values.
https://github.com/gaiatri/Getting_and_Cleaning_Data/blob/master/tidy_data.txt - a copy of the same file from the GitHub repository.	


### References

1. http://www.jstatsoft.org/v59/i10/paper , "Tidy Data",  H. Wickham, Aug 2014
2. https://class.coursera.org/getdata-010/forum/thread?thread_id=241, Coursers Getting and Cleaning Data discussion thread titled "Tidy Data and the Assignment", Jan 2015
