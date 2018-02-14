library(dplyr)
library(readr)

###Read Data In----
dataIn <- read_delim('household_power_consumption.txt', delim=";",
                   col_names=TRUE,
                   col_types=NULL)

###Filter Data ----
dataToPlot <- dataIn  %>% 
                  mutate(RDate=as.Date((Date),"%d/%m/%Y"),Rtime=format(Time,"%H:%M:%S")) %>%
                 filter(RDate >= as.Date("2007-02-01") & RDate <= as.Date("2007-02-02"))

###Plot 1 ----
hist(dataToPlot$Global_active_power, main="Global Active Power",xlab="Global Active Power (kilowatts)", ylab="Frequency",col="red",ylim=c(0,1200))
dev.copy(png,file="Plot1.png",width=480,height=480)
dev.off()
