

# Get node states for tree simulated with sim.history from package phytools
get_node_states <- function(tree_states){
  node_vals <- vector()
  for(i in 1:(tree_states$Nnode)){
    node_vals[i] <- tree_states$node.states[((tree_states$edge[, 1]) == (i + length(tree_states$tip.label))[1]), 1][1]
  }
  return(node_vals)
}


# Get Q for binary characters, with a given number of transitions. Note that the Q matrix is symmetric 
get_Q <- function(tree_chrono, trans_num){
      S <- sum(tree_chrono$edge.length)
      trans_prob <- trans_num / S
      Q <- matrix(c( -trans_prob, trans_prob, trans_prob, -trans_prob), 2, 2)
      rownames(Q) <- c('A', 'B')
      colnames(Q) <- rownames(Q)
      return(Q)
}
