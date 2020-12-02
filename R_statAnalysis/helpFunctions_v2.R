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


normDist <- function(mydata, kld_vector){
  x <- seq(min(mydata$Godel_number), max(mydata$Godel_number), 0.1)
  y_norm <- dnorm(x, mean(mydata$Godel_number), sqrt(var(mydata$Godel_number)))
  df <- approxfun(density(mydata$Godel_number))
  y_pdf <- df(x)
  distance <- KLD(y_pdf, y_norm)
  kld_vector <- c(kld_vector, distance$intrinsic.discrepancy)
  return(kld_vector)
}

normDist_lapply <- function(mydata){
  x <- seq(min(mydata$Godel_number), max(mydata$Godel_number), 0.1)
  y_norm <- dnorm(x, mean(mydata$Godel_number), sqrt(var(mydata$Godel_number)))
  df <- approxfun(density(mydata$Godel_number))
  y_pdf <- df(x)
  distance <- KLD(y_pdf, y_norm)
  return(distance$intrinsic.discrepancy)
}

plotDistributionHistogram <- function(mydata, folder, k){
  
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