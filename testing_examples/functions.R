

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

# Print some diagnostics on screen
print_diagnostics <- function(tree_simulation, Q){
  expected_trans_AB <- sum(tree_simulation$edge.length) * Q[2, 1]
  expected_trans_BA <- sum(tree_simulation$edge.length) * Q[1, 2]

  observed_trans_AB <- sum((tree_simulation$node.states[, 1] == 'A') & (tree_simulation$node.states[, 2] == 'B'))
  observed_trans_BA <- sum((tree_simulation$node.states[, 1] == 'B') & (tree_simulation$node.states[, 2] == 'A'))

  print(paste("Expected A -> B transitions", expected_trans_AB))
  print(paste("Observed A -> B transitions", observed_trans_AB))

  print(paste("Expected B -> A transitions", expected_trans_BA))
  print(paste("Observed B -> A transitions", observed_trans_BA))

  observed_transitions_total <- sum(tree_simulation$node.states[, 1] != tree_simulation$node.states[, 2])

  print(paste("The EXPECTED total number of transitions is:", expected_trans_AB))
  print(paste("The OBSERVED total number of transitions is:", observed_transitions_total))
  par(mar = c(4, 4, 4, 4))
  par(mfrow = c(1, 2))
  plot(tree_simulation, show.tip.label = F, edge.width = 2)
  nodelabels(get_node_states(tree_simulation))
  tiplabels(tree_simulation$states)
  text(paste(expression(T[exp]), '=', expected_trans_AB), x = 0.06, y = 1)
  text(paste(expression(T[obs]), '=', observed_transitions_total), x = 0.06, y = -0.5) 
  corrplot(Q, method = 'number')
}
