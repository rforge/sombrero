## These functions handle SOM learning
initSOM <- function(dimension=c(5,5), topo=c("square"), 
                    type=c("numeric", "relational"), mode=c("online"), 
                    maxit=500, nb.save=0, verbose=FALSE, proto0=NULL, 
                    init.proto=c("random","obs"), 
                    scale=c("unitvar","none","center"), 
                    radius.type=c("letremy")){
  
  params <- list("the.grid"=initGrid(dimension,match.arg(topo,c("square"))),
                 "type"=match.arg(type,c("numeric", "relational")),
                 "mode"=match.arg(mode,c("online")), maxit=maxit,
                 nb.save=nb.save, "proto0"=proto0,
                 init.proto=match.arg(init.proto,c("random","obs")),
                 scale=match.arg(scale,c("unitvar","none","center")),
                 radius.type=match.arg(radius.type,c("letremy")), 
                 "verbose"=verbose)
  ## TODO: to add later: other types, other modes (?), init=pca, scale=chi2,
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
  cat("    Data pre-processing type       : ", x$scale, "\n")
  cat("    Neighbourhood type             : ", x$radius.type, "\n")
  cat("\n")
}

summary.paramSOM <- function(object,...){
  cat("\nSummary\n\n")
  cat("  Class                            : ", class(object),"\n")
  print(object)
}