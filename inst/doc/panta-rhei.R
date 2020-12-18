## ---- include=FALSE-----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>",
  fig.width  = 7,
  fig.height = 5
)
options(rmarkdown.html_vignette.check_title = FALSE)

## ----setup, include=FALSE-----------------------------------------------------
rm(list=ls())
library(PantaRhei)
library(tibble) # loads: tribble()
library(grid)   # loads: gpar()

## ----echo=FALSE, fig.width=9, fig.height=7------------------------------------
data(MFA)

dblue <- "#00008B" # Dark blue

my_title <- "Material Flow Account"
attr(my_title, "gp") <- grid::gpar(fontsize=18, fontface="bold", col=dblue)

# node style
ns <- list(type="arrow",gp=gpar(fill=dblue, col="white", lwd=2),
           length=0.7,
           label_gp=gpar(col=dblue, fontsize=8),
           mag_pos="label", mag_fmt="%.0f", mag_gp=gpar(fontsize=10,fontface="bold",col=dblue))

sankey(MFA$nodes, MFA$flows, MFA$palette,
       max_width=0.1, rmin=0.5,
       node_style=ns,
       page_margin=c(0.15, 0.05, 0.1, 0.1),
       legend=TRUE, title=my_title,
       copyright="Statistics Netherlands")

## -----------------------------------------------------------------------------
nodes <- data.frame(
  ID =c("A", "B"),
  x  = c(1, 2),
  y  = c(0, 0)
)

## ----echo=FALSE, results='asis'-----------------------------------------------
knitr::kable(nodes)

## -----------------------------------------------------------------------------
flows <- data.frame(
  from      = "A",
  to        = "B",
  quantity  = 10.0
)

## ----echo=FALSE, results='asis'-----------------------------------------------
knitr::kable(flows)

## ---- message=FALSE-----------------------------------------------------------
sankey(nodes, flows)

## -----------------------------------------------------------------------------
nodes <- tribble(
  ~ID,    ~label,          ~x, ~y, ~label_pos,
  "imp",  "Import",         1,  2, "left",
  "exp",  "Export",         5,  2, "right",
  "dom",  "Domestic use",   5,  1, "above",
  "proc", "Processing",     3,  1, "below"
)

## ----echo=FALSE, results='asis'-----------------------------------------------
knitr::kable(nodes)

## -----------------------------------------------------------------------------
flows <- tribble(
  ~from,  ~to,   ~substance, ~quantity,
  "imp",  "exp", "Cocoa",     10,
  "imp",  "proc", "",          5,
  "proc", "dom",  "",          2,
  "proc", "exp",  "",          3,
  "imp",  "exp",  "Sugar",     2,
  "imp",  "proc", "",          6,
  "proc", "dom",  "",          5,
  "proc", "exp",  "",          1
)

## ----echo=FALSE, results='asis'-----------------------------------------------
knitr::kable(flows)

## -----------------------------------------------------------------------------
sankey(nodes,flows, legend=TRUE)

## -----------------------------------------------------------------------------
colors <- tribble(
  ~substance, ~color,
  "Cocoa",    "chocolate",
  "Sugar",    "#FFE4C4"
)

## ----echo=FALSE, results='asis'-----------------------------------------------
knitr::kable(colors)

## -----------------------------------------------------------------------------
sankey(nodes, flows, colors, legend=TRUE)

## -----------------------------------------------------------------------------
nodes <- tribble(
  ~ID,    ~label,          ~x, ~y, ~label_pos,
  "imp",  "Import",         "1",   2,   "left",
  "exp",  "Export",         "5",   2,   "right",
  "dom",  "Domestic use",   "exp", 1,  "above",
  "proc", "Processing",     "3",   1,   "below"
)
sankey(nodes, flows, colors, legend=TRUE)

## -----------------------------------------------------------------------------
nodes <- tribble(
  ~ID,    ~label,          ~x, ~y, ~label_pos,
  "imp",  "Import",         "1",   "2",    "left",
  "exp",  "Export",         "5",   "imp",  "right",
  "dom",  "Domestic use",   "exp", "proc", "above",
  "proc", "Processing",     "3",   "1",    "below"
)
sankey(nodes, flows, colors, legend=TRUE)

## -----------------------------------------------------------------------------
nodes <- tribble(
  ~ID,    ~label,          ~x, ~y, ~label_pos,
  "imp",  "Import",         "0",       "0",    "left",
  "exp",  "Export",         "proc+2", "imp",   "right",
  "dom",  "Domestic use",   "exp",     "proc", "above",
  "proc", "Processing",     "imp+2",   "imp-1", "below"
)
sankey(nodes, flows, colors, legend=TRUE)

## -----------------------------------------------------------------------------
sankey(nodes, flows, colors, node_style=list(type="arrow"), legend=TRUE)

## -----------------------------------------------------------------------------
library(grid) # loads: gpar()
ns <- list(type="arrow", gp=gpar(fill="lightblue", col="white", lwd=4))
sankey(nodes, flows, colors, node_style=ns, legend=TRUE)

## -----------------------------------------------------------------------------
nodes <- tribble(
  ~ID,     ~label,       ~x,  ~y,       ~label_pos,
  "in",    "Import",       0,  "1",    "left",
  "proc",  "Processing",   2,  "0",    "below",
  "out",   "Export",       4,  "in",   "right",
  "use",   "Domestic use", 4,  "proc", "above"
)
flows <- tribble(
  ~from,   ~to,     ~quantity,
  "in",    "out",    3.0,
  "",      "proc",   2.0,
  "proc",  "out",    1.5,
  "",      "use",    0.5
)
colors <- tribble(
  ~substance,   ~color,
  "<any>",      "cornflowerblue",
)

ns <- list(type="arrow", gp=gpar(fill="lightblue", col="white", lwd=4), mag_pos="label")
sankey(nodes, flows, colors, node_style=ns)

## -----------------------------------------------------------------------------
nodes <- tribble(
  ~ID,     ~label,         ~x,   ~y,      ~dir,    ~label_pos,
  "in",    "Import",       0,   "2",     "right", "left",
  "proc",  "Processing",   4,   "0",     "right", "below",
  "out",   "Export",       8,   "in",    "right", "right",
  "use",   "Domestic use", 8,   "proc",  "right", "above",
  "R1",    "",             7,   "-1.5",  "down",  "none",
  "R2",    "Recycling",    4,   "-3",    "left",  "below",
  ".R3",   "",             1,   "-1.5",  "up",    "none"
)
flows <- tribble(
  ~from,    ~to,    ~quantity,
  "in",     "out",   3.0,
  "",       "proc",  2.0,
  "proc",   "out",   1.5,
  "",       "use",   0.5,
  "proc",   "R1",    1.0,
  "R1",     "R2",    1.0,
  "R2",     "R3",   1.0,
  "R3",    "proc",  1.0
)

colors <- tribble(
  ~substance, ~color,
  "<any>",    "cornflowerblue",
)

ns <- list(type="arrow", gp=gpar(fill="red", col="white", lwd=3), mag_pos="label")
sankey(nodes, flows, colors, node_style=ns, grill=TRUE)

## -----------------------------------------------------------------------------

timestamp <- format(Sys.Date()) # e.g. 2020-11-28
copyright <- paste("CBS", timestamp, sep="/") # could also use sprintf("CBS/%s", timestamp)

ns <- list(type="arrow", gp=gpar(fill="red", col="white", lwd=3), mag_pos="label")
sankey(nodes, flows, colors, node_style=ns, copyright=copyright)

## -----------------------------------------------------------------------------
sankey(nodes, flows, colors, node_style=ns, copyright=copyright,
       page_margin=c(0.1, 0.3, 0.1, 0.1))

## -----------------------------------------------------------------------------
nodes <- tribble(
  ~ID,     ~label,       ~x,   ~y,      ~dir,    ~label_pos,
  "in",    "Import",      0,   "2",     "right", "left",
  "stock", "Processing",  2,   "0",     "stock", "below",
  "out",   "Export",      4,   "in",    "right", "right",
)
flows <- tribble(
  ~from,     ~to,      ~quantity,
  "in",     "out",      1.5,
  "in",     "stock",    2.0,
  "stock",   "out",     1.0
)
colors <- tribble(
  ~substance, ~color,
  "<any>",    "cornflowerblue",
)

ns <- list(type="arrow", gp=gpar(fill="red", col="white", lwd=4), mag_pos="label")
sankey(nodes, flows, colors,
       node_style=ns,
       page_margin=c(0.1, 0.2, 0.1, 0.1))

## -----------------------------------------------------------------------------
nodes <- tribble(
  ~ID,  ~label,   ~x,   ~y,      ~dir,    ~label_pos,
  "in",    "Input",  0,   "0",     "right", "left",
  "out",   "Output", 4,   "in",    "right", "right",
)
flows <- tribble(
  ~from,     ~to,   ~quantity, ~substance,
  "in",     "out",   1, "Oil",
  "",       "",      1, "Gas",
  "",       "",      1, "Biomass",
  "",       "",      1, "Electricity",
  "",       "",      1, "Solar",
  "",       "",      1, "Hydrogen",
  "",       "",      1, "Wind",
  "",       "",      1, "Water",
  "",       "",      1, "Nuclear",
)

ns <- list(type="arrow", gp=gpar(fill=gray(0.5), col="white", lwd=4), mag_pos="label")
sankey(nodes, flows, node_style=ns, legend=gpar(filesize=18, col="blue", ncols=2))

## -----------------------------------------------------------------------------
ns <- list(type="arrow", gp=gpar(fill=gray(0.5), col="white", lwd=4), mag_pos="label")
sankey(nodes, flows, node_style=ns, legend=gpar(filesize=18, col="blue", ncols=2),
       page_margin=c(0.1, 0.1, 0.1, 0.2),
       title="Panta Rhei")

## -----------------------------------------------------------------------------
my_title <- "Panta Rhei"
attr(my_title, "gp") <- gpar(fontsize=24, fontface="bold", col="red")

sankey(nodes, flows, node_style=ns, legend=gpar(filesize=18, col="blue", ncols=2),
       page_margin=c(0.1, 0.1, 0.1, 0.2),
       title=my_title)

## -----------------------------------------------------------------------------
sankey(nodes, flows, node_style=ns, legend=gpar(filesize=18, col="blue", ncols=2),
       page_margin=c(0.1, 0.1, 0.1, 0.2),
       title=strformat("Panta Rhei", fontsize=18, col="blue"))

## ----  eval=FALSE-------------------------------------------------------------
#  pdf("diagram.pdf", width=10, height=7) # Set up PDF device
#  sankey(nodes, flows, colors)           # plot diagram
#  dev.off()                              # close PDF device

## ---- eval=FALSE--------------------------------------------------------------
#  nodes   <- read_xlsx("my_sankey_data.xlsx", "nodes")
#  flows   <- read_xlsx("my_sankey_data.xlsx", "flows")
#  colors  <- read_xlsx("my_sankey_data.xlsx", "colors")
#  sankey(nodes, flows, colors)

## ---- eval=FALSE--------------------------------------------------------------
#  check_consistency(nodes, flows, colors)
#  check_balance(nodes, flows)

## -----------------------------------------------------------------------------
data(MFA) # Material Flow Account data

## ----echo=FALSE---------------------------------------------------------------
print(MFA$nodes)

## ----echo=FALSE---------------------------------------------------------------
print(MFA$flows)

## ----echo=FALSE---------------------------------------------------------------
print(MFA$palette)

## ----fig.width=9, fig.height=7------------------------------------------------
dblue <- "#00008B" # Dark blue

my_title <- "Material Flow Account"
attr(my_title, "gp") <- grid::gpar(fontsize=18, fontface="bold", col=dblue)

# node style
ns <- list(type="arrow",gp=gpar(fill=dblue, col="white", lwd=2),
           length=0.7,
           label_gp=gpar(col=dblue, fontsize=8),
           mag_pos="label", mag_fmt="%.0f", mag_gp=gpar(fontsize=10,fontface="bold",col=dblue))

sankey(MFA$nodes, MFA$flows, MFA$palette,
       max_width=0.1, rmin=0.5,
       node_style=ns,
       page_margin=c(0.15, 0.05, 0.1, 0.1),
       legend=TRUE, title=my_title,
       copyright="Statistics Netherlands")

