source('R/functions.R')

# Put true tree here
tr_true <- rcoal(10)
tr_true$edge.length <- tr_true$edge.length / max(branching.times(tr_true))

tr_q <- get_Q(tr_true, 3)

n_trans <- 0
while( n_trans < 2){
  tr_s <- sim.history(tr_true, tr_q)
  n_trans <- length(unique(get_node_states(tr_s)))
}

# Load estimated trees here
est_trees <- lapply(1:10, function(x) rcoal(10))
est_chrono <- list()

for(i in 1:length(est_trees)){
  est_chrono[[i]] <- est_trees[[i]]
  est_chrono[[i]]$edge.length <- est_chrono[[i]]$edge.length / max(branching.times(est_chrono[[i]]))
}

class(est_chrono) <- 'multiPhylo'



####
get_fitted_node_states <- function(reroot_tree){
  rec <- reroot_tree$marginal.anc
  marginal_anc <- colnames(rec)[sapply(1:nrow(rec), function(x) which.max(rec[x, ]))]
  return(marginal_anc)
  
}
####

fit_true <- rerootingMethod(tr_true, tr_s$states, model = 'SYM')
true_nodes <- get_fitted_node_states(fit_true)
tips_true <- tr_s$states[match(tr_true$tip.label, names(tr_s$states))]
fit_states_true <- get_fitted_states(fit_true, tr_s$states, tr_true)
n_states_true <- sum(sapply(1:nrow(fit_states_true), function(x) fit_states_true[x, 1] != fit_states_true[x, 2]))

plot(tr_true, show.tip.label = F)
tiplabels(tips_true, cex = 0.5, frame = 'circle', bg = as.factor(tips_true))
nodelabels(true_nodes, cex = 0.5, frame = 'circle', bg = as.factor(true_nodes))

# get Ntrans on true tree



fit_1 <- rerootingMethod(est_chrono[[1]], tr_s$states, model = 'SYM')
fit_nodes <- get_fitted_node_states(fit_1)
tip_states <- tr_s$states[match(est_chrono[[1]]$tip.label, names(tr_s$states))] 
fit_states_1 <- get_fitted_states(fit_1, tip_states, est_chrono[[1]])
n_states_1 <- sum(sapply(1:nrow(fit_states_1), function(x) fit_states_1[x, 1] != fit_states_1[x, 2]))

plot(est_chrono[[1]], show.tip.label = F)
tiplabels(tip_states, cex = 0.5, frame = 'circle', bg = as.factor(tip_states))
nodelabels(fit_nodes, cex = 0.5, frame = 'circle', bg = as.factor(fit_nodes))

# get Ntrans on random tree
