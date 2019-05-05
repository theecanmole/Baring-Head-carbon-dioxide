---
title: "Baring Head and Maunu Loa Carbon Dioxide"
author: "Simon Johnson"
date: "29/04/2019"
output: html_document
---


## Atmospheric Carbon Dioxide Baring Head and Maunu Loa

This is an R Markdown document of r script to create a chart of atmospheric carbon Dioxide at Baring Head, New Zealand and at Maunu Loa, Hawaii, USA.
```
library(here)
here()
```

Obtain the CO2 data from Scripps

```
urlnz <- c("http://scrippsco2.ucsd.edu/assets/data/atmospheric/stations/flask_co2/monthly/monthly_flask_co2_nzd.csv")
download.file(urlnz, "co2_nzd.csv")
rm(urlnz)
```

```
urlmlo <- c("http://scrippsco2.ucsd.edu/assets/data/atmospheric/stations/in_situ_co2/monthly/monthly_in_situ_co2_mlo.csv")
download.file(urlmlo, "co2_mlo.csv")
rm(urlmlo)
```

Read in the Baring Head data skipping the first 57 rows

```
bhd <- read.csv("co2_nzd.csv",skip=57,header=FALSE, sep = ",",dec=".",stringsAsFactors =FALSE, strip.white =TRUE ,na.strings =-99.99)
```

examine the dataframe

```
str(bhd)
```

Read in the Mauna Loa data skipping the first 291 rows so first row is 1977 07

```
mlo <- read.csv("co2_mlo.csv",skip=291,header=FALSE, sep = ",",dec=".",na.strings =-99.99)
```

Subset just the date and co2 measurements (10th column that includes infilled data so there are no NAs)
```
bhd <-bhd[7:504,c(-1,-2,-3,-5,-6,-7,-8,-9)]
```
Subset out just the date and co2 
```
mlo <-mlo[1:498,c(-1,-2,-3,-6,-7,-8,-9,-10)]
```

Add names
```
names(bhd)<-c("Date","CO2")
names(mlo)<-c("Date","CO2")
```

## Create a chart

Create a chart

```
svg(filename ="Baringhead_co2_720-540.svg", width = 8, height = 6, pointsize = 14, onefile = FALSE, family = "sans", bg = "white")
plot(plot(mlo[["Date"]],mlo[["CO2"]],ylim=c(325,415),tck=0.01, axes=F,ann=F,las=1,pch=20, cex=0.75,type="o",col="darkgray",lwd=1)
axis(side=1, tck=0.01, at = NULL, labels = NULL, tick = T, lwd=0, lwd.tick=1)
axis(side=2, tck=0.01, at = NULL, labels = NULL, tick = T,  lwd=0, lwd.tick=1, las=1)
grid()
box()
lines(bhd[["Date"]],bhd[["CO2"]],col=2,lwd=2,lty=1)
mtext(side=2,cex=1, line=-1.5,expression(paste("Carbon Dioxide parts per million")))
mtext(side=3,cex=1.5, line=-2,expression(paste("Atmospheric C", O[2], " Baring Head 1977 to 2018")))
mtext(side=1,line=-2.8,cex=1,expression(paste("Data: Scripps C", O[2], " Program")))
mtext(side=1,cex=0.7, line=-1.3,"http://scrippsco2.ucsd.edu/assets/data/atmospheric/stations/in_situ_co2/monthly/monthly_in_situ_co2_mlo.csv\nhttp://scrippsco2.ucsd.edu/assets/data/atmospheric/stations/flask_co2/monthly/monthly_flask_co2_nzd.csv")
legend(1980, 400, bty="n", c("Mauna Loa Hawaii", "Baring Head New Zealand"), lwd=c(1,2), pch=c(20,NA),lty = 1, col = c("darkgray",2)))
mtext(side=4,cex=0.75, line=0.05,R.version.string)
dev.off()
```


