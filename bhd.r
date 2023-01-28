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
'data.frame':	552 obs. of  10 variables:
 $ V1 : int  1977 1977 1977 1977 1977 1977 1977 1977 1977 1977 ...
 $ V2 : int  1 2 3 4 5 6 7 8 9 10 ...
 $ V3 : int  28140 28171 28199 28230 28260 28291 28321 28352 28383 28413 ...
 $ V4 : num  1977 1977 1977 1977 1977 ...
 $ V5 : num  NaN NaN NaN NaN NaN ...
 $ V6 : num  NaN NaN NaN NaN NaN ...
 $ V7 : num  331 331 331 331 332 ...
 $ V8 : num  331 331 332 332 332 ...
 $ V9 : num  331 331 331 331 332 ...
 $ V10: num  331 331 332 332 332 .
 
head(bhd,7) 
    V1 V2    V3       V4     V5     V6     V7     V8     V9    V10
1 1977  1 28140 1977.041     NA     NA     NA     NA     NA     NA
2 1977  2 28171 1977.126     NA     NA     NA     NA     NA     NA
3 1977  3 28199 1977.203     NA     NA     NA     NA     NA     NA
4 1977  4 28230 1977.288     NA     NA     NA     NA     NA     NA
5 1977  5 28260 1977.370     NA     NA     NA     NA     NA     NA
6 1977  6 28291 1977.455     NA     NA     NA     NA     NA     NA
7 1977  7 28321 1977.537 332.75 332.28 332.62 332.14 332.75 332.28
 
head(bhd[7:528,]) 
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
tail(bhd,5) 
      V1 V2    V3       V4  V5  V6     V7     V8     V9    V10
548 2022  8 44788 2022.622 NaN NaN 414.82 414.07 414.82 414.07
549 2022  9 44819 2022.707 NaN NaN 414.95 414.24 414.95 414.24
550 2022 10 44849 2022.789 NaN NaN 414.87 414.41 414.87 414.41
551 2022 11 44880 2022.874 NaN NaN 414.34 414.58 414.34 414.58
552 2022 12 44910 2022.956 NaN NaN 414.67 414.75 414.67 414.75

# subset just the date V4 and co2 measurements V10 (10th column that includes infilled data so no NAs) from row 7 7  1977.537 to present
bhd <-bhd[7:552,c(-1,-2,-3,-5,-6,-7,-8,-9)]

# Add names
names(bhd)<-c("Date","CO2")

str(bhd)
'data.frame':	546 obs. of  2 variables:
 $ Date: num  1978 1978 1978 1978 1978 ...
 $ CO2 : num  332 332 332 332 334 ... 
head(bhd,1)
    Date    CO2
7 1977.537 332.33
tail(bhd,1)
        Date    CO2
552 2022.956 414.75

# read in the Mauna Loa data skipping the first 291 rows so first row is 1977 07
mlo <- read.csv("co2_mlo.csv",skip=291,header=FALSE,stringsAsFactors =FALSE, sep = ",",dec=".",na.strings =-99.99)

# examine the dataframe
str(mlo)
'data.frame':	558 obs. of  10 variables:
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
head(mlo,2)
    V1 V2    V3       V4     V5     V6     V7     V8     V9    V10
1 1977  7 28321 1977.537 334.93 334.22 334.68 334.00 334.93 334.22
2 1977  8 28352 1977.622 332.76 334.13 332.77 334.17 332.76 334.13 

tail(mlo,13)
      V1 V2    V3       V4     V5     V6     V7     V8     V9    V10
546 2022 12 44910 2022.956 418.56 419.48 418.41 419.32 418.56 419.48
547 2023  1 44941 2023.041 -99.99 -99.99 -99.99 -99.99 -99.99 -99.99
548 2023  2 44972 2023.126 -99.99 -99.99 -99.99 -99.99 -99.99 -99.99
549 2023  3 45000 2023.203 -99.99 -99.99 -99.99 -99.99 -99.99 -99.99
550 2023  4 45031 2023.288 -99.99 -99.99 -99.99 -99.99 -99.99 -99.99
551 2023  5 45061 2023.370 -99.99 -99.99 -99.99 -99.99 -99.99 -99.99
552 2023  6 45092 2023.455 -99.99 -99.99 -99.99 -99.99 -99.99 -99.99
553 2023  7 45122 2023.537 -99.99 -99.99 -99.99 -99.99 -99.99 -99.99
554 2023  8 45153 2023.622 -99.99 -99.99 -99.99 -99.99 -99.99 -99.99
555 2023  9 45184 2023.707 -99.99 -99.99 -99.99 -99.99 -99.99 -99.99
556 2023 10 45214 2023.789 -99.99 -99.99 -99.99 -99.99 -99.99 -99.99
557 2023 11 45245 2023.874 -99.99 -99.99 -99.99 -99.99 -99.99 -99.99
558 2023 12 45275 2023.956 -99.99 -99.99 -99.99 -99.99 -99.99 -99.99 

# subset out just the date and co2 up to 2022 December date of last value
mlo <-mlo[1:546,c(-1,-2,-3,-6,-7,-8,-9,-10)]
names(mlo)<-c("Date","CO2")
str(mlo)
'data.frame':	546 obs. of  2 variables:
 $ Date: num  1978 1978 1978 1978 1978 ...
 $ CO2 : num  335 333 332 331 332 ...
 
head(mlo,2) 
      Date    CO2
1 1977.537 334.93
2 1977.622 332.76

tail(mlo,2)
        Date    CO2
545 2022.874 417.04
546 2022.956 418.56
# what scale should the y axis be?
max(mlo[["CO2"]])
[1] 420.77
# create plot in SVG format
svg(filename ="Baringhead_co2_720-540.svg", width = 8, height = 6, pointsize = 14, onefile = FALSE, family = "sans", bg = "white")    
par(mar=c(3.1,3.1,1,1)+0.1)
plot(mlo[["Date"]],mlo[["CO2"]],ylim=c(325,421),tck=0.01, axes=F,ann=F,las=1,pch=20, cex=0.75,type="o",col="darkgray",lwd=1)
axis(side=1, tck=0.01, at = NULL, labels = NULL, tick = T,lwd=0,lwd.tick=1)
axis(side=2, tck=0.01, at = NULL, labels = NULL, tick = T,lwd=0,lwd.tick=1,las=1)
#axis(side=4, tck=0.01, at = NULL, labels = NULL, tick = T,lwd=0,lwd.tick=1)
grid()
box()
lines(bhd[["Date"]],bhd[["CO2"]],col=2,lwd=2,lty=1)
mtext(side=2,cex=1, line=-1.5,expression(paste("Carbon Dioxide parts per million")))
mtext(side=3,cex=1.5, line=-2,expression(paste("Atmospheric C", O[2], " Baring Head 1977 to 2022")))
mtext(side=1,line=-2.8,cex=1,expression(paste("Data: Scripps C", O[2], " Program")))
mtext(side=1,cex=0.7, line=-1.3,"http://scrippsco2.ucsd.edu/assets/data/atmospheric/stations/in_situ_co2/monthly/monthly_in_situ_co2_mlo.csv\nhttp://scrippsco2.ucsd.edu/assets/data/atmospheric/stations/flask_co2/monthly/monthly_flask_co2_nzd.csv")
legend(1980, 415, bty="n", c("Mauna Loa Hawaii", "Baring Head New Zealand"), lwd=c(1,2), pch=c(20,NA),lty = 1, col = c("darkgray",2))
mtext(side=4,cex=0.75, line=0.05,R.version.string)
dev.off()

# write the data to a .csv file 

write.table(bhd, file = "co2-bhd.csv", sep = ",", col.names = TRUE, qmethod = "double",row.names = FALSE) 
write.table(mlo, file = "co2-mlo.csv", sep = ",", col.names = TRUE, qmethod = "double",row.names = FALSE)

# read in the data as written to the project folder
#mlo <- read.csv("/home/user/R/bhd/co2-mlo.csv")
#bhd <- read.csv("/home/user/R/bhd/co2-bhd.csv")

     Date    CO2
1 1984.874 342.98

str(mlo)
'data.frame':	546 obs. of  2 variables:
 $ Date: num  1978 1978 1978 1978 1978 ...
 $ CO2 : num  335 333 332 331 332 ... 

# create new column 'Site'
mlo[["Site"]]<-c(rep("mlo",546))

str(mlo) 
 'data.frame':	546 obs. of  3 variables:
 $ Date: num  1978 1978 1978 1978 1978 ...
 $ CO2 : num  335 333 332 331 332 ...
 $ Site: chr  "mlo" "mlo" "mlo" "mlo" ...

bhd[["Site"]]<-c(rep("bhd",546))
 
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
5411 2022.537 418.68  mlo
5421 2022.622 416.76  mlo
5431 2022.707 415.41  mlo
5441 2022.789 415.31  mlo
5451 2022.874 417.04  mlo
5461 2022.956 418.56  mlo

str(merged_bhd_mlo_data) 
'data.frame':	1092 obs. of  3 variables:
 $ Date: num  1978 1978 1978 1978 1978 ...
 $ CO2 : num  332 332 332 332 334 ...
 $ Site: chr  "bhd" "bhd" "bhd" "bhd" ...
# write merged dataframe to a csv file  
write.table(merged_bhd_mlo_data, file = "tidy_merged_bhd_mlo_data.csv", sep = ",", col.names = TRUE, qmethod = "double",row.names = FALSE) 
