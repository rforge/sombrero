\name{SOMbrero}
\alias{SOMbrero}

\docType{package}
\title{
Self Organizing Maps Bound to Realize Euclidean and Relational Outputs
}
\description{
This package implements the stochastic (also called on-line) Self-Organising Map 
(SOM) algorithm for numeric and relational data.

It is based on a grid (see \code{\link{initGrid}}) which is part of the 
parameters given to the algorithm (see \code{\link{initSOM}} and 
\code{\link{trainSOM}}). Many graphs can help you with the results (see 
\code{\link{plot.somRes}}).
}
\details{
\tabular{ll}{
Package: \tab SOMbrero\cr
Type: \tab Package\cr
Version: \tab 0.3\cr
Date: \tab 2013-06-14\cr
License: GPL-2\cr
URL: \tab SOMbrero \url{http://www.nathalievilla.org/spip.php?article90} \cr
}
The version of the SOM algorithm implemented in this package is the stochastic
version.

Several variants able to handle non-vectorial data are also implemented in their
stochastic versions: \code{type="korresp"} for contingency tables, as described
in Cottrel et al., 1993.
}

\author{Laura Bendhaiba \email{laurabendhaiba@gmail.com}

Madalina Olteanu \email{madalina.olteanu@univ-paris1.fr}

Nathalie Villa-Vialaneix \email{nathalie.villa@univ-paris1.fr}

Maintainer: Nathalie Villa-Vialaneix \email{nathalie.villa@univ-paris1.fr}
}
\references{
Teuvo Kohonen (2001) Self-Organizing Maps. Springer-Verlag, Berlin and 
Heidelberg, 3rd edition.

Marie Cottrell, Patrick Letremy and Elisabeth Roy (1993) Analyzing a contingency
table with Kohonen maps: a Factorial Correspondence Analysis. In: Proceedings of
IWANN'93, J. Cabestany, J. Mary, A. Prieto (Eds.), Lecture Notes in Computer
Science, Springer-Verlag, 305-311.
}
\seealso{
\code{\link{initGrid}}, \code{\link{trainSOM}} and \code{\link{plot.somRes}}.
}
