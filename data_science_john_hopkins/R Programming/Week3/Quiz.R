###############################################################################
#               Question 1                                        
###############################################################################
library(datasets)
data(iris)

#extract dataset containing only species == 'virginica' rows
irisVirginicaOnly <- iris[which(iris$Species == 'virginica'), ]

s <- split(iris, iris$Species)

meanBySpecies <- sapply(s ,function(x) {
    colMeans(x[, c("Sepal.Length", "Sepal.Width")])
})


###############################################################################
#               Question 2                                        
###############################################################################
print("Question 2")
apply(iris[, 1:4], 2, mean)


###############################################################################
#               Question 3                                                  
###############################################################################
data(mtcars)
meanMpgByCyl <- tapply(mtcars$mpg, mtcars$cyl, mean)
AbsDiffAvgMpg4_8Cyl <- abs(meanMpgByCyl[1]-meanMpgByCyl[3])


###############################################################################
#               Question 4                                                  
###############################################################################
meanHpByCyl <- tapply(mtcars$hp, mtcars$cyl, mean)
AbsDiffAvgHP4_8Cyl <- abs(meanHpByCyl[1]-meanHpByCyl[3])
