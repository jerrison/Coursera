rankhospital <- function(state, outcome, num = "best") {
    
    data <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
    data <- data[,c(2, 7, 11, 17, 23)]
    state.list <- unique(data[, "State"])
    
    # check if state is valid
    if (state %in% state.list == FALSE) {
        stop("invalid state")
    }
    
    # select column number to extract based on selected outcome
    if (outcome == "heart attack") {
        outcome_number <- 3
    }
    else if (outcome == "heart failure") {
        outcome_number <- 4
    }
    else if (outcome == "pneumonia") {
        outcome_number <- 5
    }
    else stop("invalid outcome")
    
    # extract subset containing only hospital name, state and specific outcome
    data <- data[, c(1, 2, outcome_number)]
    
    # further subset on specific state and exclude "Not Available" entries for
    # that outcome
    data <- data[which(data[, 2] == state), ]
    data <- data[which(data[, 3] != "Not Available"), ]
    
    # convert mortality rate to numeric
    data[, 3] <- as.numeric(data[, 3])
    
    # check that num is within possible range of ranking
    max_num <- length(data[, 3])
    
    if (num == "best") desired_rank <- 1
    else if (num == "worst") desired_rank <- max_num
    else if (num <= max_num) desired_rank <- num
    else return(NA)
    
    o <- order(data[, 3], data[, 1])
    data <- cbind(data[, 1][o], data[, 3][o])
    
    data[desired_rank, 1]

    
}