library(SOMbrero)
# Test different scaling
# The user must check by himself that the prototypes have values in accordance
# to the data: the test file print the prototypes summary as well as three
# graphics corresponding to the different scaling

## Numeric data
###############################################################
set.seed(4031719)
the.data <- data.frame("x1"=runif(500), "x2"=runif(500))
print(summary(the.data))
par(mfrow=c(1,3))

## no scaling
set.seed(4031731)
my.som <- trainSOM(x.data=the.data, dimension=c(5,5), nb.save=10, maxit=2000,
                   scaling="none")
print(summary(my.som$prototypes))
tra <- NULL
for (i in c(1,6,11,16,21)){
  tra <- c(tra, i, i+1, i+1, i+2, i+2, i+3, i+3, i+4)
}
for (i in c(1:5)){
  tra <- c(tra, i, i+5, i+5, i+10, i+10, i+15, i+15, i+20)
}
tmp <- matrix(tra, ncol=2, byrow=TRUE)
par(mfrow=c(2, 5),mar=c(3,2,2,1))
invisible(sapply(1:my.som$parameters$nb.save, function(ind){
  plot(my.som$backup$prototypes[[ind]][,1], my.som$backup$prototypes[[ind]][,2],
       xlab="", ylab="", main=c("iteration ", my.som$backup$steps[ind]))
  for (i in 1:nrow(tmp)){
    segments(x0=my.som$backup$prototypes[[ind]][tmp[i,1],1], 
             y0=my.som$backup$prototypes[[ind]][tmp[i,1],2],
             x1=my.som$backup$prototypes[[ind]][tmp[i,2],1], 
             y1=my.som$backup$prototypes[[ind]][tmp[i,2],2], 
             col="red", pch=19)
  }
}))

## centering
set.seed(17031333)
my.som <- trainSOM(x.data=the.data, dimension=c(5,5), nb.save=10, maxit=2000,
                   scaling="center")
print(summary(my.som$prototypes))
tra <- NULL
for (i in c(1,6,11,16,21)){
  tra <- c(tra, i, i+1, i+1, i+2, i+2, i+3, i+3, i+4)
}
for (i in c(1:5)){
  tra <- c(tra, i, i+5, i+5, i+10, i+10, i+15, i+15, i+20)
}
tmp <- matrix(tra, ncol=2, byrow=TRUE)
par(mfrow=c(2, 5),mar=c(3,2,2,1))
invisible(sapply(1:my.som$parameters$nb.save, function(ind){
  plot(my.som$backup$prototypes[[ind]][,1], my.som$backup$prototypes[[ind]][,2],
       xlab="", ylab="", main=c("iteration ", my.som$backup$steps[ind]))
  for (i in 1:nrow(tmp)){
    segments(x0=my.som$backup$prototypes[[ind]][tmp[i,1],1], 
             y0=my.som$backup$prototypes[[ind]][tmp[i,1],2],
             x1=my.som$backup$prototypes[[ind]][tmp[i,2],1], 
             y1=my.som$backup$prototypes[[ind]][tmp[i,2],2], 
             col="red", pch=19)
  }
}))

# center and reduce
set.seed(17031334)
my.som <- trainSOM(x.data=the.data, dimension=c(5,5), nb.save=10, maxit=2000,
                   scaling="unitvar")
print(summary(my.som$prototypes))
tra <- NULL
for (i in c(1,6,11,16,21)){
  tra <- c(tra, i, i+1, i+1, i+2, i+2, i+3, i+3, i+4)
}
for (i in c(1:5)){
  tra <- c(tra, i, i+5, i+5, i+10, i+10, i+15, i+15, i+20)
}
tmp <- matrix(tra, ncol=2, byrow=TRUE)
par(mfrow=c(2, 5),mar=c(3,2,2,1))
invisible(sapply(1:my.som$parameters$nb.save, function(ind){
  plot(my.som$backup$prototypes[[ind]][,1], my.som$backup$prototypes[[ind]][,2],
       xlab="", ylab="", main=c("iteration ", my.som$backup$steps[ind]))
  for (i in 1:nrow(tmp)){
    segments(x0=my.som$backup$prototypes[[ind]][tmp[i,1],1], 
             y0=my.som$backup$prototypes[[ind]][tmp[i,1],2],
             x1=my.som$backup$prototypes[[ind]][tmp[i,2],1], 
             y1=my.som$backup$prototypes[[ind]][tmp[i,2],2], 
             col="red", pch=19)
  }
}))
