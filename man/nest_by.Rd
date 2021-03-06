% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/nest_by.R
\name{nest_by}
\alias{nest_by}
\title{Nest by one or more variables}
\usage{
nest_by(.data, ..., .key = "data", .keep = FALSE, .add = FALSE)
}
\arguments{
\item{.data}{A data frame, data frame extension (e.g. a tibble), or a
lazy data frame (e.g. from dbplyr or dtplyr). See \emph{Methods}, below, for
more details.}

\item{...}{In \code{group_by()}, variables or computations to group by.
In \code{ungroup()}, variables to remove from the grouping.}

\item{.key}{Name of the list column}

\item{.keep}{Should the grouping columns be kept in the list column.}

\item{.add}{When \code{FALSE}, the default, \code{group_by()} will
override existing groups. To add to the existing groups, use
\code{.add = TRUE}.

This argument was previously called \code{add}, but that prevented
creating a new grouping variable called \code{add}, and conflicts with
our naming conventions.}
}
\value{
A \code{\link[=rowwise]{rowwise()}} data frame. The output has the following properties:
\itemize{
\item The rows come from the underlying \code{\link[=group_keys]{group_keys()}}.
\item The columns are the grouping keys plus one list-column of data frames.
\item Data frame attributes are \strong{not} preserved, because \code{nest_by()}
fundamentally creates a new data frame.
}

A tbl with one row per unique combination of the grouping variables.
The first columns are the grouping variables, followed by a list column of tibbles
with matching rows of the remaining columns.
}
\description{
\Sexpr[results=rd, stage=render]{lifecycle::badge("experimental")}

\code{nest_by()} is closely related to \code{\link[=group_by]{group_by()}}. However, instead of storing
the group structure in the metadata, it makes it explicit in the data,
giving each group key a single row with a list-column of data frames that
contain all the other data.
}
\section{Methods}{

This function is a \strong{generic}, which means that packages can provide
implementations (methods) for other classes. See the documentation of
individual methods for extra arguments and differences in behaviour.

The following methods are currently available in loaded packages:
\Sexpr[stage=render,results=rd]{dplyr:::methods_rd("nest_by")}.
}

\examples{
# After nesting, you get one row per group
iris \%>\% nest_by(Species)
starwars \%>\% nest_by(species)

# The output is grouped by row, which makes modelling particularly easy
models <- mtcars \%>\%
  nest_by(cyl) \%>\%
  mutate(model = list(lm(mpg ~ wt, data = data)))
models

models \%>\% summarise(rsq = summary(model)$r.squared)
}
\keyword{internal}
