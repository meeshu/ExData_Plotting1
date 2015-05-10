## Read the table as data.table 

elec<-data.table(read.table("household_power_consumption.txt",sep=";",na.strings="?",stringsAsFactors=FALSE,header=TRUE))

##drop rows not within the time frame of 1st Feb 2007 to 2nd Feb 2007
res<-elec[as.Date(Date,"%d/%m/%Y") %between% c(as.Date("01-02-2007","%d-%m-%Y"),as.Date("02-02-2007","%d-%m-%Y")),]

##Concatenate date and time in a new variable

res[,DateTimec:=paste(Date,Time,sep=" ")]

#Set global graphic parameters- no. of rows*columns and direction of entry (mfrow),relative size of axis and legend text
#and margins

par(mfrow=c(2,2),cex=0.65,mar=c(5,4,1.5,2),cex.axis=0.9)

#plot1
plot(strptime(res$DateTimec,"%d/%m/%Y %H:%M:%S"),res$Global_active_power,type="n",ylab="Global Active Power",xlab="")
lines(strptime(res$DateTimec,"%d/%m/%Y %H:%M:%S"),res$Global_active_power)

#plot2    
plot(strptime(res$DateTimec,"%d/%m/%Y %H:%M:%S"),res$Voltage,type="n",ylab="Voltage",xlab="Datetime")
lines(strptime(res$DateTimec,"%d/%m/%Y %H:%M:%S"),res$Voltage)

#plot3
plot(strptime(res$DateTimec,"%d/%m/%Y %H:%M:%S"),res$Sub_metering_1,type="n",ylab="Energy sub metering",xlab="")
lines(strptime(res$DateTimec,"%d/%m/%Y %H:%M:%S"),res$Sub_metering_1,col="Black")
lines(strptime(res$DateTimec,"%d/%m/%Y %H:%M:%S"),res$Sub_metering_2,col="Red")
lines(strptime(res$DateTimec,"%d/%m/%Y %H:%M:%S"),res$Sub_metering_3,col="Blue")
legend("topright",legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),col=c("Black","Red","Blue"),lwd=1, bty="n")

#plot4
plot(strptime(res$DateTimec,"%d/%m/%Y %H:%M:%S"),res$Global_reactive_power,type="n",ylab="Global Reactive Power",xlab="Datetime",ylim=c(0.0,0.6))
lines(strptime(res$DateTimec,"%d/%m/%Y %H:%M:%S"),res$Global_reactive_power,lwd=1)

#copy plot to png
dev.copy(png,file="plot4.png")
dev.off()
