% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/stat.lm.R
\name{stat.lm}
\alias{stat.lm}
\title{Extracts statistical measures of interest in Linear Model}
\usage{
stat.lm(ant, formula, oda, progress = TRUE, method = "qr",
  model = TRUE, x = FALSE, y = FALSE, qr = TRUE,
  singular.ok = TRUE, contrasts = NULL, ...)
}
\arguments{
\item{ant}{an output of ANT function \code{perm.net.nl} without any random factor declared, or output of ANT 'met' categories functions in which output of ANT functions \code{perm.ds.focal}, \code{perm.ds.grp} or \code{perm.net.lk} where single matrices were used.}

\item{formula}{an object of class "formula" (or one that can be coerced to that class): a symbolic description of the model to be fitted. The details of model specification are given under ‘Details’.}

\item{oda}{the original data frame of associations when argument ant is obtained with perm.ds.grp or perm.ds.focal ANT functions.}

\item{progress}{a boolean indicating the visualization of the permutation process.}

\item{method}{the method to be used; for fitting, currently only method = "qr" is supported; method = "model.frame" returns the model frame (the same as with model = TRUE, see below).}

\item{model}{logicals. If TRUE the corresponding components of the fit (the model frame, the model matrix, the response, the QR decomposition) are returned.}

\item{x}{logicals. If TRUE the corresponding components of the fit (the model frame, the model matrix, the response, the QR decomposition) are returned.}

\item{y}{logicals. If TRUE the corresponding components of the fit (the model frame, the model matrix, the response, the QR decomposition) are returned.}

\item{qr}{logicals. If TRUE the corresponding components of the fit (the model frame, the model matrix, the response, the QR decomposition) are returned.}

\item{singular.ok}{logical. If FALSE (the default in S but not in R) a singular fit is an error.}

\item{contrasts}{an optional list. See the contrasts.arg of model.matrix.default.}

\item{...}{Extra arguments for \code{\link{lm}} function only.}
}
\value{
Returns a list of 3 elements :
\itemize{
\item An object of class "lm" or for multiple responses of class c("mlm", "lm").
\item A data frame if the estimates of the permuted models.
\item A vector of integers indicating the permutations that returned model errors or warnings (e.g. model convergence issues) and for which new permutations were done.
}
}
\description{
Performs correlations Generalized Linear Models tests and extracts estimates of predictor factors in each permuted model.
}
\details{
This function is the first step for performing t-tests in permuted data. For more details on t-tests, see R documentation.
}
\examples{
t=met.strength(sim.m,sim.df,1) # Computing network metric
t=perm.net.nl(t,labels='age',rf=NULL,nperm=10,progress=FALSE) # Node label permutations
r.lm=stat.lm(t,formula = strength ~ sex,progress=FALSE) # Permuted LM
}
\references{
Chambers, J. M. (1992) Linear models. Chapter 4 of Statistical Models in S eds J. M. Chambers and T. J. Hastie, Wadsworth & Brooks/Cole.

Wilkinson, G. N. and Rogers, C. E. (1973) Symbolic descriptions of factorial models for analysis of variance. Applied Statistics, 22, 392–9.
}
\seealso{
\code{\link{lm}}
}
\author{
Sebastian Sosa, Ivan Puga-Gonzalez.
}
