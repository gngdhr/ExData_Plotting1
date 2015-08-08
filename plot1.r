#Author: Gangadhar Nittala
#Coursera URL: https://class.coursera.org/exdata-031/
#Exploratory Data Analysis, Project#1, problem#1

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
#To be able to display as Histogram, the 'Global Active Power' needs to be a numeric
power_2_days$Global_active_power=as.numeric(power_2_days$Global_active_power)
#Get a PNG file ready to be copied to
png(filename = "plot1.png",width=480,height=480,units="px")
#Display the histogram. The xlim is set, as it is required as per the problem
hist(power_2_days$Global_active_power,xaxt="n",
      col="Red",xlab="Global Active Power(kilowatts)",
      ylab="Frequency",main="Global Active Power")
#draw the x-axis as per the requirement in the example
axis(side=1, at=c(0,2,4,6))
#Copy the image into the plot file
dev.off()
