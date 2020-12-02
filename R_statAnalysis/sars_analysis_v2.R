# clear
#cat("\014")
#rm(list = ls())
#dev.off(dev.list()["RStudioGD"])

# Source
source("helpFunctions_v2.R")

# libraries
library(LaplacesDemon)
library(combinat)
library(future.apply)
plan(multiprocess(workers = 2))
library(data.table)
library(stringr)

# Please change the input directory and put an '/' in the end
directory <- '/media/togkousa/Transcend/INEBwork/to_server/data/'

################################################
########## SARS ANALYSIS #######################

# Please select k-values
kmin <- 47
kmax <- 70
kvals = kmin:kmax

dnaBases <- c("A", "C", "G", "T")
encodings <- permn(c(1,2,3,4))
d <- NULL
legend_list <- c()
perm_num <- 0
dir.create('plots')

for (enc in encodings){
  perm_num <- perm_num + 1
  
  # kld_vector_sars <- c()
  legend_list <- c(legend_list, paste(enc, collapse = ''))
  
  kld_vector_sars <- future_lapply(kvals, function(k) {
    
    folder <- paste('plots/sars_',paste(enc, collapse = '') , sep = '')
    dir.create(folder)
    
    # File
    myfile <- paste(directory,"complete_genome_SARS-CoV-2_info_k=", k, ".txt", sep = "")
    mydata <- as.data.frame(read.table(myfile, header = TRUE, sep = '', dec = '.'))
    mydata <- deleteUselessKmers(mydata, dnaBases)
    primes <- get_prime(k)
    mydata <- newGodelNums(mydata, primes, enc)
    
    # Distribution
    print(paste(k, perm_num, sep = ','))
    plotDistributionHistogram(mydata, folder, k)
    
    # Distance from normal distribution
    distance <- normDist_lapply(mydata)
    distance
  })
  
  
  d = cbind(d, kld_vector_sars)
  
}

rownames(d) <- kvals
colnames(d) <- legend_list
output_filename <- paste('plots/', 'norm_dist_divergence_',kmin,'_',kmax,'.csv', sep = '')
write.csv(d, output_filename)


png(file='plots/DivergenceFromNormDist.png', width=1500, height=1200)
cur_col <- 1
plot(kvals, d[,1], type = 'l', col = cur_col, xlab = 'K Values', ylab = 'Distance', 
     main = 'Divergence from Normal Distribution',ylim = c(0, 0.01),
     cex.main = 2, cex.axis = 2, cex.lab = 2)

for (i in 2:length(encodings)){
  cur_col <- cur_col + 1
  lines(kvals, d[,i], type = 'l', col = cur_col)
}
legend('topright',legend=legend_list,
       col=c(1:cur_col), lty = 1, cex=1.0)
dev.off()

#dev.off(dev.list())