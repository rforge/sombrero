### SOM algorithm graphics
plot.prototypes <- function(sommap, type, var, palette, args) {
  ## types : 3d, lines, barplot, radar, color
  # default value for type="lines"
  if (!is.element(type,c("3d","lines","barplot","radard","color"))) {
    warning("incorrect type replaced by 'lines'\n", call.=TRUE, 
            immediate.=TRUE)
    type <- "lines"
  }
  if (type=="3d") {
    # TODO
  } else if (type=="lines") {
    # TODO
  } else if (type=="barplot") {
    # TODO
  } else if (type=="radar") {
    # TODO
  } else {
    # type=="color"
    if (is.null(palette)) {
      nb.breaks <- max(c(floor(1 + (3.3*log(nrow(sommap$prototypes),base=10))),
                         9))
    } else {
      nb.breaks <- length(palette)
    }
    the.breaks <- seq(min(sommap$prototypes[,var])-10^(-5),
                      max(sommap$prototypes[,var])+10^(-5),
                      length=nb.breaks+1)
    if (is.null(palette)) {
      my.colors <- heat.colors(nb.breaks)[nb.breaks:1]
    } else {
      my.colors <- palette
    }
    vect.color <- my.colors[cut(sommap$prototypes[,var], the.breaks,
                                labels=FALSE)]
    plot.args <- c(list(x=sommap$parameters$the.grid, neuron.col=vect.color),
                   args)
    do.call("plot.myGrid",plot.args)
  }
}

plot.obs <- function(sommap, type, args) {
  ## types : hitmap, lines, names
  # default value for type="hitmap"
  if(!is.element(type,c("hitmap", "lines", "names"))) {
    warning("incorrect type replaced by 'hitmap'\n", call.=TRUE, 
            immediate.=TRUE)
    type <- "hitmap"
  }
  if(type=="lines"){
    # TODO
    cat("lines\n")
  } else if (type=="names"){
    # TODO
    cat("names\n")
  } else {
    # type=="hitmap"
    freq <- sapply(1:nrow(sommap$prototypes), function(ind){
      length(which(sommap$clustering==ind))
    })
    freq <- freq/sum(freq)
    # basesize is 0.45 for the maximum frequence
    basesize <- 0.45*sqrt(freq)/max(sqrt(freq))
    
    if (is.null(args$col)) {
      my.colors <- rep("pink", nrow(sommap$prototypes))
    } else if (length(args$col)==1) {
      my.colors <- rep(args$col, nrow(sommap$prototypes))
    } else {
      if(length(args$col)==nrow(sommap$prototypes)){
        my.colors <- args$col
      } else {
        warning("unadequate number of colors default color will be used\n", 
                immediate.=TRUE, call.=TRUE)
        my.colors <- rep("pink", nrow(sommap$prototypes))
      }
    }
    plot.args <- c(list(x=sommap$parameters$the.grid), args)
    do.call("plot.myGrid",plot.args)
    invisible(sapply(1:nrow(sommap$prototypes), function(ind){
      xleft <- (sommap$parameters$the.grid$coord[ind,1]-basesize[ind])
      xright <- (sommap$parameters$the.grid$coord[ind,1]+basesize[ind])
      ybottom <- (sommap$parameters$the.grid$coord[ind,2]-basesize[ind])
      ytop <- (sommap$parameters$the.grid$coord[ind,2]+basesize[ind])
      rect(xleft,ybottom,xright,ytop, col=my.colors[ind], border=NA)
    }))
  }
}

plot.energy <- function(sommap, args) {
  # possible only if some intermediate backups have been done
  if (is.null(sommap$backup)) {
    stop("no intermediate backups have been registered\n", call.=TRUE)
  } else {
    if (is.null(args$main))
      args$main <- "Energy evolution"
    if (is.null(args$ylab)) args$ylab <- "Energy"
    if (is.null(args$xlab)) args$xlab <- "Steps"
    if (is.null(args$type)) args$type <- "b"
    if (is.null(args$pch)) args$pch <- "+"
    
    plot.args <- c(list(x=sommap$backup$steps,
                        y=sommap$backup$energy),
                   args)
    do.call("plot",plot.args)
  }
}

plot.add <- function(sommap, type, args) {
  ## types : pie, color, 3d
  # default value for type="pie"
  if(!is.element(type,c("pie", "color", "3d"))) {
    warning("incorrect type replaced by 'pie'\n", call.=TRUE, 
            immediate.=TRUE)
    type <- "pie"
  }
  if(type=="pie"){
    # 'add' : the factor
    fact <- as.factor(args$add)
    # TODO
  } else if(type=="color"){
    # TODO
  } else {
    # type=="3d"
  }
}

plot.somRes <- function(x, what=c("obs", "prototypes", "energy", "add"), 
                        type=switch(what,
                                    "obs"="hitmap",
                                    "prototypes"="color",
                                    "add"="pie",
                                    "energy"=NULL),
                        var = 1, palette=NULL,
                        ...) {
  args <- list(...)
  match.arg(what, c("prototypes", "energy", "add", "obs"))
  
  switch(what,
         "prototypes"=plot.prototypes(x, type, var, palette=palette, args),
         "energy"=plot.energy(x, args),
         "add"=plot.add(x, type, args),
         "obs"=plot.obs(x, type, args))
}