library(phangorn)
library(phytools)
library(corrplot)
library(TreeSim)
library(NELSI)
source('functions.R')


# Simulate data along trees and get distribution of Pvalues of possion distribution with a high number of transitions
####################################

T_num <- 20
poisson_p_vals <- vector()
trans_obs <- vector()
for(i in 1:100){ 
  tr_sim <- sim.bd.taxa.age(n = 50, numbsim = 1, lambda = 0.5, mu = 0.0, frac = 1, age = 1.00, mrca = FALSE)[[1]]
  tr_sim$edge.length <- tr_sim$edge.length * (1 / max(branching.times(tr_sim)))
  q_high <- get_Q(tr_sim, trans_num = T_num)
  sim_high <- sim.history(tr_sim, anc = 'A', Q = q_high)
  res_temp <- print_diagnostics(sim_high, q_high)
  trans_obs[i] <- res_temp[[2]]
  poisson_p_vals[i] <- res_temp[[1]]
  if((i %% 10) == 0) print(paste('Running simulation', i, 'of', 1000, 'P=', round(poisson_p_vals[i], 2)))
}

hist(poisson_p_vals, col = 'blue', main = 'Poisson P values for expected transitions = 20')
hist(trans_obs, col = 'green')


# Simulate data along trees and get distribution of Pvalues of possion distribution with a medium number of transitions
####################################

T_num <- 10
poisson_p_vals <- vector()
poisson_p_vals <- vector()
for(i in 1:100){ 
  tr_sim <- sim.bd.taxa.age(n = 50, numbsim = 1, lambda = 0.5, mu = 0.0, frac = 1, age = 1.00, mrca = FALSE)[[1]]
  tr_sim$edge.length <- tr_sim$edge.length * (1 / max(branching.times(tr_sim)))
  q_high <- get_Q(tr_sim, trans_num = T_num)
  sim_high <- sim.history(tr_sim, anc = 'A', Q = q_high)
  res_temp <- print_diagnostics(sim_high, q_high)		    
  trans_obs[i] <- res_temp[[2]]
  poisson_p_vals[i] <- res_temp[[1]]
  if((i %% 10) == 0) print(paste('Running simulation', i, 'of', 1000, 'P=', round(poisson_p_vals[i], 2)))
}

hist(poisson_p_vals, col = 'blue', main = "Poisson P values for expected transitions = 10")
hist(trans_obs, col = 'green')

# Simulate data along trees and get distribution of Pvalues of possion distribution with a low number of transitions
####################################

T_num <- 5
poisson_p_vals <- vector()
trans_obs <- vector()
for(i in 1:100){ 
  tr_sim <- sim.bd.taxa.age(n = 50, numbsim = 1, lambda = 0.5, mu = 0.0, frac = 1, age = 1.00, mrca = FALSE)[[1]]
  tr_sim$edge.length <- tr_sim$edge.length * (1 / max(branching.times(tr_sim)))
  q_high <- get_Q(tr_sim, trans_num = T_num)
  sim_high <- sim.history(tr_sim, anc = 'A', Q = q_high)
  res_temp <- print_diagnostics(sim_high, q_high)
  trans_obs[i] <- res_temp[[2]]
  poisson_p_vals[i] <- res_temp[[1]]
  if((i %% 10) == 0) print(paste('Running simulation', i, 'of', 1000, 'P=', round(poisson_p_vals[i], 2)))
}

hist(poisson_p_vals, col = 'blue', main = "Poisson P values for expected transitions = 5")
hist(trans_obs, col = 'green')








