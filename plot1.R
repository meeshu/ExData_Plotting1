## Read the table as data.table 

elec<-data.table(read.table("household_power_consumption.txt",sep=";",na.strings="?",stringsAsFactors=FALSE,header=TRUE))

##drop rows not within the time frame of 1st Feb 2007 to 2nd Feb 2007
res<-elec[as.Date(Date,"%d/%m/%Y") %between% c(as.Date("01-02-2007","%d-%m-%Y"),as.Date("02-02-2007","%d-%m-%Y")),]

##For plots: plot on screen device and then copy to png
hist(res$Global_active_power,main="Global Active Power", xlab="Global Active Power (in kilowatts)", ylab="Frequency", col="Red")
dev.copy(png,file="plot1.png")
dev.off()