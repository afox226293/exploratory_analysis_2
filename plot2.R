require(ggplot2); require(ggthemes); require(tidyverse); require(RColorBrewer)

## Create data directory in working directory
filepath <- file.path(getwd(), "data")
if(!file.exists(filepath)) {
        dir.create(filepath)
}

## Check to see if file previously downloaded or extracted
if(!file.exists(file.path(filepath, "FNEI_data.zip"))){
        url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
        download.file(url, destfile = file.path(filepath, "FNEI_data.zip"))
        datapath <- file.path(filepath, "FNEI_data.zip")
        unzip(datapath, exdir = filepath)
        print("data downloaded and extracted")
} else if(!file.exists(file.path(filepath, "summarySCC_PM25.rds"))) {
        datapath <- file.path(filepath, "FNEI_data.zip")
        unzip(datapath, exdir = filepath)
        print("data extracted")
}

## Check if data in environment else read in...
if(!exists("data1")) {
        data1 <- read_rds(file.path(filepath, "summarySCC_PM25.rds"))
}
if(!exists("data2")) {
        data2 <- read_rds(file.path(filepath, "Source_Classification_Code.rds"))
}

## Check if plots directory exists, else create it
if(!file.exists(file.path(getwd(), "plots"))) {
        dir.create(file.path(getwd(), "plots"))
}

## Tidy data
data3 <- data1 %>%
        select(year, Emissions, fips) %>%
        filter(fips == "24510") %>%
        group_by(year) %>%
        summarise(sum(Emissions))

## Create plot 2
png(file.path(getwd(), "plots/plot2.png"), 703, 493, "px")
par(mfrow = c(1, 1), bg = "white", lwd = 0.2)
barplot(data3$`sum(Emissions)`, names.arg = data3$year, col=brewer.pal(3, "BuPu"),
        family = "Times")
title(main = "Fine Particulate Emmisions From Sources In Baltimore City",
      xlab = "year",
      ylab = expression(PM[2.5] * " Emissions (Tonnes)"), family = "Times")
dev.off()

