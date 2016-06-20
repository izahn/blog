#http://www.r-bloggers.com/mapping-with-ggplot-create-a-nice-choropleth-map-in-r/
library(ggplot2)
library(maptools)
library(rgeos)
library(Cairo)
library(ggmap)
library(scales)
library(RColorBrewer)
require(plyr)
library(broom)

################### CANADA ###################
options(stringsAsFactors = FALSE)

##set directory to the folder where the shapefile is, then 
canada.shp <- readShapeSpatial("fed_cf_CA_2_2_shp_en/FED_CA_2_2_ENG.shp")
class(canada.shp)
canada.shp.f <-tidy(canada.shp,region="FEDNUM")
head(canada.shp.f)
to.merge <- read.csv("to_merge.csv")
canada.shp.f$FEDNUM <- as.integer(as.character(canada.shp.f$id))
canada.shp.f <- merge(canada.shp.f,
                      unique(as.data.frame(canada.shp)[, c("FEDNUM", "PROVCODE")]),
                      by = "FEDNUM",
                      all.x = TRUE, all.y = FALSE)
merge.shp.coef <- merge(canada.shp.f, to.merge, by.x = "PROVCODE", by.y = "id", all.x=TRUE)

final.plot<-merge.shp.coef[order(merge.shp.coef$order), ] 
p <- ggplot() +
  geom_polygon(data = final.plot, 
  aes(x = long, y = lat,group=group,fill=uniform.fraud.rate), 
  color = "black", size = 1)# +
  #coord_map()
ggsave("Maps/can.png",p)
