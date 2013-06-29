\name{trainSOM}
\alias{trainSOM}
\alias{summary.somRes}
\alias{print.somRes}

\title{
Run the SOM algorithm
}
\description{
The \code{trainSOM} function returns a \code{somRes} class object which 
contains the outputs of the algorithm.
}
\usage{
trainSOM(x.data,
         dimension=c(max(5,min(10,ceiling(sqrt(nrow(x.data)/10)))), 
                     max(5,min(10,ceiling(sqrt(nrow(x.data)/10))))),
         maxit=round(nrow(x.data)*5), ...)
\method{print}{somRes}(x, \ldots)
\method{summary}{somRes}(object, \ldots)
}

\arguments{
  \item{x.data}{a data frame or matrix containing the observations to be mapped 
  on the grid by SOM algorithm.}
  \item{dimension}{a vector with two dimensions specifying the number of rows
  and columns of the grid.}
  \item{maxit}{the number of iterations of the algorithm.}
  \item{...}{Further arguments to be passed to the function
  \code{\link{initSOM}} for specifying the parameters of the algorithm.}
  \item{x, object}{an object of class \code{somRes}}
}
\value{
The \code{trainSOM} function returns an object of class \code{somRes} which 
contains the following components:
\item{clustering}{the final classification of the data.}
\item{prototypes}{the final coordinates of the prototypes.}
\item{energy}{the final energy of the map.}
\item{backup}{a list containing some intermediate backups of the prototypes 
coordinates, clustering, energy and the indexes of the recorded backups, if
\code{nb.save} is set to a value larger than 1.}
\item{data}{the original dataset used to train the algorithm.}
\item{parameters}{a list of the map's parameters, which is an object of class
\code{paramSOM} as produced by the function \code{\link{initSOM}}.}
The function \code{summary.somRes} also provides an ANOVA (ANalysis Of VAriance)
of each input numeric variables in function of the map's clusters. This is 
helpful to see which variables participate to the clustering.
}
\references{
Teuvo Kohonen (2001) Self-Organizing Maps. Springer-Verlag, Berlin and 
Heidelberg, 3rd edition.
}
\author{Laura Bendhaiba \email{laurabendhaiba@gmail.com}\cr
Madalina Olteanu \email{madalina.olteanu@univ-paris1.fr}\cr
Nathalie Villa-Vialaneix \email{nathalie.villa@univ-paris1.fr}
}
\note{Warning! Recording intermediate backups with the argument \code{nb.save}
can strongly increase the computational time since calculating the entire
clustering and the energy is time consumming. Use this option with care and only
when it is strictly necessary.}
\seealso{
See \link{plot.somRes} to plot the outputs of the algorithm.
}
\examples{
# Run trainSOM algorithm on the iris data with 500 iterations
iris.som <- trainSOM(x.data=iris[,1:4])
iris.som
summary(iris.som)
}
\keyword{methods}
