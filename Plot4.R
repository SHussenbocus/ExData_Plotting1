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

###Plot 4 ----
par(mfrow=c(2,2))
with(dataToPlot, {
  plot(Global_active_power,type="l",xlab="",xaxt="n",ylab="Global Active Power")
  axis(1,at=c(1,0.5*nrow(dataToPlot),nrow(dataToPlot)),labels=c("Thu","Fri","Sat"))
  plot(Voltage,type="l",xlab="datetime",xaxt="n",ylab="Voltage")
  axis(1,at=c(1,0.5*nrow(dataToPlot),nrow(dataToPlot)),labels=c("Thu","Fri","Sat"))
  plot(Sub_metering_1,type="l",xaxt="n",xlab="",ylab="Energy sub metering")
  points(dataToPlot$Sub_metering_2,type="l",col="red")
  points(dataToPlot$Sub_metering_3,type="l",col="blue")
  axis(1,at=c(1,0.5*nrow(dataToPlot),nrow(dataToPlot)),labels=c("Thu","Fri","Sat"))
  legend("topright",bg="transparent",box.lty=0,lty=c(1,1,1),lwd=1,y.intersp=0.8,col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
  plot(Global_reactive_power,type="l",xlab="datetime",xaxt="n",ylim=c(0.0,0.5))
  axis(1,at=c(1,0.5*nrow(dataToPlot),nrow(dataToPlot)),labels=c("Thu","Fri","Sat"))

})

dev.copy(png,file="Plot4.png",width=480,height=480)
dev.off()
