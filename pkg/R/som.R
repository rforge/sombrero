## SOM algorithm functions

# Functions to manipulate the grid
calculateRadius <- function(the.grid, radius.type, ind.t, maxit) {
  ## TODO: implement other radius types
  # ind.t: iteration index
  if (radius.type=="letremy") {
    r0 <- max(c(floor(the.grid$dim[1]/2), floor(the.grid$dim[2]/2)))
    k <- 2*(r0-1)/maxit
    a <- floor(maxit/2)
    b <- floor(maxit*3/4)
    r <- ceiling(r0/(1+k*ind.t))
    if (ind.t==1) {
      r <- r0
    } else if (ind.t>=a & ind.t<b) {
      r <- 1
    } else if (ind.t>=b) {
      r <- 0
    }
  }
  r
}

selectNei <- function(the.neuron, the.grid, radius) {
  the.dist <- as.matrix(dist(the.grid$coord, diag=TRUE, upper=TRUE,
                             method=the.grid$dist.type))[the.neuron,]
  the.nei <- which(the.dist<=radius)
  the.nei
}

# Functions to manipulate objects in the input space
distElt <- function(x, y, som.type="numeric") {
  if (som.type=="numeric") d2xy <- sum((x-y)^2)
  d2xy
}

oneObsAffectation <- function(x.new, prototypes, type, x.data=NULL) {
  # x.data: only used if type=relational
  ## TODO: implement other types such as relational
  if (type=="numeric") {
    the.neuron <- which.min(apply(prototypes, 1, function(x) {
      distElt(x,x.new)
    }))
  }
  the.neuron
}

calculateClusterEnergy <- function(cluster, x.data, clustering, prototypes,
                                   parameters, radius) {
  if (parameters$type=="numeric") {
    if (parameters$radius.type=="letremy") {
      the.nei <- selectNei(cluster, parameters$the.grid, radius)
      if (sum(clustering%in%the.nei)>0) {
        # FIX IT!! Use the distElt function instead
        sum((x.data[which(clustering%in%the.nei),]-
               tcrossprod(rep(1,sum(clustering%in%the.nei)),
                          prototypes[cluster,]))^2)
      }
    }
  }
}

calculateEnergy <- function(x.data, clustering, prototypes, parameters, ind.t) {
  if (parameters$type=="numeric") {
    if (parameters$radius.type=="letremy") {
      radius <- calculateRadius(parameters$the.grid, parameters$radius.type,
                                ind.t, parameters$maxit)
      sum(unlist(sapply(1:nrow(prototypes), calculateClusterEnergy,
                        x.data=x.data, clustering=clustering, 
                        prototypes=prototypes, parameters=parameters,
                        radius=radius)))/
        nrow(x.data)/nrow(prototypes)
    }
  }
}

trainNumericSOM <- function(x.data, parameters) {
  # This function is internal, called by trainSOM and does not need to be
  # documented

  ## Preprocess the data: scaling here
  norm.x.data <- switch(parameters$scaling,
                        "unitvar"=scale(x.data, center=TRUE, scale=TRUE),
                        "center"=scale(x.data, center=TRUE, scale=FALSE),
                        "none"=as.matrix(x.data))
  
  ## First step: initialization of the prototypes
  if (is.null(parameters$proto0)) {
    if (parameters$init.proto=="random") {
      prototypes <- sapply(1:ncol(norm.x.data),
                           function(ind){
                             runif(parameters$the.grid$dim[1]*
                                   parameters$the.grid$dim[2],
                             min=min(norm.x.data[,ind]), 
                                   max=max(norm.x.data[,ind]))
                           })
    } else if (parameters$init.proto=="obs") {
      prototypes <- norm.x.data[sample(1:nrow(norm.x.data), 
                                       parameters$the.grid$dim[1]*
                           parameters$the.grid$dim[2], replace=TRUE),]
    }
  } else {
    prototypes <- switch(parameters$scaling,
                         "unitvar"=scale(parameters$proto0, 
                                         center=apply(x.data,2,mean),
                                         scale=apply(x.data,2,sd)),
                         "center"=scale(parameters$proto0, 
                                        center=apply(x.data,2,mean),
                                        scale=FALSE),
                         "none"=parameters$proto0)
  }
  
  # initialize backup if needed
  if(parameters$nb.save>1) {
    backup <- list()
    backup$prototypes <- list()
    backup$clustering <- matrix(ncol=parameters$nb.save, 
                                nrow=nrow(norm.x.data))
    backup$energy <- vector(length=parameters$nb.save)
    backup$steps <- round(seq(1,parameters$maxit,length=parameters$nb.save),0)
  }
  
  ## Loop from 1 to parameters$maxit
  for (ind.t in 1:parameters$maxit) {
    if (parameters$verbose) {
      if (ind.t %in% round(seq(1, parameters$maxit, length=11))) {
        index <- match(ind.t, round(seq(1, parameters$maxit, length=11)))
        cat((index-1)*10, "% done\n")
      }
    }
    
    # randomly choose an observation
    x.new <- norm.x.data[sample(1:nrow(norm.x.data), 1),]
    # Assignement step: assign this observation to the closest prototype
    winner <- oneObsAffectation(x.new, prototypes, parameters$type)
    # Representation step: update prototypes with a gradient descent
    radius <- calculateRadius(parameters$the.grid, parameters$radius.type,
                              ind.t, parameters$maxit)
    the.nei <- selectNei(winner, parameters$the.grid, radius)
    # Letremy's heuristic
    # FIX IT!!! Use the distElt function instead
    epsilon <- 0.3/(1+0.2*ind.t/(parameters$the.grid$dim[1]*
                               parameters$the.grid$dim[2]))
    prototypes[the.nei,] <- (1-epsilon)*prototypes[the.nei,] +
      epsilon*tcrossprod(rep(1,length(the.nei)), x.new)

    ## considering itermediate backups
    if (parameters$nb.save==1) {
      warning("nb.save can not be 1\n No intermediate backups saved",
              immediate.=TRUE, call.=TRUE)
    }
    if (parameters$nb.save>1) {
      if(ind.t %in% backup$steps) {
        out.proto <- switch(parameters$scaling,
                            "unitvar"=scale(prototypes, 
                                            center=-apply(x.data,2,mean)/
                                              apply(x.data,2,sd),
                                            scale=1/apply(x.data,2,sd)),
                            "center"=scale(prototypes, 
                                           center=-apply(x.data,2,mean),
                                           scale=FALSE),
                            "none"=prototypes)
        res <- list("parameters"=parameters, "prototypes"=out.proto, 
                    "data"=x.data)
        class(res) <- "somRes"

        ind.s <- match(ind.t,backup$steps)
        backup$prototypes[[ind.s]] <- out.proto
        backup$clustering[,ind.s] <- predict.somRes(res, x.data)
        backup$energy[ind.s] <- calculateEnergy(norm.x.data,
                                                backup$clustering[,ind.s],
                                                prototypes, parameters, ind.t)
      }
      if (ind.t==parameters$maxit) {
        clustering <- backup$clustering[,ind.s]
        energy <- backup$energy[ind.s]
      }
    } else if (ind.t==parameters$maxit) {
      out.proto <- switch(parameters$scaling,
                          "unitvar"=scale(prototypes, 
                                          center=-apply(x.data,2,mean)/
                                            apply(x.data,2,sd),
                                          scale=1/apply(x.data,2,sd)),
                          "center"=scale(prototypes, 
                                         center=-apply(x.data,2,mean),
                                         scale=FALSE),
                          "none"=prototypes)
      res <- list("parameters"=parameters, "prototypes"=out.proto,
                  "data"=x.data)
      class(res) <- "somRes"
      clustering <- predict.somRes(res, x.data)
      energy <- calculateEnergy(norm.x.data, clustering, prototypes, parameters,
                                ind.t)
    }
  }
  
  colnames(out.proto) <- colnames(x.data)
  rownames(out.proto) <- 1:prod(parameters$the.grid$dim)
  if (parameters$nb.save<=1) {
    res <- list("clustering"=clustering, "prototypes"=out.proto,
                "energy"=energy, "data"=x.data, "parameters"=parameters)
  } else {
    res <- list("clustering"=clustering, "prototypes"=out.proto,
                "energy"=energy, "backup"=backup, "data"=x.data, 
                "parameters"=parameters)
  }
  class(res) <- "somRes"
  return(res)
}

trainSOM <- function(x.data, 
                     dimension=c(max(5,min(10,ceiling(sqrt(nrow(x.data)/10)))), 
                                 max(5,min(10,ceiling(sqrt(nrow(x.data)/10))))),
                     maxit=round(nrow(x.data)*5), ...) {
  param.args <- list(...)
  param.args <- c(list("dimension"=dimension, "maxit"=maxit), param.args)
  parameters <- do.call("initSOM", param.args)
  if (parameters$verbose) {
    cat("Self-Organizing Map algorithm...\n")
    print.paramSOM(parameters)
  }
  res <- switch(parameters$type,
        "numeric"=trainNumericSOM(x.data, parameters=parameters))
  invisible(res)
}

## S3 methods for somRes class objects
print.somRes <- function(x, ...){
  cat("      Self-Organizing Map object...\n")
  cat("        ", x$parameters$mode, "learning, type:", x$parameters$type,"\n")
  cat("        ", x$parameters$the.grid$dim[1],"x",
      x$parameters$the.grid$dim[2],
      "grid with",x$parameters$the.grid$topo, "topology\n")
}

summary.somRes <- function(object, ...){
  cat("\nSummary\n\n")
  cat("      Class : ", class(object),"\n\n")
  print(object)
  cat("\n      Final energy:", object$energy,"\n")
  cat("\n      ANOVA               : \n")
  res.anova <- as.data.frame(t(sapply(1:ncol(object$data), function(ind) {
    c(round(summary(aov(object$data[,ind]~as.factor(object$clustering)))[[1]][1,4],
            digits=3),
      round(summary(aov(object$data[,ind]~as.factor(object$clustering)))[[1]][1,5],
            digits=8))
  })))
  names(res.anova) <- c("F", "pvalue")
  res.anova$significativity <- rep("",ncol(object$data))
  res.anova$significativity[res.anova$"pvalue"<0.05] <- "*"
  res.anova$significativity[res.anova$"pvalue"<0.01] <- "**"
  res.anova$significativity[res.anova$"pvalue"<0.001] <- "***"
  rownames(res.anova) <- colnames(object$data)
  
  cat("\n        Degrees of freedom : ", 
      summary(aov(object$data[,1]~as.factor(object$clustering)))[[1]][1,1], "\n\n")
  print(res.anova)  
  cat("\n")
}

predict.somRes <- function(object, x.new, ...) {
  ## TODO: implement other types such as relational
  if(object$parameters$type=="numeric") {
    norm.x.new <- switch(object$parameters$scaling,
                         "unitvar"=scale(x.new,
                                         center=apply(object$data,2,mean),
                                         scale=apply(object$data,2,sd)),
                         "center"=scale(x.new,
                                        center=apply(object$data,2,mean),
                                        scale=FALSE),
                         "none"=as.matrix(x.new))
    norm.proto <- switch(object$parameters$scaling,
                         "unitvar"=scale(object$prototypes, 
                                         center=apply(object$data,2,mean),
                                         scale=apply(object$data,2,sd)),
                         "center"=scale(object$prototypes, 
                                        center=apply(object$data,2,mean),
                                        scale=FALSE),
                         "none"=object$prototypes)
    winners <- apply(norm.x.new, 1, oneObsAffectation,
                     prototypes=norm.proto, type=object$parameters$type)
  }
  winners
}