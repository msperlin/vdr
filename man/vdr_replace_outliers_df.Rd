% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/data_manipulation_fcts.R
\name{vdr_replace_outliers_df}
\alias{vdr_replace_outliers_df}
\title{Replaces outliers in all numeric columns of a dataframe}
\usage{
vdr_replace_outliers_df(df_in, my_prob = 0.05)
}
\arguments{
\item{df_in}{The dataframe}

\item{my_prob}{Probability of quantiles (will remove quantiles at p and 1-p)}
}
\value{
A dataframe without the outliers in all numeric columns
}
\description{
Replaces outliers in all numeric columns of a dataframe
}
\examples{
x <- afedR_replace_outliers(runif(100))
}
