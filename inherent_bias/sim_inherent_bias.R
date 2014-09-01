#This is to show the inherent bias when estimating the number of transitions with the true tree


source('../R/functions.R')



sim_trans <- rep(c(2, 5, 10, 20, 30), 25)

#######################
### For 50 taxa 

n_tax <- 50
t_est_50 <- matrix(NA, nrow = length(sim_trans), ncol = 2)
colnames(t_est_50) <- c('sim_trans', 'est_trans')

for(i in 1:length(sim_trans)){

print(paste('Simulating transistions for ', n_tax, 'taxa.', 'replicate', i))
      tr_test <- get_tree_Q(tree_age = 1, taxa = n_tax, rate = 0.1, n_trans = sim_trans[i], seq_length = 1)

      n_true_trans <- tr_test$numb_trans

      fit_states <- rerootingMethod(tr_test$chronogram, x = tr_test$tip_states)
      est_trans <- get_fitted_states(fit_states, tr_test$tip_states, tr_test$chronogram)

      n_est_trans <- sum(sapply(1:nrow(est_trans), function(x) est_trans[x, 1] != est_trans[x, 2]))
      t_est_50[i, ] <- c(n_true_trans, n_est_trans)
}

write.table(t_est_50, file = 'inherent_bias_ntax50.txt', sep = '\t', row.names = F)

plot(t_est_50[, 1], t_est_50[, 2], pch = 20, ylab = 'Number of simulated transitions', xlab = 'Estimated number of transitions with the true tree')


#############################
### For 100 taxa 

n_tax <- 100
t_est_100 <- matrix(NA, nrow = length(sim_trans), ncol = 2)
colnames(t_est_100) <- c('sim_trans', 'est_trans')

for(i in 1:length(sim_trans)){

print(paste('Simulating transistions for ', n_tax, 'taxa.', 'replicate', i))
      tr_test <- get_tree_Q(tree_age = 1, taxa = n_tax, rate = 0.1, n_trans = sim_trans[i], seq_length = 1)

      n_true_trans <- tr_test$numb_trans

      fit_states <- rerootingMethod(tr_test$chronogram, x = tr_test$tip_states)
      est_trans <- get_fitted_states(fit_states, tr_test$tip_states, tr_test$chronogram)

      n_est_trans <- sum(sapply(1:nrow(est_trans), function(x) est_trans[x, 1] != est_trans[x, 2]))
      t_est_100[i, ] <- c(n_true_trans, n_est_trans)
}

write.table(t_est_100, file = 'inherent_bias_ntax100.txt', sep = '\t', row.names = F)

points(t_est_100[, 1], t_est_100[, 2], pch = 20, col = 2)

#############################
### For 1000 taxa 

n_tax <- 1000
t_est_1000 <- matrix(NA, nrow = length(sim_trans), ncol = 2)
colnames(t_est_1000) <- c('sim_trans', 'est_trans')

for(i in 1:length(sim_trans)){

print(paste('Simulating transistions for ', n_tax, 'taxa.', 'replicate', i))
      tr_test <- get_tree_Q(tree_age = 1, taxa = n_tax, rate = 0.1, n_trans = sim_trans[i], seq_length = 1)

      n_true_trans <- tr_test$numb_trans

      fit_states <- rerootingMethod(tr_test$chronogram, x = tr_test$tip_states)
      est_trans <- get_fitted_states(fit_states, tr_test$tip_states, tr_test$chronogram)

      n_est_trans <- sum(sapply(1:nrow(est_trans), function(x) est_trans[x, 1] != est_trans[x, 2]))
      t_est_1000[i, ] <- c(n_true_trans, n_est_trans)
}

write.table(t_est_1000, file = 'inherent_bias_ntax1000.txt', sep = '\t', row.names = F)

points(t_est_100[, 1], t_est_100[, 2], pch = 20, col = 3)
