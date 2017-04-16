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
        filter(SCC %in% data4) %>%
        filter(fips == "06037" | fips == "24510") %>%
        group_by(year, fips) %>%
        summarise(sum(Emissions))

data3$fips <- recode(data3$fips, "06037" = "Los Angeles", "24510" = "Baltimore")

## Create plot 6
png(file.path(getwd(), "plots/plot6.png"), 750, 526, "px")
ggplot(data3, aes(factor(year), `sum(Emissions)`)) +
        facet_grid(. ~ factor(fips, levels = c("Los Angeles", "Baltimore"))) +
        geom_col(aes(fill = factor(year)), alpha = 0.8, col = "black", lwd = 0.2) +
        theme_minimal() +
        scale_fill_economist(stata = TRUE) +
        guides(fill = FALSE) +
        labs(title = "Fine Particulate Emissions in Los Angeles and Baltimore\n1999 - 2008",
             x = "year", y = expression("Total PM"[2.5]*" Emissions (Tonnes)"))
dev.off()
