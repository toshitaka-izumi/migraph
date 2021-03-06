#' Centrality for one- and two-mode networks
#'
#' These functions calculate common centrality measures for both one- and two-mode networks.
#' They accept as objects matrices and `igraph` graphs, 
#' and can be used within a tidygraph workflow.
#' Importantly, these functions also offer correct normalization for two-mode networks.
#' @name centrality
#' @family two-mode functions
#' @param object Either an igraph graph object or a matrix.
#' @param weights The weight of the edges to use for the calculation. 
#' Will be evaluated in the context of the edge data.
#' @param mode How should edges be followed. Ignored for undirected graphs
#' @param loops Should loops be included in the calculation
#' @param normalized Should the output be normalized for one or two-modes networks
#' @importFrom rlang enquo eval_tidy
#' @importFrom igraph graph_from_incidence_matrix is_bipartite degree V
#' @references Borgatti, Stephen P., and Martin G. Everett. "Network analysis of 2-mode data." Social networks 19.3 (1997): 243-270.
#' @examples
#' centrality_degree(southern_women)
#' mpn_powerelite %>% tidygraph::mutate(degree = centrality_degree())
#' @return Depending on how and what kind of an object is passed to the function,
#' the function will return a `tidygraph` object where the nodes have been updated
#' @export
centrality_degree <- function (object, weights = NULL, mode = "out", loops = TRUE, normalized = FALSE){
  
  # Converge inputs
  if(missing(object)){
    expect_nodes()
    graph <- .G()
    weights <- rlang::enquo(weights)
    weights <- rlang::eval_tidy(weights, .E())
  } else if (is.igraph(object)) {
    graph <- object
  } else if (is.matrix(object)) {
    graph <- igraph::graph_from_incidence_matrix(object)
  }
  
  # Do the calculations
  if (is.null(weights)) {
    weights <- NA
  }
  if (igraph::is_bipartite(graph) & normalized){
    degrees <- igraph::degree(graph = graph, v = igraph::V(graph), mode = mode, loops = loops)
    other_set_size <- ifelse(igraph::V(graph)$type, sum(!igraph::V(graph)$type), sum(igraph::V(graph)$type))
    degrees/other_set_size
  } else {
    if (is.null(weights)) {
      igraph::degree(graph = graph, V = igraph::V(graph), mode = mode, loops = loops, 
             normalized = normalized)
    }
    else {
      igraph::strength(graph = graph, vids = igraph::V(graph), mode = mode, 
               loops = loops, weights = weights)
    }
  }
}

#' @rdname centrality
#' @family two-mode functions
#' @param cutoff maximum path length to use during calculations 
#' @import tidygraph
#' @examples
#' centrality_closeness(southern_women)
#' mpn_powerelite %>% tidygraph::mutate(closeness = centrality_closeness())
#' @export
centrality_closeness <- function (object, weights = NULL, mode = "out", normalized = FALSE, cutoff = NULL){

  # Converge inputs
  if(missing(object)){
    expect_nodes()
    graph <- .G()
    weights <- rlang::enquo(weights)
    weights <- rlang::eval_tidy(weights, .E())
  } else if (is.igraph(object)) {
    graph <- object
  } else if (is.matrix(object)) {
    graph <- igraph::graph_from_incidence_matrix(object)
  }
  
  # Do the calculations
  if (is.null(weights)) {
    weights <- NA
  }
  if (igraph::is_bipartite(graph) & normalized){
    # farness <- rowSums(igraph::distances(graph = graph))
    closeness <- igraph::closeness(graph = graph, vids = igraph::V(graph), mode = mode)
    other_set_size <- ifelse(igraph::V(graph)$type, sum(!igraph::V(graph)$type), sum(igraph::V(graph)$type))
    set_size <- ifelse(igraph::V(graph)$type, sum(igraph::V(graph)$type), sum(!igraph::V(graph)$type))
    closeness/(1/(other_set_size+2*set_size-2))
    } else {
      if (is.null(cutoff)) {
        igraph::closeness(graph = graph, vids = igraph::V(graph), mode = mode,
                  weights = weights, normalized = normalized)
      } else {
        igraph::estimate_closeness(graph = graph, vids = igraph::V(graph), mode = mode, 
                           cutoff = cutoff, weights = weights, normalized = normalized)
      }
    }
} 

#' @rdname centrality
#' @family two-mode functions 
#' @param directed Should direction of edges be used for the calculations 
#' @param cutoff maximum path length to use during calculations
#' @param nobigint Should big integers be avoided during calculations 
#' @import tidygraph
#' @references Borgatti, Stephen P., and Martin G. Everett. "Network analysis of 2-mode data." Social networks 19.3 (1997): 243-270.
#' @examples
#' centrality_betweenness(southern_women)
#' mpn_powerelite %>% tidygraph::mutate(betweenness = centrality_betweenness())
#' @return A numeric vector giving the betweenness centrality measure of each node.
#' @export 
centrality_betweenness <- function(object, weights = NULL, directed = TRUE, cutoff = NULL, nobigint = TRUE, normalized = FALSE){

  # Converge inputs
  if(missing(object)){
    expect_nodes()
    graph <- .G()
    weights <- rlang::enquo(weights)
    weights <- rlang::eval_tidy(weights, .E())
  } else if (is.igraph(object)) {
    graph <- object
  } else if (is.matrix(object)) {
    graph <- igraph::graph_from_incidence_matrix(object)
  }
  
  # Do the calculations
  if (is.null(weights)) {
    weights <- NA
  } 
  if (igraph::is_bipartite(graph) & normalized){
    betw_scores <- igraph::betweenness(graph = graph, v = igraph::V(graph), directed = directed, nobigint = nobigint)
    other_set_size <- ifelse(igraph::V(graph)$type, sum(!igraph::V(graph)$type), sum(igraph::V(graph)$type))
    set_size <- ifelse(igraph::V(graph)$type, sum(igraph::V(graph)$type), sum(!igraph::V(graph)$type))
    ifelse(set_size > other_set_size, 
           betw_scores/(2*(set_size-1)*(other_set_size-1)), 
           betw_scores/(1/2*other_set_size*(other_set_size-1)+1/2*(set_size-1)*(set_size-2)+(set_size-1)*(other_set_size-1)))
  } else {
    if (is.null(cutoff)) {
      igraph::betweenness(graph = graph, v = igraph::V(graph), directed = directed, weights = weights, nobigint = nobigint, normalized = normalized)
    } else {
      igraph::estimate_betweenness(graph = graph, vids = igraph::V(graph), directed = directed, cutoff = cutoff, weights = weights, nobigint = nobigint)
    }
  }
}
