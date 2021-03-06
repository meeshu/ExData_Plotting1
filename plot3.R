## Read the table as data.table 

elec<-data.table(read.table("household_power_consumption.txt",sep=";",na.strings="?",stringsAsFactors=FALSE,header=TRUE))

##drop rows not within the time frame of 1st Feb 2007 to 2nd Feb 2007
res<-elec[as.Date(Date,"%d/%m/%Y") %between% c(as.Date("01-02-2007","%d-%m-%Y"),as.Date("02-02-2007","%d-%m-%Y")),]

##Concatenate date and time in a new variable

res[,DateTimec:=paste(Date,Time,sep=" ")]


##For plots: plot on screen device and then copy to png

#Use strptime to convert to date use type="n" to not plot points on the graph
plot(strptime(res$DateTimec,"%d/%m/%Y %H:%M:%S"),res$Sub_metering_1,type="n",ylab="Energy sub metering",xlab="")

#Use lines to create the time series graph
lines(strptime(res$DateTimec,"%d/%m/%Y %H:%M:%S"),res$Sub_metering_1,col="Black")
lines(strptime(res$DateTimec,"%d/%m/%Y %H:%M:%S"),res$Sub_metering_2,col="Red")
lines(strptime(res$DateTimec,"%d/%m/%Y %H:%M:%S"),res$Sub_metering_3,col="Blue")

#Add legend
legend("topright",legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),col=c("Black","Red","Blue"),lwd=1)

dev.copy(png,file="plot3.png")
dev.off()