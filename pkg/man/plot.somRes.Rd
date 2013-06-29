\name{plot.somRes}
\alias{plot.somRes}

\title{
Draw a \code{somRes} class object
}
\description{
Produce graphics out of a \code{somRes}.
}
\usage{
\method{plot}{somRes}(x, what=c("obs", "prototypes", "energy", "add"), 
type=switch(what, "obs"="hitmap", "prototypes"="color", "add"="pie", 
"energy"=NULL), var = 1, palette=NULL, \dots)
}

\arguments{
  \item{x}{A \code{somRes} class object.}
  \item{what}{What you want to plot. Either the observations (\code{obs}), the 
  evolution of energy (\code{energy}), the prototypes (\code{prototypes}) or an 
  additional variable (\code{add}).}
  \item{type}{Further argument indicating which type of chart you want to have.
  Choices depend on the value of \code{what} (\code{what="energy"} has no
  \code{type} argument). Default values are \code{"hitmap"} for \code{obs}, 
  \code{"color"} for \code{prototypes} and \code{"pie"} for \code{add}. See
  section ``Details'' below for further details.}
  \item{var}{The index or the name of the variable to be considered for 
  \code{type="color"}. Default value is 1 (i.e., the first variable of the
  input data is displayed).}
  \item{palette}{A vector of colors to be used when \code{type="color"}. If no
  value for \code{palette} is passed to the function, it uses a vector of color
  based on the \code{heat.colors} palette and a number of colors adjusted to the
  size of the map, smaller than 9.}
  \item{\dots}{Further arguments to be passed to the \code{\link{plot}}
  function.}
}

\details{
For \code{what="obs"}, possible values for \code{type} are 
\code{"hitmap"} (proportional areas according to the number of observation per 
neuron), \code{"lines"} or \code{"names"}.

\code{what="energy"} is only available if some intermediate backups
have been registered (i.e., \code{x$parameters$nb.save>1}). Graphic plots the 
evolution of the level of the energy according to the registered steps.

For \code{what="prototypes"}, possible values for \code{"type"} are \code{"3d"}, 
\code{"lines"}, \code{"barplot"}, \code{"radar"} or \code{"color"}. 
\code{"color"} can have two more arguments, \code{var}, the index (or the name)
of the  variable to be considered (default, \code{1}), and \code{palette}
(default,  \code{heat.colors}) for the colors to be used. Neurons are filled
using the given palette according to the value level of the chosen variable.

For \code{what="add"}, possible values for \code{"type"} are \code{"pie"}, 
\code{"color"} or \code{"3d"}.
}

\author{Laura Bendhaiba <laurabendhaiba@gmail.com>

Madalina Olteanu <madalina.olteanu@univ-paris1.fr>

Nathalie Villa-Vialaneix <nathalie.villa@univ-paris1.fr>
}

\seealso{
\code{\link{trainSOM}} to run the SOM algorithm, that returns a \code{somRes} 
class object.
}
\examples{
# generate data in [0,1]x[0,1]
the.data <- data.frame("x1"=runif(500), "x2"=runif(500))
# run the SOM algorithm
my.som <- trainSOM(x.data=the.data, dimension=c(5,5), nb.save=10, maxit=2000)

# plots
# plot prototypes in color according to the value of the 1st variable
plot(my.som, what="prototypes", type="color", var=1, palette=terrain.colors(6))
# plot the evolution of the energy
plot(my.som, what="energy", col="red", pch=19)
# plot the hitmap of the observations
plot(my.som, what="obs", type="hitmap", main="hitmap")
}

\keyword{aplot}