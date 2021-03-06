% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/create.R
\name{create_match}
\alias{create_match}
\title{Matched two-mode graph}
\usage{
create_match(n1, n2, as = c("tbl_graph", "igraph", "matrix"))
}
\arguments{
\item{n1}{Number of nodes in the first node set}

\item{n2}{Number of nodes in the second node set}

\item{as}{What type of object to return.}
}
\description{
Creates a matched two-mode network
}
\details{
Will construct an affiliation matrix,
with by default both n1 and n2 matched.
TODO: Incorporate into create_chain (chordal_ring of certain breadth w).
}
\examples{
\dontrun{
create_match(10, 12)
}
}
