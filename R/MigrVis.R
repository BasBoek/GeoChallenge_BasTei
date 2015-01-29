# Set options chart for plot
op <- options(gvis.plot.tag='chart')

# Load the ISO CODES for location of the subnational regions of Malaysia
data("ISO_3166_2")

# Prepare ISO code for input Vismap 
Migr_sub_final_plot <- subset(Migr_sub_final, select = c(NAME_1, netmigration_2000_2010_1km_crop))
Migr_sub_final_plot <- as.data.frame(Migr_sub_final_plot)
ISO_3166_2_MY <- subset(ISO_3166_2, Country %in% "MY")
ISO_3166_2_MY <- ISO_3166_2_MY[ISO_3166_2_MY$Type != 'Federal Territories',]
vector<- c(ISO_3166_2_MY[1:13,1])
Migr_sub_final_plot$Code <- vector
Migr_sub_final_plot$Code
Migr_sub_final_plot <- as.data.frame(Migr_sub_final_plot)
names(Migr_sub_final_plot) <- c('Name', 'Average Migration', 'Code')

# Make the gvisGeoChart
HTML <- gvisGeoChart(Migr_sub_final_plot, locationvar = "Code", colorvar = "Average Migration", options=list(region="MY", resolution="provinces", dataMode='regions'))

# write to file
print(HTML, file="data/MigrationWebmap.html")
