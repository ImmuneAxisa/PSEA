% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/psea.R
\name{psea}
\alias{psea}
\title{Peak-Set Enrichment Analysis (PSEA)}
\usage{
psea(gr, rank_col, gr_set, ...)
}
\arguments{
\item{gr}{genomic ranges object with a peak ranking metric in meta data columns to use for enrichment}

\item{rank_col}{column to use in \code{gr} metadata for ranking}

\item{gr_set}{a genomic range object listing which range belong to which peak sets in column called "term"}

\item{...}{passed to \code{plyranges::join_overlap_left}}
}
\value{
\code{gseResults} object
}
\description{
Peak-Set Enrichment Analysis (PSEA)
}
\examples{


library(plyranges)
library(dplyr)

gr <- data.frame(
  seqnames = "chr1",
  start = seq(0,9999,100),
  width = 30,
  ranking_metric = -50:49
) \%>\%
  as_granges()

gr_set <- shift_right(gr, rep_len(c(20,50),100)) \%>\%
  mutate(term = "peakSet1")

psea(gr, ranking_metric, gr_set)



}
