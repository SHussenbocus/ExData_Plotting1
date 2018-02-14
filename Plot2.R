library(dplyr)
library(readr)

###Read Data In----
dataIn <- read_delim('household_power_consumption.txt', delim=";",
                     col_names=TRUE,
                     col_types=NULL)

###Filter Data ----
dataToPlot <- dataIn  %>% 
  mutate(RDate=as.Date((Date),"%d/%m/%Y"),Rtime=format(Time,"%H:%M:%S")) %>%
  filter(RDate >= as.Date("2007-02-01") & RDate <= as.Date("2007-02-02"))%>% mutate(weekday=weekdays(RDate))

###Plot 2 ----
with(dataToPlot,plot(Global_active_power,type="l",xlab="",xaxt="n",ylab="Global Active Power (kilowatts)"))
axis(1,at=c(1,0.5*nrow(dataToPlot),nrow(dataToPlot)),labels=c("Thu","Fri","Sat"))
dev.copy(png,file="Plot2.png",width=480,height=480)
dev.off()
