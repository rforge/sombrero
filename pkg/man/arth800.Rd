\name{arth800}
\alias{arth800.expr}
\alias{arth800.graph}
\alias{arth800}
\docType{data}

\title{Time Series Expression Data for 800 Arabidopsis Thaliana Genes}

\description{A public dataset from the package ```GeneNet```.}

\usage{
data(arth800)
}

\format{
  \code{arth800.expr} is a \code{\link[longitudinal]{longitudinal}} 
  object with repetitions, and contains the log2 transformed expression data. 

  \code{arth800.graph} is an \code{\link[igraph]{igraph}} object obtained from
  the expression data using the ```GeneNet``` package (with the functions
  \code{\link[GeneNet]{ggm.estimate.pcor}} and 
  \code{\link[GeneNet]{ggm.test.edges}})
}

\source{
  The micoarray experiments were performed in the laboratory of S. Smith
  (Edinburgh).The data are available from the NASCArrays database
  (\url{http://affymetrix.arabidopsis.info/} under experiment reference number
  NASCARRAYS-60.
}

\references{
Smith et al. 2004. Diurnal changes in the transcriptom encoding enzymes of
starch metabolism provide evidence for both transcriptional and
posttranscriptional regulation of starch metabolism in Arabidopsis leaves.
Plant Physiol., 136: 2687-2699.

Sch\"afer, J., and Strimmer, K. (2005).  A shrinkage approach to large-scale
covariance estimation and implications for functional genomics. 
Statist Appl Genet Mol Biol., \bold{4}:32.
(\url{http://www.bepress.com/sagmb/vol4/iss1/art32/})
}

\seealso{
\code{\link[GeneNet]{arth800}} in the package ```GeneNet```.
}

\examples{
data(arth800)
# print arth800.expr
head(arth800.expr)
# plot arth800.graph
set.seed(1148)
plot(arth800.graph)
}

\keyword{datasets}
