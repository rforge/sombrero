topographicError <- function (sommap) {
  all.dist <- apply(sommap$data, 1, function(x) {
    apply(sommap$prototypes,1,function(y) distElt(x,y) )
  })
  ind.winner2 <- apply(all.dist,2,function(x) order(x)[2])
  res.error <- mean(!sapply(1:nrow(sommap$data), function(x) {
      is.element(ind.winner2[x], selectNei(sommap$clustering[x],
                                           sommap$parameters$the.grid, 1))
  }))
  return(res.error)
}

quantizationError <- function(sommap) {
  # FIX IT!! Maybe use distElt here if possible
  sum(apply((sommap$data-sommap$prototypes[sommap$clustering,])^2,1,sum))/
    nrow(sommap$data)
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
