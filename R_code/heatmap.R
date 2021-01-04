# clear
cat("\014")
rm(list = ls())
dev.off(dev.list()["RStudioGD"])

# Selecting the input file
inputfile <- 'plots/KLD/kld_norm_dist_divergence4_20.csv'

# input
data <- t(read.csv(inputfile, row.names = 1, header = TRUE, check.names=FALSE))
# data <- as.matrix(data)

# Heatmap construction - Plot 1
h_info <- heatmap(as.matrix(data), Colv = NA, scale = 'none', )

"
plot(data[h_info$rowInd[1],], type = 'l', col = 1, ylim = c(0,0.01))
for (i in 2:4){
  lines(data[h_info$rowInd[i],], type = 'l', col = i)
}


plot(data[h_info$rowInd[24],], type = 'l', col = 'blue')
lines(data[h_info$rowInd[23],], type = 'l', col = 'red')
"