# libraries
library(LaplacesDemon)

deleteUselessKmers <- function(mydata, dnaBases){
  # Data pre processing - Deleting kmers consisting of letters that don't belong in {A,T,G,C} set
  to_be_deleted <- c()
  for (i in 1:nrow(mydata)){
    chars <-strsplit(mydata[i,1], "")
    chars <- chars[[1]]
    
    for (x in chars){
      if (length(which(dnaBases == x)) == 0){
        to_be_deleted <- c(to_be_deleted, i)
        break
      }
    }
  }
  mydata <- mydata[-to_be_deleted, ]
  return(mydata)
}


normDist <- function(mydata, kld_vector){
  x <- seq(min(mydata$Godel_number), max(mydata$Godel_number), 0.1)
  y_norm <- dnorm(x, mean(mydata$Godel_number), sqrt(var(mydata$Godel_number)))
  df <- approxfun(density(mydata$Godel_number))
  y_pdf <- df(x)
  distance <- KLD(y_pdf, y_norm)
  kld_vector <- c(kld_vector, distance$intrinsic.discrepancy)
  return(kld_vector)
}

bringGodelsWithinInterval <- function(mydata, break1, break2){
  
  godelsWithinInterval <- c()
  
  for (i in 1:length(mydata$Value)){
    if ((mydata$Value[i] >= break1) & (mydata$Value[i] <= break2)){
      godelsWithinInterval <- c(godelsWithinInterval, mydata$Godel_number[i])
    }
  }
  return(godelsWithinInterval)
}

distributionChangeBasedOnCounts <- function(counts_info, mydata, filePath){
  
  godelNums <- mydata$Godel_number
  cur_xlim <- c(min(godelNums), max(godelNums))
  
  cur_ylim <- c(0,0.2)
  legend_list <- c("Total")
  cur_col <- 1
  
  break1 <- counts_info$breaks[1]
  
  png(file=filePath, width=1200, height=800)
  plot(density(godelNums), type = 'l', col = cur_col, xlim = cur_xlim, ylim = cur_ylim,
       xlab = 'Godel Number', ylab = 'Probability',
       main = paste( "Distributions for counts within intervals for k = ",nchar(mydata$K.mer[1]), sep = ''),
       cex.main = 2, cex.axis = 1.5, cex.lab = 1.5)
  
  for (i in 2:15){
    break2 <- counts_info$breaks[i]
    legend_list <- c(legend_list, paste("Counts in [", break1, ", " ,break2, "]", sep = ''))
    cur_col <- cur_col + 1
    
    godelsWithinInterval <- bringGodelsWithinInterval(mydata, break1, break2 )
    cur_x <-seq(min(godelsWithinInterval), max(godelsWithinInterval), 0.1 )
    df <- approxfun(density(godelsWithinInterval))
    y_pdf <- df(cur_x)
    lines(cur_x, y_pdf, col = cur_col, type = 'l')
    
  }
  legend('topright',legend=legend_list,
         col=c(1:15), lty = 1, cex=0.8)
  dev.off()
  
}

plotDistributionHistogram <- function(mydata, folder){
  
  png(file=paste(folder,'/GodelNumberDist_k_',k,'.png', sep = ''), width=1200, height=800)
  hist_info <- hist(mydata$Godel_number, breaks = 50, 
                    xlab = "Godel Number", ylab = "Probability", 
                    main = paste("Godel Numbers Distribution for k = " ,k), probability = TRUE, ylim = c(0, 0.15),
                    cex.main = 2, cex.axis = 1.5, cex.lab = 1.5)
  lines(density(mydata$Godel_number), col = 'blue')
  x <- seq(min(mydata$Godel_number), max(mydata$Godel_number), 0.1)
  y_norm <- dnorm(x, mean(mydata$Godel_number), sqrt(var(mydata$Godel_number)))
  lines(x,y_norm, lty = 2, col = 'red', type = 'l')
  legend('topright', legend=c(" Data distribution ", "Normal Distribution"),
         col=c("blue", "red"), lty=1:2, cex=1.5)
  dev.off()
  
}

plotSpectrumHistogram <- function(mydata, folder){
  
  png(file=paste(folder,'/Counts_dist_k_',k,'.png', sep = ''), width=1200, height=800)
  counts_info <- hist(mydata$Value, breaks = 40,
                      xlab = "Multiplicity (Number of different k-mers)", ylab = "Frequency", main = paste("K-mers Spectrum for k = " ,k),
                      cex.main = 2, cex.axis = 1.5, cex.lab = 1.5)
  dev.off()
  
  return(counts_info)
  
}

plotSpectrumHistogramsBasedOnThresholds <- function(mydata, thresholds, k, species, enc){
  
  cur_col = 1
  
  folder <- paste('plots/sars_',paste(enc, collapse = '') , sep = '')
  
  # Initialization and filepath
  legend_list <- c()
  xmin <- min(mydata$Godel_number)
  xmax <- max(mydata$Godel_number)
  x <- seq(xmin, xmax, 0.1)
  filepath <- paste(folder,'/changesInDistributions_k_', k, '.png', sep = '') 
  
  # Step 1
  break1 <- 0
  break2 <- thresholds[1]
  godelsWithinInterval <- bringGodelsWithinInterval(mydata, break1, break2 )
  df <- approxfun(density(godelsWithinInterval))
  y_pdf <- df(x)
  
  png(file=filepath, width=1200, height=800)
  plot(x, y_pdf, type = 'l', col = cur_col, xlim = c(xmin, xmax), ylim = c(0,0.2),
       main = paste( "Distributions for counts within intervals for k = ",k, sep = ''),
       cex.main = 2, cex.axis = 1.5, cex.lab = 1.5)
  legend_list <- c(legend_list, paste("Counts in [", break1, ", " ,break2, "]", sep = ''))
  
  if(length(thresholds) == 1){
    break1 <- thresholds[1]
    break2 <- Inf
    godelsWithinInterval <- bringGodelsWithinInterval(mydata, break1, break2 )
    df <- approxfun(density(godelsWithinInterval))
    
    y_pdf <- df(x)
    
    cur_col <- cur_col + 1
    lines(x, y_pdf, col = cur_col, type = 'l')
    legend_list <- c(legend_list, paste("Counts in [", break1, ", " ,break2, "]", sep = ''))
    
    
  }else{
    
    for (i in 2:length(thresholds)){
      break1 <- break2
      break2 <- thresholds[i]
      godelsWithinInterval <- bringGodelsWithinInterval(mydata, break1, break2 )
      df <- approxfun(density(godelsWithinInterval))
      y_pdf <- df(x)
      
      cur_col <- cur_col + 1
      lines(x, y_pdf, col = cur_col, type = 'l')
      legend_list <- c(legend_list, paste("Counts in [", break1, ", " ,break2, "]", sep = ''))
      
    }
    
    break1 <- break2
    break2 <- Inf
    godelsWithinInterval <- bringGodelsWithinInterval(mydata, break1, break2 )
    df <- approxfun(density(godelsWithinInterval))
    y_pdf <- df(x)
    
    cur_col <- cur_col + 1
    lines(x, y_pdf, col = cur_col, type = 'l')
    legend_list <- c(legend_list, paste("Counts in [", break1, ", " ,break2, "]", sep = ''))
  }
  
  legend('topright',legend=legend_list,
         col=c(1:cur_col), lty = 1, cex=1.6)
  dev.off()
  
}

distributionsOfSpecificCounts <- function(mydata, k, species, enc){
  
  if (k == 4){
    thresholds <- c(60000, 200000)
  }else if (k == 5){
    thresholds <- c(20000, 60000)
  }else if (k == 6){
    thresholds <- c(10000, 20000)
  }else if (k == 7){
    thresholds <- c(1000, 2000, 3000, 4000)
  }else if (k == 8){
    thresholds <- c(400, 1400, 2400)
  }else{
    thresholds <- c(500)
  }
  
  
  plotSpectrumHistogramsBasedOnThresholds(mydata, thresholds, k, species, enc)
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


gn <- function(seq, primes, encoding){
  
  gn <- 0
  
  for(i in 1:length(primes)){
    base <- substring(seq, i,i)
    
    if (base == "A"){
      gn <- gn + encoding[1]*log(primes[i])
    }else if (base == "C"){
      gn <- gn + encoding[2]*log(primes[i])
    }else if (base == "G"){
      gn <- gn + encoding[3]*log(primes[i])
    }else if (base == "T"){
      gn <- gn + encoding[4]*log(primes[i])
    }else{
      gn <- 0
      break
    }
    
  }
  
  return(gn)
}

newGodelNums <- function(mydata, primes, encoding){
  
  gn_new <- c()
  
  for(i in 1:length(mydata$K.mer)){
    
    gn_new <- c(gn_new, gn(mydata$K.mer[i], primes, encoding))
  }
  
  
  mydata$Godel_number <- gn_new
  return(mydata)
  
  
}