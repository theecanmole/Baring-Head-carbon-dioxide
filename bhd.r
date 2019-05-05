# start a new project in R Studio and associate the folder 'bhd' with that project

library(here)
here() starts at ~/bhd
here()
set_here()
Created file .here in ~/bhd 

getwd()
[1] "~/baringhead"

ls()
character(0)

# obtain Baring Head data sheet from Scripps
urlnz <- c("http://scrippsco2.ucsd.edu/assets/data/atmospheric/stations/flask_co2/monthly/monthly_flask_co2_nzd.csv")
download.file(urlnz, "co2_nzd.csv")
rm(urlnz) 

# obtain Maunu Loa Hawaii data sheet from Scripps
urlmlo <- c("http://scrippsco2.ucsd.edu/assets/data/atmospheric/stations/in_situ_co2/monthly/monthly_in_situ_co2_mlo.csv")
download.file(urlmlo, "co2_mlo.csv")
rm(urlmlo)

# read in the Baring Head data skipping the first 57 rows
bhd <- read.csv("co2_nzd.csv",skip=57,header=FALSE, sep = ",",dec=".",stringsAsFactors =FALSE, strip.white =TRUE ,na.strings =-99.99)

# examine the dataframe
str(bhd)
'data.frame':	504 obs. of  10 variables:
 $ V1 : int  1977 1977 1977 1977 1977 1977 1977 1977 1977 1977 ...
 $ V2 : int  1 2 3 4 5 6 7 8 9 10 ...
 $ V3 : int  28140 28171 28199 28230 28260 28291 28321 28352 28383 28413 ...
 $ V4 : num  1977 1977 1977 1977 1977 ...
 $ V5 : num  NA NA NA NA NA ...
 $ V6 : num  NA NA NA NA NA ...
 $ V7 : num  NA NA NA NA NA ...
 $ V8 : num  NA NA NA NA NA ...
 $ V9 : num  NA NA NA NA NA ...
 $ V10: num  NA NA NA NA NA ...
 
head(bhd[7:504,]) 
   V1 V2    V3       V4     V5     V6     V7     V8     V9    V10
7  1977  7 28321 1977.537 332.75 332.28 332.62 332.14 332.75 332.28
8  1977  8 28352 1977.622 -99.99 -99.99 332.98 332.35 332.98 332.35
9  1977  9 28383 1977.707 332.55 332.10 333.00 332.56 332.55 332.10
10 1977 10 28413 1977.789 332.34 332.33 332.77 332.76 332.34 332.33
11 1977 11 28444 1977.874 333.79 333.91 332.85 332.97 333.79 333.91
12 1977 12 28474 1977.956 333.32 333.46 333.02 333.16 333.32 333.46

head(bhd[c(-1,-2,-3,-5,-6,-7,-8,-9)])

head(bhd[3:504,c(-1,-2,-3,-5,-6,-7,-8,-9)])
        V4    V10
7  1977.537 332.28
8  1977.622 332.35
9  1977.707 332.10

# subset just the date and co2 measurements (10th column that includes infilled data so no NAs)

bhd <-bhd[7:504,c(-1,-2,-3,-5,-6,-7,-8,-9)]

# Add names
names(bhd)<-c("Date","CO2")

str(bhd)
'data.frame':	498 obs. of  2 variables:
 $ Date: num  1978 1978 1978 1978 1978 ...
 $ CO2 : num  332 332 332 332 334 ...

# read in the Mauna Loa data skipping the first 291 rows so first row is 1977 07

mlo <- read.csv("co2_mlo.csv",skip=291,header=FALSE, sep = ",",dec=".",na.strings =-99.99)

# examine the dataframe
str(mlo)
'data.frame':	510 obs. of  10 variables:
 $ V1 : int  1977 1977 1977 1977 1977 1977 1978 1978 1978 1978 ...
 $ V2 : int  7 8 9 10 11 12 1 2 3 4 ...
 $ V3 : int  28321 28352 28383 28413 28444 28474 28505 28536 28564 28595 ...
 $ V4 : num  1978 1978 1978 1978 1978 ...
 $ V5 : num  335 333 332 331 332 ...
 $ V6 : num  334 334 335 334 334 ...
 $ V7 : num  335 333 331 331 333 ...
 $ V8 : num  334 334 334 334 335 ...
 $ V9 : num  335 333 332 331 332 ...
 $ V10: num  334 334 335 334 334 ...

# subset out just the date and co2 
mlo <-mlo[1:498,c(-1,-2,-3,-6,-7,-8,-9,-10)]
names(mlo)<-c("Date","CO2")
str(mlo)
'data.frame':	498 obs. of  2 variables:
 $ Date: num  1978 1978 1978 1978 1978 ...
 $ CO2 : num  335 333 332 331 332 ...
 
head(mlo) 
     Date    CO2
1 1977.537 334.92
2 1977.622 332.75
3 1977.707 331.59
4 1977.789 331.16
5 1977.874 332.40
6 1977.956 333.85

tail(mlo) 
       Date    CO2
493 2018.537 408.90
494 2018.622 407.10
495 2018.707 405.59
496 2018.789 405.99
497 2018.874 408.12
498 2018.956 409.23

tail(bhd) 
        Date    CO2
499 2018.537 -99.99
500 2018.622 -99.99
501 2018.707 -99.99
502 2018.789 -99.99
503 2018.874 -99.99
504 2018.956 -99.99

# create plot in SVG format
svg(filename ="Baringhead_co2_720-540.svg", width = 8, height = 6, pointsize = 14, onefile = FALSE, family = "sans", bg = "white")    
par(mar=c(3.1,3.1,1,1)+0.1)
plot(mlo[["Date"]],mlo[["CO2"]],ylim=c(325,415),tck=0.01, axes=F,ann=F,las=1,pch=20, cex=0.75,type="o",col="darkgray",lwd=1)
axis(side=1, tck=0.01, at = NULL, labels = NULL, tick = T,lwd=0,lwd.tick=1)
axis(side=2, tck=0.01, at = NULL, labels = NULL, tick = T,lwd=0,lwd.tick=1,las=1)
#axis(side=4, tck=0.01, at = NULL, labels = NULL, tick = T,lwd=0,lwd.tick=1)
grid()
box()
lines(bhd[["Date"]],bhd[["CO2"]],col=2,lwd=2,lty=1)
mtext(side=2,cex=1, line=-1.5,expression(paste("Carbon Dioxide parts per million")))
mtext(side=3,cex=1.5, line=-2,expression(paste("Atmospheric C", O[2], " Baring Head 1977 to 2018")))
mtext(side=1,line=-2.8,cex=1,expression(paste("Data: Scripps C", O[2], " Program")))
mtext(side=1,cex=0.7, line=-1.3,"http://scrippsco2.ucsd.edu/assets/data/atmospheric/stations/in_situ_co2/monthly/monthly_in_situ_co2_mlo.csv\nhttp://scrippsco2.ucsd.edu/assets/data/atmospheric/stations/flask_co2/monthly/monthly_flask_co2_nzd.csv")
legend(1980, 400, bty="n", c("Mauna Loa Hawaii", "Baring Head New Zealand"), lwd=c(1,2), pch=c(20,NA),lty = 1, col = c("darkgray",2))
mtext(side=4,cex=0.75, line=0.05,R.version.string)
dev.off()

# write the data to a .csv file 

write.table(bhd, file = "co2-bhd.csv", sep = ",", col.names = TRUE, qmethod = "double",row.names = FALSE) 

write.table(mlo, file = "co2-mlo.csv", sep = ",", col.names = TRUE, qmethod = "double",row.names = FALSE)

# read in the data as written to the project folder
mlo <- read.csv("/home/user/R/bhd/co2-mlo.csv")
bhd <- read.csv("/home/user/R/bhd/co2-bhd.csv")

     Date    CO2
1 1984.874 342.98

str(mlo)
'data.frame':	498 obs. of  2 variables:
 $ Date: num  1978 1978 1978 1978 1978 ...
 $ CO2 : num  335 333 332 331 332 ...

# create new column 'Site'
mlo[["Site"]]<-c(rep("mlo",498))

str(mlo) 
 'data.frame':	498 obs. of  3 variables:
 $ Date: num  1978 1978 1978 1978 1978 ...
 $ CO2 : num  335 333 332 331 332 ...
 $ Site: chr  "mlo" "mlo" "mlo" "mlo" ...

bhd[["Site"]]<-c(rep("bhd",498))
 
merged_bhd_mlo_data <- rbind(bhd,mlo)

head(merged_bhd_mlo_data) 
       Date    CO2 Site
7  1977.537 332.28  bhd
8  1977.622 332.35  bhd
9  1977.707 332.10  bhd
10 1977.789 332.33  bhd
11 1977.874 333.91  bhd
12 1977.956 333.46  bhd

tail(merged_bhd_mlo_data) 
         Date    CO2 Site
4931 2018.537 408.90  mlo
4941 2018.622 407.10  mlo
4951 2018.707 405.59  mlo
4961 2018.789 405.99  mlo
4971 2018.874 408.12  mlo
4981 2018.956 409.23  mlo

str(merged_bhd_mlo_data) 
'data.frame':	996 obs. of  3 variables:
 $ Date: num  1978 1978 1978 1978 1978 ...
 $ CO2 : num  332 332 332 332 334 ...
 $ Site: chr  "bhd" "bhd" "bhd" "bhd" ...
 
write.table(merged_bhd_mlo_data, file = "tidy_merged_bhd_mlo_data.csv", sep = ",", col.names = TRUE, qmethod = "double",row.names = FALSE) 
