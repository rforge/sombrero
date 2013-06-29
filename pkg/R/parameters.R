## These functions handle SOM learning
initSOM <- function(dimension=c(5,5), topo=c("square"),
                    dist.type=c("maximum","euclidean","manhattan","canberra",
                                "binary","minkowski"),
                    type=c("numeric", "relational"), mode=c("online"), 
                    maxit=500, nb.save=0, verbose=FALSE, proto0=NULL, 
                    init.proto=c("random","obs"), 
                    scaling=c("unitvar","none","center"), 
                    radius.type=c("letremy")) {
  
  params <- list("the.grid"=initGrid(dimension,match.arg(topo),
                                     match.arg(dist.type)),
                 "type"=match.arg(type), "mode"=match.arg(mode), maxit=maxit,
                 nb.save=nb.save, "proto0"=proto0,
                 init.proto=match.arg(init.proto), scaling=match.arg(scaling),
                 radius.type=match.arg(radius.type),
                 "verbose"=verbose)
  ## TODO: to add later: other types, other modes (?), init=pca, scaling=chi2,
  # and radius.type=gaussian
  class(params) <- "paramSOM"
  
  return(params)
}

print.paramSOM <- function(x,...){
  cat("\n  Parameters of the SOM\n\n")
  cat("    SOM mode                       : ", x$mode, "\n")
  cat("    SOM type                       : ", x$type, "\n")
  cat("    Grid                           : ")
  print(x$the.grid)
  cat("    Number of iterations           : ", x$maxit, "\n")
  cat("    Number of intermediate backups : ", x$nb.save, "\n")
  if(identical(x$proto0,NULL)){
    cat("    Initializing prototypes method : ", x$init.proto, "\n")
  } else {
    cat("    Initial prototypes given by user\n")
  }
  cat("    Data pre-processing type       : ", x$scaling, "\n")
  cat("    Neighbourhood type             : ", x$radius.type, "\n")
  cat("\n")
}

summary.paramSOM <- function(object,...){
  cat("\nSummary\n\n")
  cat("  Class                            : ", class(object),"\n")
  print(object)
}