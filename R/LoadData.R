link2001 <- 'ftp://ftp.glcf.umd.edu/glcf/Global_LNDCVR/Global_5min_Rev1/GeoTIFF/LC_5min_global_2001.tif.gz'
link2010 <- 'ftp://ftp.glcf.umd.edu/glcf/Global_LNDCVR/Global_5min_Rev1/GeoTIFF/LC_5min_global_2010.tif.gz'

Load_LU <- function(link, year){
  download.file(url = link, destfile = paste('data/LC_5min_global_',year,'.tif.gz', sep = ""), method = 'auto')
  gunzip(paste('data/LC_5min_global_',year,'.tif.gz', sep = ""))
}

