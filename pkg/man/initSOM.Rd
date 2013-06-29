\name{initSOM}
\alias{initSOM}
\alias{print.paramSOM}
\alias{summary.paramSOM}

\title{
Initialize parameters for the SOM algorithm
}
\description{
The \code{initSOM} function returns a \code{paramSOM} class object which
contains the parameters needed to run the SOM algorithm.
}
\usage{
initSOM(dimension=c(5,5), topo=c("square"),
                    dist.type=c("maximum","euclidean","manhattan","canberra",
                                "binary","minkowski"),
                    type=c("numeric", "relational", "korresp"), 
                    mode=c("online"), 
                    maxit=500, nb.save=0, verbose=FALSE, proto0=NULL, 
                    init.proto=c("random","obs"), 
                    scaling=c("unitvar","none","center", "chi2"), 
                    radius.type=c("letremy"))
\method{print}{paramSOM}(x, \ldots)
\method{summary}{paramSOM}(object, \ldots)
}
\arguments{
  \item{dimension}{Vector of two integer points corresponding to the x 
  dimension and the y dimension of the \code{myGrid} class object. Default 
  values are: \code{(5,5)}.}
  \item{topo}{The topology to be used to build the grid of the \code{myGrid} 
  class object. Default value is \code{square}.}
  \item{dist.type}{The neighborhood relationship on the grid. The possible
  values are those of the option \code{method} of the function
  \code{\link[stats]{dist}}. Default value is \code{maximum}.}
  \item{type}{The SOM algorithm type. Default value is \code{numeric}.}
  \item{mode}{The SOM algorithm mode. Default value is \code{online}.}
  \item{maxit}{The maximum number of iterations to be done during the SOM 
  algorithm process. Default value is \code{500}.}
  \item{nb.save}{The number of intermediate back-ups to be done during the 
  algorithm process. Default value is \code{0}.}
  \item{verbose}{The boolean value which control the printing during the SOM 
  algorithm process. Default value is \code{FALSE}.}
  \item{proto0}{The initial prototypes. Default value is \code{NULL}.}
  \item{init.proto}{The method to be used to initialize the prototypes, either 
  randomization or an observation sample. This 
  argument is only considered when \code{proto0=NULL}. Default value is 
  \code{random}.}
  \item{scaling}{The type of data pre-processing. For numeric SOM, 
  possibilities are \code{unitvar} (which is the default value), \code{none} 
  and \code{center}. For korresp SOM, pre-processing must be \code{chi2}.}
  \item{radius.type}{The neighbourhood type. Default value is \code{letremy}.}



  \item{x, object}{an object of class \code{paramSOM}.}
  \item{\ldots}{not used}
}
\value{
The \code{initSOM} function returns an object of class \code{paramSOM} which is
a list of the parameters passed to the \code{initSOM} function, plus the default
parameters for whose which were not set by the user.
}
\author{Laura Bendhaiba \email{laurabendhaiba@gmail.com}\cr
Madalina Olteanu \email{madalina.olteanu@univ-paris1.fr}\cr
Nathalie Villa-Vialaneix \email{nathalie.villa@univ-paris1.fr}
}
\seealso{
See \link{initGrid} for creating a SOM prior structure (grid).
}
\examples{
# create a default 'paramSOM' class object
default.paramSOM <- initSOM()
summary(default.paramSOM)
}
\keyword{classes}
