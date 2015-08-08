#Author: Gangadhar Nittala
#Coursera URL: https://class.coursera.org/exdata-031/
#Exploratory Data Analysis, Project#1, problem#3

#The dates for which we need to get data
start_date=as.Date("2007-02-01","%Y-%m-%d")
end_date  =as.Date("2007-02-02","%Y-%m-%d")

#Read the txt file. Separator is ? and 
#strings don't need to be changed to factors. Also,
#as mentioned in the comments, the unknown (NA) is ?
power_data<-read.csv("household_power_consumption.txt",sep=";",
                     stringsAsFactors = FALSE,na.strings=c("?"))
#Convert the Date and Time to the required data-types
power_data$Date=as.Date(power_data$Date,"%d/%m/%Y")
#Get the power data required for the problem
#Note that we are looking for 48 hours of data i.e.
#from 1st Feb 2007, till the end of 2nd Feb 2007)
power_2_days<-subset(power_data,power_data$Date>=start_date & 
                       power_data$Date<=end_date)
#As the timezone is not known, set this explicitly 
#strptime will otherwise set it to system timezone 
#Timezone setting is optional for this problem
power_2_days$Time<-format(power_2_days$Time,format="%T",usetz=FALSE)
#Convert sub-meter data to numbers
power_2_days$Sub_metering_1=as.integer(power_2_days$Sub_metering_1)
power_2_days$Sub_metering_2=as.integer(power_2_days$Sub_metering_2)
power_2_days$Sub_metering_3=as.integer(power_2_days$Sub_metering_3)
#Add a date-time variable for plotting in the line graph
power_2_days$DateTime = paste(power_2_days$Date,power_2_days$Time)
power_2_days$DateTime = strptime(power_2_days$DateTime,"%Y-%m-%d %H:%M:%S")

#get the Y-axis limit, for a scaled out plot
ylimit=max(power_2_days$Sub_metering_1,power_2_days$Sub_metering_2,power_2_days$Sub_metering_3)
#Get a PNG file ready to be copied to
png(filename = "plot3.png",width=480,height=480,units="px")
#plot the line graph
with(power_2_days,{
  plot(DateTime,Sub_metering_1,type="l",col="black",ylim=c(0,ylimit),yaxt="n",xlab="",ylab="")
  points(DateTime,Sub_metering_2,type="l",col="red",ylim=c(0,ylimit),yaxt="n",xlab="",ylab="")
  points(DateTime,Sub_metering_3,type="l",col="blue",ylim=c(0,ylimit),yaxt="n",xlab="",ylab="")
})
#Add the annotations
axis(side=2,at=c(0,10,20,30))
title(ylab="Energy sub metering")
#Get the elements for the legend
legend_elems=Filter(function(x){grepl("Sub_metering",x)},colnames(power_2_days))
legend("topright",lwd=1, col = c("black","red", "blue"), legend = legend_elems)
#Copy the image into the plot file
dev.off()