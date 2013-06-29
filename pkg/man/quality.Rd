\name{quality}
\alias{quality}

\title{Compute SOM algorithm quality criteria}
\description{The \code{quality} function computes several quality criteria for
the result of a SOM algorithm.}
\usage{
quality(sommap, quality.type=c("all", "quantization", "topographic"))
}

\arguments{
  \item{sommap}{A \code{somRes} object (see \code{\link{trainSOM}} for 
  details).}
  \item{quality.type}{The quality type to compute. Two types are implemented: 
  \code{quantization} and \code{topographic}. The output of the function is
  one those or both of them using the option \code{"all"}. Default value is the
  latter.}
}

\value{The \code{quality} function returns either a numeric value (if only one 
type is computed) or a list a numeric values (if all types are computed)

The quantization error calculates the mean distance between the sample vectors
and their respective cluster prototypes. It is a decreasing function of the size
of the map.

The topographic error is the simplest of the topology preservation measure: it
calculates the ratio of sample vectors for which the second best matching unit
is in the direct neighborhood of the best matching unit.
}

\author{Laura Bendhaiba \email{laurabendhaiba@gmail.com}\cr
Madalina Olteanu \email{madalina.olteanu@univ-paris1.fr}\cr
Nathalie Villa-Vialaneix \email{nathalie.villa@univ-paris1.fr}
}

\references{
Georg Polzlbauer (2004) Survey and comparison of quality measures for
self-organizing maps. In Jan Paralic, Georg Polzlbauer, and Andreas Rauber
(eds), Proceedings of the Fifth Workshop on Data Analysis (WDA'04), pages 67-82.
Sliezsky dom, Vysoke Tatry, Slovakia, June 24-27 2004. Elfa Academic Press.
}

\seealso{\code{\link{trainSOM}}, \code{\link{plot.somRes}}}

\examples{
my.som <- trainSOM(x.data=iris[,1:4])
quality(my.som, quality.type="all")
quality(my.som, quality.type="topographic")
}
\keyword{cluster}