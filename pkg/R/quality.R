topographicError <- function (sommap) {
  if (sommap$parameters$type=="numeric") {
    all.dist <- apply(sommap$data, 1, function(x) {
      apply(sommap$prototypes,1,function(y) distElt(x,y) )
    })
    ind.winner2 <- apply(all.dist,2,function(x) order(x)[2])
  } else if (sommap$parameters$type=="korresp") {
    norm.data <- korrespPreprocess(sommap$data)
    nr <- nrow(sommap$data)
    nc <- ncol(sommap$data)
    all.dist.row <- apply(norm.data[1:nr,1:nc], 1, function(x) {
      apply(sommap$prototypes[,1:nc], 1, function(y) distElt(x,y) )
    })
    all.dist.col <- apply(norm.data[(nr+1):(nr+nc),(nc+1):(nr+nc)],
                          1, function(x) {
      apply(sommap$prototypes[,(nc+1):(nr+nc)], 1, function(y) distElt(x,y) )
    })
    ind.winner2 <- c(apply(all.dist.col,2,function(x) order(x)[2]),
                     apply(all.dist.row,2,function(x) order(x)[2]))
  }
  res.error <- mean(!sapply(1:nrow(sommap$data), function(x) {
      is.element(ind.winner2[x], selectNei(sommap$clustering[x],
                                           sommap$parameters$the.grid, 1))
  }))
  return(res.error)
}

quantizationError <- function(sommap) {
  # FIX IT!! Maybe use distElt here if possible
  if (sommap$parameters$type=="numeric") {
    quantization.error <- sum(apply((sommap$data-
                                       sommap$prototypes[sommap$clustering,])^2,
                                    1,sum))/nrow(sommap$data)
  } else if (sommap$parameters$type=="korresp") {
    norm.data <- korrespPreprocess(sommap$data)
    nr <- nrow(sommap$data)
    nc <- ncol(sommap$data)
    quantization.error <- sum(apply((norm.data[1:nr,1:nc]-
                                       sommap$prototypes[sommap$clustering[
                                         (nc+1):(nc+nr)],1:nc])^2,1,sum))
    quantization.error <- quantization.error +
      sum(apply((norm.data[(nr+1):(nr+nc),(nc+1):(nr+nc)]-
                   sommap$prototypes[sommap$clustering[1:nc],(nc+1):(nr+nc)])^2,
                1,sum))
    quantization.error <- quantization.error / (nc+nr)
  }
  quantization.error
}

# main function
quality <- function(sommap, quality.type=c("all", "quantization",
                                           "topographic")) {
  quality.type <- match.arg(quality.type)
  switch(quality.type,
         "all"=list("topographic"=topographicError(sommap),
                    "quantization"=quantizationError(sommap)),
         "topographic"=topographicError(sommap),
         "quantization"=quantizationError(sommap)
         )
}
