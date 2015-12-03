make.NegLogLik <- function(data, fixed = c(FALSE, FALSE)) {
    params <- fixed
    function(p) {
        params[!fixed] <- p
        mu <- params[1]       
        sigma <- params[2]
        
        ##Calculate the Normal Density
        a <- -0.5*length(data)*log(2*pi*sigma^2)
        b <- -0.5*sum((data-mu)^2)/(sigma^2)
        -(a+b)
    }
}

weightmedian <- function(directory, day) {
    files_list <- list.files(directory, full.names = TRUE) #creates a list of files
    dat <- data.frame() #creates an empty data frame
    for (i in 1:5) {
        #loops through the files, rbinding them together
        dat <- rbind(dat, read.csv(files_list[i]))
    }
    dat_subset <- dat[which(dat[, "Day"] == day),]
    median(dat_subset[,"Weight"], na.rm = TRUE)
}