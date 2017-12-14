complete <- function(directory, id = 1:332) {
    files_full <- list.files(directory, full.names = TRUE)

    output <- as.data.frame(matrix(0, ncol = 2, nrow = length(id)))
    colnames(output) <- c("id", "nobs")

    for (i in seq_along(id)) {

        file_index <- id[i]
        dat <- data.frame()
        dat <- read.csv(files_full[file_index])
        nobs <- sum(complete.cases(dat))
        id_number = dat[1,"ID"]
        output[i,] <- c(id_number, nobs)
    }
    output
}
