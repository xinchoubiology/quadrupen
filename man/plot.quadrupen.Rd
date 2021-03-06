\docType{methods}
\name{plot,quadrupen-method}
\alias{plot,quadrupen-method}
\title{Plot method for a quadrupen object}
\usage{
\\S4method{plot}{quadrupen}(x, y, xvar = "lambda",
        main = paste(slot(x, "penalty")," path", sep=""),
        log.scale = TRUE, standardize=TRUE, reverse=FALSE,
        labels = NULL, plot = TRUE, ...)
}
\arguments{
  \item{x}{output of a fitting procedure of the
  \pkg{quadrupen} package (\code{\link{elastic.net}} or
  \code{\link{bounded.reg}} for the moment). Must be of
  class \code{quadrupen}.}

  \item{y}{used for S4 compatibility.}

  \item{xvar}{variable to plot on the X-axis: either
  \code{"lambda"} (\eqn{\lambda_1}{lambda1} penalty level)
  or \code{"fraction"} (\eqn{\ell_1}{l1}-norm of the
  coefficients). Default is set to \code{"lambda"}.}

  \item{main}{the main title. Default is set to the model
  name followed by what is on the Y-axis.}

  \item{log.scale}{logical; indicates if a log-scale should
  be used when \code{xvar="lambda"}. Default is
  \code{TRUE}.}

  \item{standardize}{logical; standardize the coefficients
  before plotting (with the norm of the predictor). Default
  is \code{TRUE}.}

  \item{reverse}{logical; should the X-axis be reversed
  when \code{xvar="lambda"}? Default is \code{FALSE}.}

  \item{labels}{vector indicating the names associated to
  the plotted variables. When specified, a legend is drawn
  in order to identify each variable. Only relevant when
  the number of predictor is small. Remind that the
  intercept does not count. Default is \code{NULL}.}

  \item{plot}{logical; indicates if the graph should be
  plotted on call. Default is \code{TRUE}.}

  \item{...}{Arguments to be passed to methods, such as
  \link{graphical parameters} (see \code{\link{par}}).
  Many methods will accept the following arguments:
  \describe{ \item{\code{type}}{what type of plot should be
  drawn.  Possible types are \itemize{ \item \code{"p"} for
  \bold{p}oints, \item \code{"l"} for \bold{l}ines, \item
  \code{"b"} for \bold{b}oth, \item \code{"c"} for the
  lines part alone of \code{"b"}, \item \code{"o"} for both
  \sQuote{\bold{o}verplotted}, \item \code{"h"} for
  \sQuote{\bold{h}istogram} like (or \sQuote{high-density})
  vertical lines, \item \code{"s"} for stair \bold{s}teps,
  \item \code{"S"} for other \bold{s}teps, see
  \sQuote{Details} below, \item \code{"n"} for no plotting.
  } All other \code{type}s give a warning or an error;
  using, e.g., \code{type = "punkte"} being equivalent to
  \code{type = "p"} for S compatibility.  Note that some
  methods, e.g. \code{\link{plot.factor}}, do not accept
  this.  } \item{\code{main}}{an overall title for the
  plot: see \code{\link{title}}.} \item{\code{sub}}{a sub
  title for the plot: see \code{\link{title}}.}
  \item{\code{xlab}}{a title for the x axis: see
  \code{\link{title}}.} \item{\code{ylab}}{a title for the
  y axis: see \code{\link{title}}.} \item{\code{asp}}{the
  \eqn{y/x} aspect ratio, see \code{\link{plot.window}}.} }
  }
}
\value{
a \pkg{ggplot2} object which can be plotted via the
\code{print} method.
}
\description{
Produce a plot of the solution path of a \code{quadrupen}
fit.
}
\examples{
\dontrun{
## Simulating multivariate Gaussian with blockwise correlation
## and piecewise constant vector of parameters
beta <- rep(c(0,1,0,-1,0), c(25,10,25,10,25))
cor <- 0.75
Soo <- toeplitz(cor^(0:(25-1))) ## Toeplitz correlation for irrelevant variables
Sww  <- matrix(cor,10,10) ## bloc correlation between active variables
Sigma <- bdiag(Soo,Sww,Soo,Sww,Soo)
diag(Sigma) <- 1
n <- 50
x <- as.matrix(matrix(rnorm(95*n),n,95) \%*\% chol(Sigma))
y <- 10 + x \%*\% beta + rnorm(n,0,10)

## Plot the Lasso path
plot(elastic.net(x,y, lambda2=0), main="Lasso solution path")
## Plot the Elastic-net path
plot(enet, main = "Elastic-net solution path")
## Plot the Elastic-net path (fraction on X-axis, unstandardized coefficient)
plot(elastic.net(x,y, lambda2=10), standardize=FALSE, xvar="fraction")
## Plot the Bounded regression path (fraction on X-axis)
plot(bounded.reg(x,y, lambda2=10), xvar="fraction")
}
}
\seealso{
\code{\linkS4class{quadrupen}}.
}

