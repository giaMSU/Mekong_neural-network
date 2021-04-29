library (raster)
library (sp)
library (rgdal)
library (filenamer)


setwd ("E:/Mekong/DATA/JMP_Deeplearning_data/Ready_for_ANN/10Year_0.25/testCSVtorasterinR")
files <-list.files(pattern='*.csv', full.names=TRUE)
files
cell_size <- 0.25
lon_min <-93.;lon_max<-110;lat_min <-8; lat_max <- 34
ncols <-((lon_max - lon_min)/cell_size)+1
nrows <-((lat_max - lat_min)/cell_size)+1
ncols <- round(ncols, digits =0)
nrows <- round(nrows, digits =0)

for(f in files){
  file_name <- extension (f,'tif')
  
  f <-  read.csv(f)
  
  str (f)
  
  f_coords <-cbind(f$Lat,f$Lon)
  
  f_pts_obs <- SpatialPointsDataFrame(coords = f_coords, data = data.frame(f$DroughCondition) )
  
  f_pts_pred <- SpatialPointsDataFrame(coords = f_coords, data = data.frame(f$DroughtCondition_Predict) )
  f_pts_pred
  
  #names(f_pts_obs)<- "Drought_obs"
  
  grid<- raster(nrows = nrows, ncols = ncols, xmn=lon_min,xmx=lon_max, ymn = lat_min, ymx = lat_max, res=cell_size, crs="+proj=longlat +datum=WGS84")
  
  Drough_obs <-rasterize (f_pts_obs, grid ,fun = mean)

  Drough_pred <-rasterize (f_pts_pred, grid,fun= mean )

  r_obs <- writeRaster(Drough_obs$f.DroughCondition, filename = insert (file_name, tag= "obs"), datatype='FLT4S', overwrite = TRUE,)
  
  r_pred <- writeRaster(Drough_pred$f.DroughtCondition_Predict, filename = insert (file_name, tag= "pred"), datatype='FLT4S', overwrite = TRUE,)
  
  plot (r_obs)
  plot (r_pred)
  
}
  


