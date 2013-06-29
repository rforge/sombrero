\name{projectGraph}
\alias{projectGraph}

\title{Create a projected graph.}

\description{Create the object needed in the case (\code{what="add"}, 
\code{type="graph"}) of the function \code{plot.somres}.}

\usage{projectGraph(the.graph,clustering,the.grid)}

\arguments{
  \item{the.graph}{An \code{igraph} object.}
  \item{clustering}{A classification (i.e. the final classification of the SOM 
  algorithm).}
  \item{the.grid}{The grid used in the SOM algorithm.}
}

\value{Returns an \code{igraph} object.}

\author{Laura Bendhaiba \email{laurabendhaiba@gmail.com}\cr
Madalina Olteanu \email{madalina.olteanu@univ-paris1.fr}\cr
Nathalie Villa-Vialaneix \email{nathalie.villa@univ-paris1.fr}
}

\seealso{
For more on \code{igraph}, see \code{\link{igraph}}.
For more on \code{plot.somRes}, see \code{\link{plot.somRes}}.
}
\examples{
## needed elements
my.som <- trainSOM(x.data=iris[,1:4], dimension=c(5,5), nb.save=2)
the.graph <- graph.ring(150)
clustering <- my.som$clustering
the.grid <- my.som$parameters$the.grid

## create the projected graph
proj.graph <- projectGraph(the.graph,clustering,the.grid)

## display the projected graph
plot(proj.graph)
}

\keyword{aplot} % not sure
