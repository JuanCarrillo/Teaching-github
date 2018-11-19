getwd()
setwd("/Users/juancarrillo/Dropbox (PaleoColombia)/Documents work/Research Projects/Diversity and disparity Caviomorphs/Extant occurrences/Cervidae")
dir()

# Load occurrences of Cervidae worldwide
cerv<-read.delim("cervidae.txt", header=TRUE)
str(cerv)
head(cerv)

# Select the occurrences of in continental Americas
levels(cerv$countryCode)
cevam<-droplevels(subset(cerv, cerv$countryCode=="CA" | cerv$countryCode=="US"| cerv$countryCode=="MX"
      | cerv$countryCode=="GT" | cerv$countryCode=="BZ"| cerv$countryCode=="SV"| cerv$countryCode=="HN"
      | cerv$countryCode=="NI"| cerv$countryCode=="CR" | cerv$countryCode=="PA"| cerv$countryCode=="CO"
      | cerv$countryCode=="VE" | cerv$countryCode=="GUY"| cerv$countryCode=="SR"| cerv$countryCode=="GF"
      | cerv$countryCode=="BR"| cerv$countryCode=="EC"| cerv$countryCode=="PE"| cerv$countryCode=="BO"
      | cerv$countryCode=="PY"| cerv$countryCode=="CL"| cerv$countryCode=="AR"| cerv$countryCode=="UY"))

cevam<-read.delim("cervidae_americas.txt")
str(cevam)
head(cevam)
plot(cevam$decimalLongitude, cevam$decimalLatitude)                  
write.table(cevam,file="cervidae_americas.txt", quote=F, sep="\t", row.names=F)

dir()
cevam<-read.delim("cervidae_americas.txt")
str(cevam)
head(cevam)
# Clean occurences
install.packages("devtools")
library(devtools)
devtools::install_github("ropensci/CoordinateCleaner")
install.packages("CoordinateCleaner")
library(CoordinateCleaner)
library(ggplot2)
?borders
install.packages("maps")
map1<-borders("world",colour="gray50",fill="gray50")
ggplot()+coord_fixed()+map1+geom_point(data=cevam,aes(x=decimalLongitude, y=decimalLatitude),
                                       colour="darkred",size=0.5)+theme_bw()
?CleanCoordinates
levels(cevam$species)
flags<-clean_coordinates(cevam, lon = "decimalLongitude", lat = "decimalLatitude", species = "species",
                  countries = "countryCode")
str(flags)
head(flags)
cevam$flagged<-flags$.summary
str(cevam)
head(cevam)

# The flagged records are flagged == FALSE
subset(cevam, cevam$flagged=="FALSE")

cleanocc<-droplevels(subset(cevam, cevam$flagged=="TRUE"))
str(cleanocc)

# Load the shapefiles of the wwf ecoregions
library(rgdal)
?readOGR
map_wwf<-readOGR(dsn=".",layer="g200_terr")
is(map_wwf)
plot(map_wwf)
class(map_wwf)
str(map_wwf@data)
head(map_wwf@data)
