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

###Plot 3 ----
with(dataToPlot,plot(Sub_metering_1,type="l",xaxt="n",xlab="",ylab="Energy sub metering"))
points(dataToPlot$Sub_metering_2,type="l",col="red")
points(dataToPlot$Sub_metering_3,type="l",col="blue")
axis(1,at=c(1,0.5*nrow(dataToPlot),nrow(dataToPlot)),labels=c("Thu","Fri","Sat"))
legend("topright",lty=c(1,1,1),lwd=1,y.intersp=0.8,col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
dev.copy(png,file="Plot3.png",width=480,height=480)
dev.off()
