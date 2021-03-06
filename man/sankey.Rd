% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/sankey.R
\name{sankey}
\alias{sankey}
\title{Plots a Sankey diagram}
\usage{
sankey(
  nodes,
  flows,
  palette,
  node_style = list(),
  title = NULL,
  legend = FALSE,
  page_margin = 0.1,
  max_width = 0.2,
  rmin = 0.2,
  copyright = NULL,
  grill = NULL,
  verbose = FALSE
)
}
\arguments{
\item{nodes}{data.frame, containing the nodes definition}

\item{flows}{data.frame, containing the nodes definition}

\item{palette}{data.frame, containing the nodes definition}

\item{node_style}{list: containing node style specifiers:
\describe{
\item{type}{Character: Node type; possible values are \code{"box"}, \code{"bar"} and \code{"arrow"}.}
\item{length}{numeric: node length, as fraction plot size (default: 0.1).}
\item{gp}{an object of class \code{gpar}, typically the output from a call to
the function \code{gpar()}.
This is basically a list of graphical parameter settings,
describing the colors etc of the node.}
\item{label_pos}{character: label position. values: auto, above, below, left, right, none.}
\item{label_anchor}{character: label position (overrides \code{label_pos}). Values are NW, N, NE, W, E, SW, S, SE.}
\item{label_align}{character: label alignment with respect to \code{label_anchor}. Values are NW, N, etc.}
\item{label_gp}{an object of class \code{gpar}, describing the font and color of the label text.}
\item{mag_pos}{similar to \code{label_pos}, but controls location of the node magnitude.
Value \code{inside} plots the node magnitude inside the node.
Value \code{label} plots the node magnitude beneath the node label.}
\item{mag_anchor}{similar to \code{label_anchor}.}
\item{mag_align}{similar to \code{label_align}.}
\item{mag_gp}{similar to \code{label_gp}.}
\item{mag_fmt}{character: format string for the node magnitude. default: \code{"\%.1f"}.
see \code{?sprintf} for more information.}
}}

\item{title}{character: plot title. use \code{strformat()} to specify formatting.}

\item{legend}{logical or gpar: Specifies the plotting of a legend.
valid values are NULL (default; no legend),
TRUE (plot a legend using standard text size and color),
or the output of a call to gpar(), to control legend text size and color.}

\item{page_margin}{numeric: Page margin. Either a scalar, an (x,y) vector or an (left,bot,rt,top) vector}

\item{max_width}{numeric: Maximum width of the flow bundles, in fraction of the plot size}

\item{rmin}{numeric: Minimum radius for flow path bends (as fraction of the diagram's units)}

\item{copyright}{character: optional copyright statement?}

\item{grill}{logical: Plot a coordinate grill?}

\item{verbose}{logical: print some diagnostic messages?}
}
\value{
The modified nodes data.frame
}
\description{
Plots a Sankey diagram
}
\examples{
nodes <- data.frame(ID=c("A","B"), x=1:2, y=0)
flows <- data.frame(from="A", to="B", quantity=10, substance="stuff")
sankey(nodes, flows)

colors <- data.frame(substance="stuff", color="blue")
sankey(nodes, flows, colors)

sankey(nodes, flows, legend=TRUE)                       # Plots default legend
sankey(nodes, flows, legend=grid::gpar(fontsize=18, ncols=2)) # Large fonts; 2 columns
}
