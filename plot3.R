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
        select(fips, Emissions, type, year) %>%
        filter(fips == "24510") %>%
        group_by(year, type)

## Create plot 3
png(file.path(getwd(), "plots/plot3.png"), 814, 571, "px")
ggplot(data = data3, aes(x = factor(year), y =log(Emissions))) +
        facet_grid(. ~ type) +
        geom_boxplot(notch = TRUE, notchwidth = .75, aes(fill = type), alpha = 0.7) +
        scale_fill_fivethirtyeight() +
        theme_tufte() +
        geom_rangeframe() +
        guides(fill = FALSE) +
        geom_jitter(alpha = 0.06, width = 0.2) +
        labs(title = "Fine Particulate Emissions in the Baltimore Area 1999 - 2008 by Source",
             x = "year",
             y = expression("(Log) PM"[2.5] * " Emissions"))
dev.off()