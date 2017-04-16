# Explotatory Data Analysis
## Final project for the Exploratory Data Analysis course (part of the Data Science track on Coursera)
### Readme
The aim of this project is to analyse data on the emissions of fine particulate matter in the United States over a period from 1999 to 2008. Data is taken from the National Emissions Inventory database.  The specfic dataset (29MB) is available [here](https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip).

### Info
The repo contains 6 R scripts and 6 .png files.  The scripts are the code to output the image files.  Each image is a different analysis of the dataset and is summarised below.  Each script can be used independently of the other, each will access the data and create relevant directories.  As default the dataset will be saved in a subdirectory of your working directory called "data" and the plots will be saved in a subdirectory of your working directory called "plots".

#### Plots
The 6 evaluations are as follows:

##### 1
![](https://github.com/afox226293/exploratory_analysis_2/blob/master/plot1.png)

The first plot looks at the total emissions (given in millions of tonnes) of fine particualte matter (PM2.5) across the United States for 4 individual years (1999, 2002, 2005, 2008) across a ten year period.  The graph shows a year on year decrease of total emissions.  As per the instructions of the project this is produced using base R graphics.

##### 2
![](https://github.com/afox226293/exploratory_analysis_2/blob/master/plot2.png)

The second plot shows the total emissions of fine particulate matter(PM2.5) in tonnes over a ten year period by comparing the total emissions from all sources from four years(1999, 2002, 2005, 2008). It shows that overall there has been a decrease over the period however there was an increase between 2002 and 2005.  As per the instructions of the project this is produced using base R graphics.

##### 3
![](https://github.com/afox226293/exploratory_analysis_2/blob/master/plot3.png)

The third plot looks at the emissions in Baltimore seperated out by the catagory of source (point, nonpoint, onroad, nonroad).  To allow for direct comparison a boxplot is provided measuring the log10 of the emissions.  As per the instructions of the project this is produced using ggplot2.

##### 4
![](https://github.com/afox226293/exploratory_analysis_2/blob/master/plot4.png)

The fourth plot shows the total fine particulate matter emissions from Coal based sources for the period across the United States, the height of the bar shows the total annual emissions (in thousands of tonnes). The fill of each bar shows the mean emission per source in tonnes.  Both show a decrease across the period particularly between 2005 and 2008.

##### 5
![](https://github.com/afox226293/exploratory_analysis_2/blob/master/plot5.png)

The fifth plot shows total emissions of fine particulate matter from motor vehicle sources in Baltimore city for the years (1999, 2002, 2005 & 2008) in tonnes.  The analysis shows a marked decrease from 1999 to 2002 and then a continual but slower decrease for the rest of the period.

##### 6
![](https://github.com/afox226293/exploratory_analysis_2/blob/master/plot6.png)

The final plot shows a comparison of the results of plot 5 with the same results from Los Angeles, California.  These results have not been balanced for size of the sample area however it is clear from the graphic whilst Baltimore saw a consistant decrease in emissions from motor vehicles for the period the emissions in Los Angeles increased between 1999 and 2005 before decreasing in the period between 2005 and 2008. However the total emissions in 2008 were still higher than the 1999 levels.