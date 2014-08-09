library(phangorn)
library(phytools)
library(corrplot)
library(TreeSim)
library(NELSI)
source('../R/functions.R')

# Using a lognormal rate with sd of 0.3

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


test_1 <- get_tree_Q(tree_age = 1, taxa = 50, rate = 0.1, n_trans = 10, seq_length = 1000)

test_2 <- get_tree_Q(tree_age = 1, taxa = 50, rate = 0.1, n_trans = 10, seq_length = 0)

