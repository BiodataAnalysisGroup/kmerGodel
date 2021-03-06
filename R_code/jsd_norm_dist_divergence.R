# clear
cat("\014")
rm(list = ls())
dev.off(dev.list()["RStudioGD"])

# Source
source("normDist_helping_functions.R")

# libraries
library(LaplacesDemon)
library(combinat)
library(philentropy)
library(future.apply)
plan(multiprocess(workers = 4))
#library(data.table)
library(stringr)

# Please change the input directory and put an '/' in the end
directory <- 'input/'

################################################
########## SARS ANALYSIS #######################

# Please select k-values
kmin <- 4
kmax <- 20
kvals = kmin:kmax

dnaBases <- c("A", "C", "G", "T")
encodings <- permn(c(1,2,3,4))
d <- NULL
legend_list <- c()
perm_num <- 0
dir.create('plots')

# Creating output folder
dir.create('plots')
dir.create('plots/JSD')
output_folder <- 'plots/JSD/'


for (enc in encodings){
  perm_num <- perm_num + 1
  
  # kld_vector_sars <- c()
  legend_list <- c(legend_list, paste(enc, collapse = ''))
  
  jsd_vector_sars <- future_lapply(kvals, function(k) {
    
    folder <- paste('plots/sars_',paste(enc, collapse = '') , sep = '')
    dir.create(folder)
    
    # File
    myfile <- paste(directory,"sars_1000_info_k=", k, ".txt", sep = "")
    mydata <- as.data.frame(read.table(myfile, header = TRUE, sep = '', dec = '.'))
    mydata <- deleteUselessKmers(mydata, dnaBases)
    primes <- get_prime(k)
    mydata <- newGodelNums(mydata, primes, enc)
    
    # Distribution
    print(paste(k, perm_num, sep = ','))
    plotDistributionHistogram(mydata, folder, k)
    
    # Distance from normal distribution
    distance <- JSD_normDist_divergence(mydata)
    distance
  })
  
  
  d = cbind(d, jsd_vector_sars)
  
}

rownames(d) <- kvals
colnames(d) <- legend_list
output_filename <- paste(output_folder, 'jsd_norm_dist_divergence_',kmin,'_',kmax,'.csv', sep = '')
write.csv(d, output_filename)