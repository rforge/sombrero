\name{predict.somRes}
\alias{predict.somRes}

\title{
Predict the classification of a new observation
}

\description{Predict the neuron where a new observation is classified}

\usage{
\method{predict}{somRes}(object, x.new, ...)
}

\arguments{
\item{object}{a \code{somRes} object}
\item{x.new}{the new observation}
\item{...}{not used}
}

\details{The length of the new observation must match the number of colums of 
the data set given to the SOM algorithm (see \code{\link{trainSOM}}).}

\value{\code{predict.somRes} returns the number of the neuron to which the new 
observation is assigned (i.e., neuron with the closest prototype.}

\author{Laura Bendhaiba \email{laurabendhaiba@gmail.com}\cr
Madalina Olteanu \email{madalina.olteanu@univ-paris1.fr}\cr
Nathalie Villa-Vialaneix \email{nathalie.villa@univ-paris1.fr}
}

\seealso{\code{\link{trainSOM}}}

\examples{
set.seed(2343)
my.som <- trainSOM(x.data=iris[,1:4], dimension=c(5,5))
# in the final classification the first observation is assigned to...
my.som$clustering[1]
# try predict on this observation
predict(my.som, iris[1,1:4])
}

\keyword{cluster}