
## Simulate 3, 10 and 30 transitions over each tree and each number of taxa:
#   - For each combination of number of simulated transitions and number of taxa plot the error in the estimated number of transitions (with 95% credible interval) vs. the mean posterior support (analogous to sequence length). This sholud result in 9 plots (3 ntax and 3 nsubst)

# For this part:
#  - read the true tree,

#   - simulate a number of transitions (3, 10, or 30) and save:
#
#     - true number of transitions
#     - estimated number of transitions
#     - taxon states

#   - Read the last 100 trees in the posterior. For each tree:

#     - assign tip states
#     - estimate number of transitions
#     - save in a temporal vector

#   - Report set_name, simulated transitions, estimated n_trans on true tree, max and min n_trans on posterior trees

source('../../R/functions.R')
#source('../R/functions.R')
require(phytools)
#require(NELSI)
require(methods)
true_trees <- grep('[.]tree ?$', dir(), value = T)

#Specify here the number of transitions to simulate along the trees
all_trans <- c(3, 10, 30)

for(n_t in all_trans){
    n_trans <- n_t
    res_mat <- matrix(NA, length(true_trees), 4)
for(i in 1:length(true_trees)){

  # For the true tree do:
  phylo_temp <- read.tree(true_trees[i])
  true_temp <- phylo_temp
  true_temp$edge.length  <- true_temp$edge.length * (1 / max(allnode.times(true_temp)))

  Q_temp <- get_Q(tree_chrono = true_temp, trans_num = n_trans)

  t_sim <- 0
  while(t_sim < 2){
    sim_true <- sim.history(true_temp, anc = 'A', Q = Q_temp)
    tip_states <- sim_true$states
    t_sim <- length(unique(tip_states))
    print(paste('getting states...', t_sim))
  }

  fit_true <- make.simmap(true_temp, tip_states, model = 'SYM', nsim = 100)
  est_true <- describe.simmap(fit_true, plot = FALSE)$count
  n_true_tree <- tryCatch(mean(est_true[, 1]), error = function(x) mean(est_true))

  # On posterior trees

  postres <- read.nexus(gsub('tree ?', 'trees', true_trees[i]))

  est_post <- vector()
  for(k in sample((length(postres) - 200):length(postres), 10)){
      print(paste('estimating states for tree' , k))
      fit_post_temp <- make.simmap(postres[[k]], tip_states, model = 'SYM', nsim = 100)

      est_post_temp <- describe.simmap(fit_post_temp, plot = FALSE)$count
           
      n_est_post_temp <- tryCatch(mean(est_post_temp[, 1]), error = function(x) mean(est_post_temp))
#       n_est_post_temp <- mean(est_post_temp)
      est_post <- c(est_post, n_est_post_temp)
  }

      errors_temp <- est_post - n_true_tree
      res_mat[i, ] <- c(gsub('[.].+$', '', true_trees[i]), n_true_tree, min(errors_temp), max(errors_temp))

}

write.table(res_mat , file = paste0(n_trans, 'res_matrix_20t.txt'), row.names = F)
}
