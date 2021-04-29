dt = read.csv('Mau4ID.csv')
dim(dt)
head(dt)
length(unique(dt$ID))

# number of columns
CL <- dim(dt)[2]
# column names
col_name <- colnames(dt)
# number of IDs
N <- length(unique(dt$ID))
# number of rows for each ID
R <- length(which(dt$ID==59))

# form each file 
for(i in (1:R)){
  # each row
  res <- as.vector(dt[i,])
  for(j in (2:N)){
    res <- rbind(res, dt[(j-1)*R+i,])
  }
  colnames(res) <- col_name
  file_name <- paste0('IloveyouXuan_Mau4ID_', sprintf('%d',i), '.csv')
  write.csv(res, file_name)
}