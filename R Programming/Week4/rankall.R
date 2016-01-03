rankall <- function(outcome, num = "best") {
    
    data <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
    data <- data[,c(2, 7, 11, 17, 23)]
    state.list <- unique(data[, "State"])
    state.list <- state.list[order(state.list)]

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
    data <- data[which(data[, 3] != "Not Available"), ]
    
    # convert mortality rate to numeric
    data[, 3] <- as.numeric(data[, 3])
    
    # split "data" by state
    data <- split(data, data$State)
    
    result <- data.frame(hospital = character(), state = character(),
                         stringsAsFactors = FALSE)
    
    for( i in seq_along(state.list)) {
        dataSubset <- data[i]
        dataSubset <- as.data.frame(dataSubset)
        
        max_num <- length(dataSubset[, 3])

        o <- order(dataSubset[, 3], dataSubset[, 1])
        dataSubset <- cbind(dataSubset[, 1][o], dataSubset[, 3][o])                                
        
        if (num == "best") {
            result1 <- data.frame(hospital = dataSubset[1, 1], 
                state.list[i], stringsAsFactors = FALSE)
            result <- rbind(result, result1)
        }
        else if (num == "worst") {
            result1 <- data.frame(hospital = dataSubset[max_num, 1], 
                state.list[i], stringsAsFactors = FALSE)
            result <- rbind(result, result1)
        }
        else if (num <= max_num) {
            result1 <- data.frame(hospital = dataSubset[num, 1], 
                state.list[i], stringsAsFactors = FALSE)
            result <- rbind(result, result1)
        }
        else {
            result1 <- data.frame(hospital = "<NA>", 
                state.list[i], stringsAsFactors = FALSE)            
            result <- rbind(result, result1)
        }
                     
    }
    
    colnames(result) <- c("hospital", "state")
    result
    
}