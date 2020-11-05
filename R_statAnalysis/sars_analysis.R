# clear
cat("\014")
rm(list = ls())
dev.off(dev.list()["RStudioGD"])

# Source
source("helpFunctions.R")

# libraries
library(LaplacesDemon)
library(combinat)

# creating /plots dir
dir.create('plots')

################################################
########## SARS ANALYSIS #######################
kvals = c(4:100)
dnaBases <- c("A", "C", "G", "T")
encodings <- permn(c(1,2,3,4))
d <- NULL
legend_list <- c()
perm_num <- 0

for (enc in encodings){
  perm_num <- perm_num + 1
  
  kld_vector_sars <- c()
  legend_list <- c(legend_list, paste(enc, collapse = ''))
    for (k in kvals){
    # Create dir
    folder <- paste('plots/sars_',paste(enc, collapse = '') , sep = '')
    dir.create(folder)

    
    # File
    myfile <- paste("input/sars_1000_info_k=", k, ".txt", sep = "")
    mydata <- as.data.frame(read.table(myfile, header = TRUE, sep = '', dec = '.'))
    mydata <- deleteUselessKmers(mydata, dnaBases)
    primes <- get_prime(k)
    mydata <- newGodelNums(mydata, primes, enc)
    
    # Distribution
    print(paste(k, perm_num, sep = ','))
    plotDistributionHistogram(mydata, folder)
    
    # Distance from normal distribution
    kld_vector_sars <- normDist(mydata, kld_vector_sars)
    
    # Spectrum Histogram
    counts_info <- plotSpectrumHistogram(mydata, folder)
    
    # Distributions for Specific Counts
    distributionsOfSpecificCounts(mydata, k, 'sars', enc)
  }
  
  d = cbind(d, kld_vector_sars)

}

rownames(d) <- kvals
colnames(d) <- legend_list
write.csv("plots/norm_dist_divergence.csv", as.data.frame(d))


png(file='plots/DivergenceFromNormDist.png', width=1500, height=1200)
cur_col <- 1
plot(kvals, d[,1], type = 'l', col = cur_col, xlab = 'K Values', ylab = 'Distance', 
     main = 'Divergence from Normal Distribution',ylim = c(0, 0.1),
     cex.main = 2, cex.axis = 2, cex.lab = 2)

for (i in 2:length(encodings)){
  cur_col <- cur_col + 1
  lines(kvals, d[,i], type = 'l', col = cur_col)
}
legend('topright',legend=legend_list,
       col=c(1:cur_col), lty = 1, cex=1.0)
dev.off()

#dev.off(dev.list())