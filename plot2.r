#Author: Gangadhar Nittala
#Coursera URL: https://class.coursera.org/exdata-031/
#Exploratory Data Analysis, Project#1, problem#2


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
#Convert the active power to numeric so that we are able to measure it
power_2_days$Global_active_power=as.numeric(power_2_days$Global_active_power)
#Add a date-time variable for plotting in the line graph
power_2_days$DateTime = paste(power_2_days$Date,power_2_days$Time)
power_2_days$DateTime = strptime(power_2_days$DateTime,"%Y-%m-%d %H:%M:%S")
#Get a PNG file ready to be copied to
png(filename = "plot2.png",width=480,height=480,units="px")
plot(power_2_days$DateTime,power_2_days$Global_active_power,
    type="l",xlab="",ylab="Global Active Power(kilowatts)")
#Copy the image into the plot file
dev.off()

