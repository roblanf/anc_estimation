

# Get node states for tree simulated with sim.history from package phytools
get_node_states <- function(tree_states){

if(is.phylo(tree_states)){
  node_vals <- vector()
  for(i in 1:(tree_states$Nnode)){
    node_vals[i] <- tree_states$node.states[((tree_states$edge[, 1]) == (i + length(tree_states$tip.label))[1]), 1][1]
  }
}else{
  node_vals <- sapply(1:nrow(tree_states$marginal.anc), function(x) c('A', 'B')[which.max(c(tree_states$marginal.anc[x, 1], tree_states$marginal.anc[x, 2]))])
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
print_diagnostics <- function(tree_simulation, Q, plot_results = FALSE){
  expected_trans_AB <- sum(tree_simulation$edge.length) * Q[2, 1]
  expected_trans_BA <- sum(tree_simulation$edge.length) * Q[1, 2]
  observed_trans_AB <- sum((tree_simulation$node.states[, 1] == 'A') & (tree_simulation$node.states[, 2] == 'B'))
  observed_trans_BA <- sum((tree_simulation$node.states[, 1] == 'B') & (tree_simulation$node.states[, 2] == 'A'))

  observed_transitions_total <- sum(tree_simulation$node.states[, 1] != tree_simulation$node.states[, 2])

  if(plot_results){
    print(paste("Expected A -> B transitions", expected_trans_AB))
    print(paste("Observed A -> B transitions", observed_trans_AB))

    print(paste("Expected B -> A transitions", expected_trans_BA))
    print(paste("Observed B -> A transitions", observed_trans_BA))

    print(paste("The EXPECTED total number of transitions is:", expected_trans_AB))
    print(paste("The OBSERVED total number of transitions is:", observed_transitions_total))
    par(mar = c(4, 4, 4, 4))
    par(mfrow = c(1, 2))
    plot(tree_simulation, show.tip.label = F, edge.width = 2)
    nodelabels(get_node_states(tree_simulation))
    tiplabels(tree_simulation$states)
    text(labels = paste('T[exp]', '=', expected_trans_AB), x = 0.06, y = 1)
    text(labels = paste('T[obs]', '=', observed_transitions_total), x = 0.06, y = -0.5)
    text(labels = paste('P', '=', ppois(q = observed_transitions_total, lambda = expected_trans_AB)), x = 0.6, y = 0) 
    corrplot(Q, method = 'number')
  }
  res_list <- list(ppois(q = observed_transitions_total, lambda = expected_trans_AB, lower.tail = T), observed_transitions_total, Q)
  return(res_list)
}


# get fitted states from a rerootingMethod object

get_fitted_states <- function(fit_states, sim_tree){

  node_states <- cbind( rownames(fit_states$marginal.anc), get_node_states(fit_states))
  node_states_matrix <- sim_tree$edge
  for(i in 1:nrow(node_states)){
    node_states_matrix[node_states_matrix[, 1] == node_states[i, 1], 1] <- node_states[i, 2]
    node_states_matrix[node_states_matrix[, 2] == node_states[i, 1], 2] <- node_states[i, 2]
  }

node_states_matrix[!(node_states_matrix[, 2] %in% c('A', 'B')), 2] <-   sim_tree$states[as.numeric(node_states_matrix[!(node_states_matrix[, 2] %in% c('A', 'B')), 2])]

#  return(sum(node_states_matrix[, 1] != node_states_matrix[, 2]))
   return(node_states_matrix)
  #node_states_matrix

}



# simulate a data set that includes the chonogram, phylogram, sequence data, Q matrix, tip states, and number of transitions

get_tree_Q <- function(tree_age = 1, taxa = 50, rate = 0.1, n_trans = 4, seq_length = 1000){

  # Simulate chronogram
  tr_sim <- sim.bd.taxa.age(n = taxa, numbsim = 1, lambda = 0.5, mu = 0.0, frac = 1, age = tree_age, mrca = FALSE)[[1]]
  tr_sim$edge.length <- tr_sim$edge.length * (tree_age / max(branching.times(tr_sim)))

  # Simulate phylogram
  phylo_sim <- tr_sim
  phylo_sim$edge.length <- tr_sim$edge.length * rlnorm(length(tr_sim$edge.length), meanlog = log(0.1), sdlog = 0.3)

  # Simulate sequence data
  if(seq_length > 0){
    dna_sim <- as.DNAbin(simSeq(phylo_sim, l = seq_length))
  }else{
    dna_sim <- matrix('n', ncol = 1, nrow = taxa)
    rownames(dna_sim) <- tr_sim$tip.label
    dna_sim <- as.DNAbin(dna_sim)
  }
  
  # Simulate character transitions. Note that the root state is always A. Also note that n_trans is the expected, and that the simulation does not always match this value
  q_mat <-   get_Q(tree_chrono = tr_sim, trans_num = n_trans)
  sim_states <- sim.history(tr_sim, anc = 'A', Q = q_mat)
  states_obs <- print_diagnostics(sim_states, q_mat)[[2]]
  
  return(list(chornogram = tr_sim, phylogram = phylo_sim, seq_data = dna_sim, q_mat = q_mat, tip_states = sim_states$states ,numb_trans = states_obs))
}
