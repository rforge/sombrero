\name{initGrid}
\alias{initGrid}
\alias{print.myGrid}
\alias{summary.myGrid}

\title{
Create an empty Self-Organizing Map structure
}
\description{
Create an empty Self-Organizing Map structure which is a list of 2-dimensional
points.
}
\usage{
initGrid(dimension=c(5,5), topo=c("square"))
\method{print}{myGrid}(x, \ldots)
\method{summary}{myGrid}(object, \ldots)
}
\arguments{
  \item{dimension}{Vector of two integer points corresponding to the x 
  dimension and the y dimension. Default values are: \code{(5,5)}.}
  \item{topo}{The topology to be used to build the grid. Default value is 
  \code{square}.}
  \item{x, object}{an object of class \code{myGrid}}
  \item{\ldots}{not used}
}
\value{
\code{initGrid} function returns an object of class \code{myGrid}, including 
the following components:
\item{coord}{A two columns matrix which provides the coordinates of the points 
of the Self-Organizing Map structure,}
\item{topo}{Same value as the arguments given to \code{initGrid} function,}
\item{dim}{Same values as the arguments given to \code{initGrid} function.}
}
\author{Laura Bendhaiba <laurabendhaiba@gmail.com>

Madalina Olteanu <madalina.olteanu@univ-paris1.fr>

Nathalie Villa-Vialaneix <nathalie.villa@univ-paris1.fr>
}
\seealso{See \code{\link{plot.myGrid}} for plotting a \code{myGrid} class object
in a graphical window.}
\examples{
# creating a default grid
# default parameters are: 5x5 dimension, squared topology
initGrid()

# creating a 5x7 squared grid
initGrid(dimension=c(5, 7), topo="square")
}
\keyword{classes}
