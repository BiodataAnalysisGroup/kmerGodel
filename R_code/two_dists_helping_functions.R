# libraries
library(LaplacesDemon)

deleteUselessKmers <- function(mydata, dnaBases){
  # Data pre processing - Deleting kmers consisting of letters that don't belong in {A,T,G,C} set
  to_be_deleted <- c()
  
  chars = str_split(mydata$K.mer, "", simplify = TRUE)
  
  for (i in 1:ncol(chars)){
    to_be_deleted = c(to_be_deleted, which(!(chars[,i] %in% dnaBases)))
  }
  
  to_be_deleted = unique(to_be_deleted)
  
  mydata <- mydata[-to_be_deleted, ]
  
  return(mydata)
}

KLD_divergenceOfDistributions <- function(godels_1, godels_2, k, folder){
  
  # Plotting the two distributions
  x <- seq(min(godels_1, godels_2), max(godels_1, godels_2), 0.1)
  df_1 <- approxfun(density(godels_1))
  df_2 <- approxfun(density(godels_2))
  y_pdf_1 <- df_1(x)
  y_pdf_2 <- df_2(x)
  y_pdf_1[which(is.na(y_pdf_1)== TRUE)] <- 0
  y_pdf_2[which(is.na(y_pdf_2) == TRUE)] <- 0
  plot_two_distributions(x, y_pdf_1, y_pdf_2, folder, k)
  
  distance <- KLD(y_pdf_1, y_pdf_2)
  return(distance$mean.sum.KLD)
}

JSD_divergenceOfDistributions <- function(godels_1, godels_2, k, folder){
  
  # Plotting the two distributions
  x <- seq(min(godels_1, godels_2), max(godels_1, godels_2), 0.1)
  df_1 <- approxfun(density(godels_1))
  df_2 <- approxfun(density(godels_2))
  y_pdf_1 <- df_1(x)
  y_pdf_2 <- df_2(x)
  y_pdf_1[which(is.na(y_pdf_1)== TRUE)] <- 0
  y_pdf_2[which(is.na(y_pdf_2) == TRUE)] <- 0
  probs <- rbind(y_pdf_1, y_pdf_2)
  plot_two_distributions(x, y_pdf_1, y_pdf_2, folder, k)
  
  distance <- JSD(probs, unit = 'log2')
  return(as.numeric(distance))
}

jeffreys_divergenceOfDistributions <- function(godels_1, godels_2, k, folder){
  
  # Plotting the two distributions
  x <- seq(min(godels_1, godels_2), max(godels_1, godels_2), 0.1)
  df_1 <- approxfun(density(godels_1))
  df_2 <- approxfun(density(godels_2))
  y_pdf_1 <- df_1(x)
  y_pdf_2 <- df_2(x)
  y_pdf_1[which(is.na(y_pdf_1)== TRUE)] <- 0
  y_pdf_2[which(is.na(y_pdf_2) == TRUE)] <- 0
  plot_two_distributions(x, y_pdf_1, y_pdf_2, folder, k)
  
  distance <- jeffreys(y_pdf_1, y_pdf_2, testNA = TRUE, unit = 'log2')
  return(distance)
}

hellinger_divergenceOfDistributions <- function(godels_1, godels_2, k, folder){
  
  # Plotting the two distributions
  x <- seq(min(godels_1, godels_2), max(godels_1, godels_2), 0.1)
  df_1 <- approxfun(density(godels_1))
  df_2 <- approxfun(density(godels_2))
  y_pdf_1 <- df_1(x)
  y_pdf_2 <- df_2(x)
  y_pdf_1[which(is.na(y_pdf_1)== TRUE)] <- 0
  y_pdf_2[which(is.na(y_pdf_2) == TRUE)] <- 0
  plot_two_distributions(x, y_pdf_1, y_pdf_2, folder, k)
  
  mymin <- min(godels_1, godels_2)
  mymax <- max(godels_1, godels_2)
  
  distance <- hellinger(y_pdf_1, y_pdf_2, testNA = TRUE)
  return(distance)
}


plot_two_distributions <- function(x, pdf1, pdf2, folder, k){
  
  filepath <- paste(folder,'/two_dists_k_', k, '.png', sep = '')
  png(file = filepath, width=1000, height=600)
  plot(x, pdf1, type = 'l', col = 'blue', main = 'Two dists', xlab = 'Godel Number', ylab = 'Probability', ylim = c(0,0.1))
  lines(x, pdf2, type = 'l', col = 'red')
  legend('topright',legend=c('Dist1', 'Dist2'),
         col=c('blue', 'red'), lty = 1, cex=1.0)
  dev.off()
}

bringGodelsFromBothSidesOfCutoff <- function(mydata, cut_off){
  
  godels_1 <- mydata$Godel_number[which(mydata$Value < cut_off)]
  godels_2 <- mydata$Godel_number[which(mydata$Value >= cut_off)]
  
  return(list(godels_1, godels_2))
}



plotSpectrumHistogram <- function(mydata, folder, k){
  
  png(file=paste(folder,'/Counts_dist_k_',k,'.png', sep = ''), width=1200, height=800)
  counts_info <- hist(mydata$Value, breaks = 20,
                      ylab = "Multiplicity - Counts (Number of different k-mers)", xlab = "Frequency", main = paste("K-mers Spectrum for k = " ,k),
                      cex.main = 2, cex.axis = 1.5, cex.lab = 1.5)
  dev.off()
  
  return(counts_info)
  
}

get_prime <- function(n, all = TRUE, i = 1, primes = c()){
  if ( n <= 0) {
    stop("Not a valid number")
  }
  
  if (length(primes) < n) {
    if (i == 2L || all(i %% 2L:ceiling(sqrt(i)) != 0)) {
      get_prime(n, all = all, i = i + 1, primes = c(primes, i))
    } else {
      get_prime(n, all = all, i = i + 1, primes = primes)
    }
  } else {
    if (all) {
      return(primes)
    } else {
      return(tail(primes, 1))
    }
  }
}


newGodelNums <- function(mydata, primes, encoding){
  
  gn_new <- c()
  
  chars = str_split(mydata$K.mer, "", simplify = TRUE)
  
  chars.enc = matrix(data = 0, nrow = nrow(chars), ncol = ncol(chars))
  
  chars.enc = chars.enc + (chars == "A") * encoding[1]
  chars.enc = chars.enc + (chars == "C") * encoding[2]
  chars.enc = chars.enc + (chars == "G") * encoding[3]
  chars.enc = chars.enc + (chars == "T") * encoding[4]
  
  primes = log(primes)
  
  chars.enc = chars.enc %*% diag(primes)
  mydata$Godel_number <- rowSums(chars.enc) # gn_new
  return(mydata)
  
  
}