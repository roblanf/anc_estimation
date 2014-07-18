

# Get node states for tree simulated with sim.history from package phytools

get_node_states <- function(tree_states){
  node_vals <- vector()
  for(i in 1:(tree_states$Nnode)){
    node_vals[i] <- tree_states$node.states[((tree_states$edge[, 1]) == (i + length(tree_states$tip.label))[1]), 1][1]
  }
  return(node_vals)
}
