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
data4 <- data2 %>%
        filter(SCC.Level.Two == "Highway Vehicles - Diesel" 
               | SCC.Level.Two == "Highway Vehicles - Gasoline")
data4 <- data4$SCC
data3 <- data1 %>%
        filter(SCC %in% data4 & fips == "24510") %>%
        group_by(year) %>%
        summarise(sum(Emissions), mean(Emissions))

## Create plot 5
png(file.path(getwd(), "plots/plot5.png"), 750, 524, "px")
ggplot(data = data3, aes(x = factor(year), y = `sum(Emissions)`)) +
        geom_col(alpha = 0.8, width = 0.75, col = "black", lwd = 0.2,
                 aes(fill = factor(year))) +
        theme_tufte() +
        geom_rangeframe() +
        scale_fill_economist(stata = TRUE) +
        geom_rangeframe() +
        guides(fill = FALSE) +
        labs(title = "Fine Particulate Emissions from Highway Vehicles in Baltimore City\n1999 - 2008",
             x = "year",
             y = expression("PM"[2.5]*" Emissions (Tonnes)"))
dev.off()


