# clear
cat("\014")
rm(list = ls())
dev.off(dev.list()["RStudioGD"])

# libraries
library(combinat)

# Select the .csv file you want to plot
path <- 'plots/JSD/jsd_norm_dist_divergence_4_20.csv'

# Select the output file name
output_filepath <- 'plots/JSD_norm_dist_divergence.png'

# Importing files
d <- read.csv(path, check.names = FALSE, row.names = 1)
encodings <- permn(c(1,2,3,4))
legend_list <- colnames(d)
legend_list <- legend_list[-c(1)]
kvals <- rownames(d)

# Specify the limits of y-axis
ylimit <- c(0, 1)

# Title
title <- 'Divergence of two Distributions'

# plotting
png(file=output_filepath, width=1500, height=1200)
cur_col <- 1
plot(kvals, d[,1], type = 'l', col = cur_col, xlab = 'K Values', ylab = 'Divergence', 
     main = title ,ylim = ylimit,
     cex.main = 2, cex.axis = 2, cex.lab = 2)

for (i in 2:length(encodings)){
  cur_col <- cur_col + 1
  lines(kvals, d[,i], type = 'l', col = cur_col)
}
legend('topright',legend=legend_list,
       col=c(1:cur_col), lty = 1, cex=1.0)
dev.off()