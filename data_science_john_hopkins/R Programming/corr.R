corr <- function(directory, threshold = 0) {

    files_full <- list.files(directory, full.names = TRUE)
    complete_list <- complete(directory)
    files_index_to_be_read <-
    {
        complete_list[which(complete_list$nobs > threshold), 1]
    }

    ouput <- vector(length = length(files_index_to_be_read))

    for (i in seq_along(files_index_to_be_read)) {

        data <- data.frame()
        data <- read.csv(files_full[files_index_to_be_read[i]])
        output[i] <- cor(data$sulfate, data$nitrate, use = "complete.obs")
    }

    output

}
