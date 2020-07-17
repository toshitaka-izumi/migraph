# roctopus 0.1.0

2020-06-30

## Data

* Added Bristol dataset from Knoke et al 2020

# roctopus 0.0.4

2018-12-20

## Package

* Added hex sticker
* Updated README with more detailed installation information
* Pkgdown exports to https://jhollway.bitbucket.io/roctopus/

## Analysis

* Added `twomode_modularity()` to calculate modularity in two-mode networks

## Visualization

* Added `plot_multilevel()` that rotates a force-directed `igraph` plot in three dimensions to reveal multilevel structure
* Added `plot_globalnet()` to map a multilevel network on to a javascript, rotatable global

# roctopus 0.0.3

2018-08-25

## Analysis

* Added `twomode_smallworld()` to calculate observed/expected clustering, observed/expected path-length, and the observed/expected clustering ratio
* Added `twomode_2x2()` to identify dominance and coherence values for networks over time
* Updated `twomode_coherence()` to allow for introduction of second-mode attributes
* Renamed `twomode_fragmentation()` to `twomode_components()`

## Visualisation

* Added `plot_2x2()` to plot values through a two-by-two matrix

# roctopus 0.0.2

2018-08-14

## Package

* Renamed package to `roctopus`
* Added two-mode @family tag to documentation

## Analysis

* Added `twomode_fragmentation()` to calculate number of components in two-mode networks and identify their membership
* Added `twomode_dominance()` to allow an nodal attribute to be passed to the function to weight the centralization measure
* Added `twomode_coherence()` to calculate Jaccard similarity

## Visualisation

* Added `plot_twomode()`, which wraps `plot(igraph::graph_from_incidence_matrix())` with some useful defaults
    - coloured grayscale by default, with green/blue option
    - shaped circles and squares by default

# roctopus 0.0.1

2018-07-30

## Package

* Initialised package
* Added `README.md` file with instructions on how to install package
* Added `LICENSE` file and pointed to bug/issue tracker
* Added a `NEWS.md` file to track changes to the package

## Analysis

* Added `twomode_clustering()` to calculate percentage of three-paths closed by four-paths
* Added `twomode_lattice()` to create two-mode lattices
* Added `twomode_centralization_degree()` to calculate degree centralization in two-mode networks, for rows, columns, or both
* Added `twomode_centralization_between()` to calculate betweenness centralization in two-mode networks
* Added `twomode_constraint()` to calculate network constraint in two-mode networks
* Added `arrange.vars()` to rearrange variables by position