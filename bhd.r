## Baring Head and Maunu Loa Hawaii carbon dioxide data

# check my user directory

getwd()
[1] "/home/user/R/bhd/baringhead"

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
'data.frame':	564 obs. of  10 variables:
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
  Date CO2    NA       NA     NA     NA     NA     NA     NA     NA
1 1977   1 28140 1977.041    NaN    NaN 330.83 331.19 330.83 331.19
2 1977   2 28171 1977.126    NaN    NaN 330.95 331.37 330.95 331.37
3 1977   3 28199 1977.203    NaN    NaN 331.27 331.53 331.27 331.53
4 1977   4 28230 1977.288    NaN    NaN 331.49 331.71 331.49 331.71
5 1977   5 28260 1977.370    NaN    NaN 331.80 331.89 331.80 331.89
6 1977   6 28291 1977.455    NaN    NaN 332.28 332.07 332.28 332.07
7 1977   7 28321 1977.537 332.74 332.33 332.66 332.25 332.74 332.33 

# create dataframe of date and CO2 data
bhd1 <- data.frame(Date = as.Date(bhd[,3], origin = "1900-01-01"), CO2=bhd[,10]) 

str(bhd1)
'data.frame':	564 obs. of  2 variables:
 $ Date: Date, format: "1977-01-17" "1977-02-17" ...
 $ CO2 : num  331 331 332 332 332 ... 
 
# read in the Mauna Loa data skipping the first 294 rows so first row is 1977 07
mlo <- read.csv("co2_mlo.csv",skip=294,header=FALSE,stringsAsFactors =FALSE, sep = ",",dec=".",na.strings =-99.99)

# examine the dataframe
str(mlo)
'data.frame':	574 obs. of  11 variables:
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
 $ V11: chr  " MLO" " MLO" " MLO" " MLO"
head(mlo,2)
    V1 V2    V3       V4     V5     V6     V7     V8     V9    V10  V11
1 1977  7 28321 1977.537 334.93 334.22 334.67 333.99 334.93 334.22  MLO
2 1977  8 28352 1977.622 332.76 334.13 332.76 334.16 332.76 334.13  MLO

tail(mlo,4)
      V1 V2    V3       V4     V5     V6     V7     V8     V9    V10  V11
571 2024  9 45550 2024.708 421.59 425.11 421.53 425.07 421.59 425.11  MLO
572 2024 10 45580 2024.790 422.05 425.66 421.77 425.37 422.05 425.66  MLO
573 2024 11 45611 2024.874 -99.99 -99.99 -99.99 -99.99 -99.99 -99.99  MLO
574 2024 12 45641 2024.956 -99.99 -99.99 -99.99 -99.99 -99.99 -99.99  MLO 

# delete last two rows of NAs 
mlo <- mlo[-c(573,574),]

# create dataframe of data and CO2 data 
mlo1 <- data.frame(Date = as.Date(mlo[,3], origin = "1900-01-01"), CO2=mlo[,9]) 

str(mlo1)
'data.frame':	572 obs. of  2 variables:
 $ Date: Date, format: "1977-03-17" "1977-04-17" ...
 $ CO2 : num  333 334 334 334 334 ... 
 
# what maximum scale should the y axis be?
max(mlo[["CO2"]])
[1] 426.7
#[1] 423.78

# create plot in SVG format
svg(filename ="Baringhead_co2_720-540.svg", width = 8, height = 6, pointsize = 14, onefile = FALSE, family = "sans", bg = "white")    
par(mar=c(3.1,3.1,1,1)+0.1)
plot(mlo1,ylim=c(325,430),tck=0.01, axes=T,ann=F,las=1,pch=20, cex=0.75,type="o",col="darkgray",lwd=1)
axis(side=4, tck=0.01,  labels = FALSE, tick = T,lwd=0,lwd.tick=1)
grid()
lines(bhd1, col="#ED1A3B",lwd=2,lty=1)
mtext(side=2,cex=1, line=-1.5,expression(paste("Carbon Dioxide parts per million")))
mtext(side=3,cex=1.5, line=-2,expression(paste("Atmospheric C", O[2], " Baring Head 1977 to 2024")))
mtext(side=1,line=-2.8,cex=1,expression(paste("Data: Scripps C", O[2], " Program")))
mtext(side=1,cex=0.7, line=-1.3,"http://scrippsco2.ucsd.edu/assets/data/atmospheric/stations/in_situ_co2/monthly/monthly_in_situ_co2_mlo.csv\nhttp://scrippsco2.ucsd.edu/assets/data/atmospheric/stations/flask_co2/monthly/monthly_flask_co2_nzd.csv")
legend(2952, 420, bty="n", c("Mauna Loa Hawaii", "Baring Head New Zealand"), lwd=c(1,2), pch=c(20,NA),lty = 1, col = c("darkgray","#ED1A3B"))
mtext(side=4,cex=0.75, line=0.05,R.version.string)
dev.off()
 
# where to put legend on x axis
as.numeric(as.Date("1980-01-31")) 
[1] 3682
as.numeric(as.Date("1978-01-31")) 
[1] 2952 

# write the data to a .csv file 

write.table(bhd1, file = "co2-bhd.csv", sep = ",", col.names = TRUE, qmethod = "double",row.names = FALSE) 
write.table(mlo1, file = "co2-mlo.csv", sep = ",", col.names = TRUE, qmethod = "double",row.names = FALSE)


sessionInfo()
R version 4.3.2 (2023-10-31)
Platform: x86_64-pc-linux-gnu (64-bit)
Running under: Debian GNU/Linux 11 (bullseye)

Matrix products: default
BLAS:   /usr/lib/x86_64-linux-gnu/blas/libblas.so.3.9.0 
LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.9.0

locale:
 [1] LC_CTYPE=en_NZ.UTF-8          LC_NUMERIC=C                 
 [3] LC_TIME=en_NZ.UTF-8           LC_COLLATE=en_NZ.UTF-8       
 [5] LC_MONETARY=en_NZ.UTF-8       LC_MESSAGES=en_NZ.UTF-8      
 [7] LC_PAPER=en_NZ.UTF-8          LC_NAME=en_NZ.UTF-8          
 [9] LC_ADDRESS=en_NZ.UTF-8        LC_TELEPHONE=en_NZ.UTF-8     
[11] LC_MEASUREMENT=en_NZ.UTF-8    LC_IDENTIFICATION=en_NZ.UTF-8

time zone: Pacific/Auckland
tzcode source: system (glibc)

attached base packages:
[1] stats     graphics  grDevices utils     datasets  methods   base     

other attached packages:
[1] rkward_0.7.2

loaded via a namespace (and not attached):
[1] compiler_4.3.2 tools_4.3.2   
