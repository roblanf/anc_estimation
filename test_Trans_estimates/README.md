Test estimation of Q and T with the correct tree
===============================================

July 19 2014

To do
-----

- ~~Simulate tree with root age of 1 and 50 tips.~~

- ~~Simulate binary character with *Texp*.~~

- ~~Obtain *Tobs* and *Q*.~~

- ~~Estimate *Test* and *Q* on the simulated tree and the character values at the tips.~~

- ~~Calculate |*Tobs* - *Test*|.~~


Simulate tree
=============

Load the necessary packages and custom functions:


```r
library(phangorn)
library(phytools)
library(corrplot)
library(TreeSim)
library(NELSI)
source('../R/functions.R')
```


Simulations with large number of transitions
======================


```r
T_num <- 20

res_high <- matrix(NA, 100, 3)
colnames(res_high) <- c('T_obs', 'T_est', 'diff')

for(i in 1:100){

  tr_sim <- sim.bd.taxa.age(n = 50, numbsim = 1, lambda = 0.5, mu = 0.0, frac = 1, age = 1.00, mrca = FALSE)[[1]]
  tr_sim$edge.length <- tr_sim$edge.length * (1 / max(branching.times(tr_sim)))
  q_high <- get_Q(tr_sim, trans_num = T_num)
  
  sim_vals <- 1
  while(sim_vals == 1){
    sim_dat <- sim.history(tr_sim, q_high)  
    sim_vals <- length(unique(sim_dat$states))
  }  
  est_dat <- rerootingMethod(tr_sim, sim_dat$states)

  #par(mfrow = c(1, 2))
  #plot(tr_sim, show.tip.label = F)
  #tiplabels(sim_dat$states)
  #nodelabels(get_node_states(sim_dat))

  #plot(sim_dat, show.tip.label = F)
  #tiplabels(sim_dat$states)
  #nodelabels(get_node_states(est_dat))

  fitted_transitions <- get_fitted_states(est_dat, sim_dat)

  T_obs <- sum(sim_dat$node.states[, 1] != sim_dat$node.states[, 2])
  T_est <- sum(fitted_transitions[, 1] != fitted_transitions[, 2])

  diff_obs_est <- T_est - T_obs
  res_high[i, ] <- c(T_obs, T_est, diff_obs_est)

  if((i %% 10) == 0)  print(paste('simulation', i, 'with T_obs=', T_obs, ',and T_ext =', T_est))	
}
```

```
## [1] "simulation 10 with T_obs= 6 ,and T_ext = 5"
## [1] "simulation 20 with T_obs= 20 ,and T_ext = 11"
## [1] "simulation 30 with T_obs= 20 ,and T_ext = 18"
## [1] "simulation 40 with T_obs= 14 ,and T_ext = 11"
## [1] "simulation 50 with T_obs= 14 ,and T_ext = 10"
## [1] "simulation 60 with T_obs= 20 ,and T_ext = 15"
## [1] "simulation 70 with T_obs= 14 ,and T_ext = 11"
## [1] "simulation 80 with T_obs= 15 ,and T_ext = 11"
## [1] "simulation 90 with T_obs= 13 ,and T_ext = 14"
## [1] "simulation 100 with T_obs= 12 ,and T_ext = 11"
```

```r
par(mfrow = c(3, 1))
hist(res_high[, 1], main = expression(italic(T[obs])), xlab = 'Number of transitions (T)', col = rgb(0, 0, 0.8, 0.5))
mtext('Expected T = 20')
hist(res_high[, 2], main = expression(italic(T[est])), xlab = 'Number of transitions (T)', col = rgb(0, 0.8, 0, 0.5))
hist(res_high[, 3], main = expression(italic(T[est] - T[obs])), xlab = 'Number of transitions (T)', col = rgb(0.8, 0, 0, 0.5))
```

![plot of chunk unnamed-chunk-2](figure/unnamed-chunk-2.png) 

Notes: The observed and estimated number of transitions *Tobs* and *Test* are very similar, but they are below the expected.

Simulations with medium number of transitions
======================


```r
T_num <- 10

res_med <- matrix(NA, 100, 3)
colnames(res_med) <- c('T_obs', 'T_est', 'diff')

for(i in 1:100){

  tr_sim <- sim.bd.taxa.age(n = 50, numbsim = 1, lambda = 0.5, mu = 0.0, frac = 1, age = 1.00, mrca = FALSE)[[1]]
  tr_sim$edge.length <- tr_sim$edge.length * (1 / max(branching.times(tr_sim)))
  q_high <- get_Q(tr_sim, trans_num = T_num)
  
  sim_vals <- 1
  while(sim_vals == 1){
    sim_dat <- sim.history(tr_sim, q_high)  
    sim_vals <- length(unique(sim_dat$states))
  }  
  est_dat <- rerootingMethod(tr_sim, sim_dat$states)

  #par(mfrow = c(1, 2))
  #plot(tr_sim, show.tip.label = F)
  #tiplabels(sim_dat$states)
  #nodelabels(get_node_states(sim_dat))

  #plot(sim_dat, show.tip.label = F)
  #tiplabels(sim_dat$states)
  #nodelabels(get_node_states(est_dat))

  fitted_transitions <- get_fitted_states(est_dat, sim_dat)

  T_obs <- sum(sim_dat$node.states[, 1] != sim_dat$node.states[, 2])
  T_est <- sum(fitted_transitions[, 1] != fitted_transitions[, 2])

  diff_obs_est <- T_est - T_obs
  res_med[i, ] <- c(T_obs, T_est, diff_obs_est)

  if((i %% 10) == 0)  print(paste('simulation', i, 'with T_obs=', T_obs, ',and T_ext =', T_est))	
}
```

```
## [1] "simulation 10 with T_obs= 14 ,and T_ext = 10"
## [1] "simulation 20 with T_obs= 8 ,and T_ext = 8"
## [1] "simulation 30 with T_obs= 8 ,and T_ext = 7"
## [1] "simulation 40 with T_obs= 8 ,and T_ext = 7"
## [1] "simulation 50 with T_obs= 9 ,and T_ext = 9"
## [1] "simulation 60 with T_obs= 8 ,and T_ext = 8"
## [1] "simulation 70 with T_obs= 7 ,and T_ext = 6"
## [1] "simulation 80 with T_obs= 4 ,and T_ext = 4"
## [1] "simulation 90 with T_obs= 13 ,and T_ext = 13"
## [1] "simulation 100 with T_obs= 6 ,and T_ext = 6"
```

```r
par(mfrow = c(3, 1))
hist(res_med[, 1], main = expression(italic(T[obs])), xlab = 'Number of transitions (T)', col = rgb(0, 0, 0.8, 0.5))
mtext('Expected T = 10')
hist(res_med[, 2], main = expression(italic(T[est])), xlab = 'Number of transitions (T)', col = rgb(0, 0.8, 0, 0.5))
hist(res_med[, 3], main = expression(italic(T[est] - T[obs])), xlab = 'Number of transitions (T)', col = rgb(0.8, 0, 0, 0.5))
```

![plot of chunk unnamed-chunk-3](figure/unnamed-chunk-3.png) 

Notes: There is a similar pattern to that of the simulations with *Texp* = 20, with an a number of observed transitions that is lower than the expected.

Simulations with low number of transitions
======================


```r
T_num <- 5

res_low <- matrix(NA, 100, 3)
colnames(res_low) <- c('T_obs', 'T_est', 'diff')

for(i in 1:100){

  tr_sim <- sim.bd.taxa.age(n = 50, numbsim = 1, lambda = 0.5, mu = 0.0, frac = 1, age = 1.00, mrca = FALSE)[[1]]
  tr_sim$edge.length <- tr_sim$edge.length * (1 / max(branching.times(tr_sim)))
  q_high <- get_Q(tr_sim, trans_num = T_num)
  
  sim_vals <- 1
  while(sim_vals == 1){
    sim_dat <- sim.history(tr_sim, q_high)  
    sim_vals <- length(unique(sim_dat$states))
  }  
  est_dat <- rerootingMethod(tr_sim, sim_dat$states)

  #par(mfrow = c(1, 2))
  #plot(tr_sim, show.tip.label = F)
  #tiplabels(sim_dat$states)
  #nodelabels(get_node_states(sim_dat))

  #plot(sim_dat, show.tip.label = F)
  #tiplabels(sim_dat$states)
  #nodelabels(get_node_states(est_dat))

  fitted_transitions <- get_fitted_states(est_dat, sim_dat)

  T_obs <- sum(sim_dat$node.states[, 1] != sim_dat$node.states[, 2])
  T_est <- sum(fitted_transitions[, 1] != fitted_transitions[, 2])

  diff_obs_est <- T_est - T_obs
  res_low[i, ] <- c(T_obs, T_est, diff_obs_est)

  if((i %% 10) == 0)  print(paste('simulation', i, 'with T_obs=', T_obs, ',and T_ext =', T_est))	
}
```

```
## [1] "simulation 10 with T_obs= 8 ,and T_ext = 8"
## [1] "simulation 20 with T_obs= 3 ,and T_ext = 3"
## [1] "simulation 30 with T_obs= 8 ,and T_ext = 7"
## [1] "simulation 40 with T_obs= 1 ,and T_ext = 1"
## [1] "simulation 50 with T_obs= 3 ,and T_ext = 3"
## [1] "simulation 60 with T_obs= 5 ,and T_ext = 4"
## [1] "simulation 70 with T_obs= 6 ,and T_ext = 5"
## [1] "simulation 80 with T_obs= 2 ,and T_ext = 2"
## [1] "simulation 90 with T_obs= 4 ,and T_ext = 4"
## [1] "simulation 100 with T_obs= 6 ,and T_ext = 6"
```

```r
par(mfrow = c(3, 1))
hist(res_low[, 1], main = expression(italic(T[obs])), xlab = 'Number of transitions (T)', col = rgb(0, 0, 0.8, 0.5))
mtext('Expected T = 5')
hist(res_low[, 2], main = expression(italic(T[est])), xlab = 'Number of transitions (T)', col = rgb(0, 0.8, 0, 0.5))
hist(res_low[, 3], main = expression(italic(T[est] - T[obs])), xlab = 'Number of transitions (T)', col = rgb(0.8, 0, 0, 0.5))
```

![plot of chunk unnamed-chunk-4](figure/unnamed-chunk-4.png) 

Notes: This is a more accurate reconstruction, with estimated and observed values that are simular to the observed, and low error in the estimates.


Simulations with VERY low number of transitions
======================


```r
T_num <- 3

res_low <- matrix(NA, 100, 3)
colnames(res_low) <- c('T_obs', 'T_est', 'diff')

for(i in 1:100){

  tr_sim <- sim.bd.taxa.age(n = 50, numbsim = 1, lambda = 0.5, mu = 0.0, frac = 1, age = 1.00, mrca = FALSE)[[1]]
  tr_sim$edge.length <- tr_sim$edge.length * (1 / max(branching.times(tr_sim)))
  q_high <- get_Q(tr_sim, trans_num = T_num)
  
  sim_vals <- 1
  while(sim_vals == 1){
    sim_dat <- sim.history(tr_sim, q_high)  
    sim_vals <- length(unique(sim_dat$states))
  }  
  est_dat <- rerootingMethod(tr_sim, sim_dat$states)

  #par(mfrow = c(1, 2))
  #plot(tr_sim, show.tip.label = F)
  #tiplabels(sim_dat$states)
  #nodelabels(get_node_states(sim_dat))

  #plot(sim_dat, show.tip.label = F)
  #tiplabels(sim_dat$states)
  #nodelabels(get_node_states(est_dat))

  fitted_transitions <- get_fitted_states(est_dat, sim_dat)

  T_obs <- sum(sim_dat$node.states[, 1] != sim_dat$node.states[, 2])
  T_est <- sum(fitted_transitions[, 1] != fitted_transitions[, 2])

  diff_obs_est <- T_est - T_obs
  res_low[i, ] <- c(T_obs, T_est, diff_obs_est)

  if((i %% 10) == 0)  print(paste('simulation', i, 'with T_obs=', T_obs, ',and T_ext =', T_est))	
}
```

```
## [1] "simulation 10 with T_obs= 1 ,and T_ext = 1"
## [1] "simulation 20 with T_obs= 4 ,and T_ext = 4"
## [1] "simulation 30 with T_obs= 1 ,and T_ext = 1"
## [1] "simulation 40 with T_obs= 2 ,and T_ext = 2"
## [1] "simulation 50 with T_obs= 7 ,and T_ext = 7"
## [1] "simulation 60 with T_obs= 5 ,and T_ext = 5"
## [1] "simulation 70 with T_obs= 1 ,and T_ext = 1"
## [1] "simulation 80 with T_obs= 2 ,and T_ext = 2"
## [1] "simulation 90 with T_obs= 7 ,and T_ext = 4"
## [1] "simulation 100 with T_obs= 3 ,and T_ext = 3"
```

```r
par(mfrow = c(3, 1))
hist(res_low[, 1], main = expression(italic(T[obs])), xlab = 'Number of transitions (T)', col = rgb(0, 0, 0.8, 0.5))
mtext('Expected T = 3')
hist(res_low[, 2], main = expression(italic(T[est])), xlab = 'Number of transitions (T)', col = rgb(0, 0.8, 0, 0.5))
hist(res_low[, 3], main = expression(italic(T[est] - T[obs])), xlab = 'Number of transitions (T)', col = rgb(0.8, 0, 0, 0.5))
```

![plot of chunk unnamed-chunk-5](figure/unnamed-chunk-5.png) 

Notes: This is a more accurate reconstruction, with estimated and observed values that are simular to the observed, and low error in the estimates.