# clear
cat("\014")
rm(list = ls())
dev.off(dev.list()["RStudioGD"])

# Source
source("two_dists_helping_functions.R")
source("normDist_helping_functions.R")

# libraries
library(LaplacesDemon)
library(combinat)
library(future.apply)
plan(multiprocess(workers = 3))
#library(data.table)
library(stringr)
library(statip)
library(philentropy)

# Please change the input directory and put an '/' in the end
directory <- 'input/'

################################################
########## SARS ANALYSIS #######################

# Please select k-values
kmin <- 10
kmax <- 20
kvals = kmin:kmax

# Number of strains - Need to change this
num_of_sequences <- 1000

dnaBases <- c("A", "C", "G", "T")
encodings <- permn(c(1,2,3,4))
d <- NULL
legend_list <- c()
perm_num <- 0

# Creating output folder
dir.create('plots')
dir.create('plots/JSD')
output_folder <- 'plots/JSD/'

for (enc in encodings){
  
  perm_num <- perm_num + 1
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
    
    # Spectrum Histogram
    counts_info <- plotSpectrumHistogram(mydata, folder, k)
    
    # Bring godels - cutoff
    cut_off <- floor(num_of_sequences/2)
    godels_out <- bringGodelsFromBothSidesOfCutoff(mydata, cut_off)
    godels_1 <- godels_out[[1]]
    godels_2 <- godels_out[[2]]
    tmp <- JSD_divergenceOfDistributions(godels_1, godels_2, k, folder)
    tmp
    
  })
  d = cbind(d, jsd_vector_sars)
}

rownames(d) <- kvals
colnames(d) <- legend_list

output_filename <- paste(output_folder, 'jsd_two_distributions_divergence_',kmin,'_',kmax,'.csv', sep = '')
write.csv(d, output_filename)
