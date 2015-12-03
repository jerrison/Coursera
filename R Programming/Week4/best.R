best <- function(state, outcome) {
    
    data <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
    data <- data[,c(2, 7, 11, 17, 23)]
    state.list <- unique(data[, "State"])
    
    # check if state is valid
    if (state %in% state.list == FALSE)
        stop("invalid state")
    
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
    
    # get row number(s) that have lowest mortality rate
    mortality_ranking <- which(rank(data[, 3], ties.method = "min") == 1)
    
    # subset of only hospital(s) that have lowest mortality rate
    data <- data[mortality_ranking, ]
    
    # rank on hospital name
    hospital_ranking <- which(rank(data[, 1], ties.method = "min") == 1)
    
    data[hospital_ranking, 1]
    
}