Tesing phytools functions for ancestral character state estimation
==================================================================



```r
library(phangorn)
library(phytools)
library(geiger)
library(corrplot)
```
SIMULATE CHRONOGRAM WITH AGE OF 2 TIME UNITS
=============================================
```
tr_sim <- sim.bdtree(b = 1, d = 0, stop = 'taxa', n = 20, extinct = F)

tr_sim$edge.length <- tr_sim$edge.length * (2 / max(branching.times(tr_sim)))
```

SIMULATE BINARY CHARACTER ALONG THE TREE
=============================================

This is for a symmetric matrix with equal probability of changing from A to B


```r
par(mfrow = c(1, 2))
Q <- matrix(c(-0.5, 0.5, 0.5, -0.5), 2, 2)
colnames(Q) <- c('A', 'B')
rownames(Q) <- c('A', 'B')
```


```r
s1 <- sim.history(tr_sim, anc = 'B', Q = Q)
plot(s1, edge.width = 2, show.tip.label = F)
tiplabels(s1$states, cex = 1.5)

node_vals <- vector()
for(i in 1:(s1$Nnode)){
  node_vals[i] <- s1$node.states[((s1$edge[, 1]) == (i + length(s1$tip.label))[1]), 1][1]
}

nodelabels(node_vals, cex = 1.5)
```

![plot of chunk unnamed-chunk-3](figure/unnamed-chunk-31.png) 

```r
corrplot(Q, method = 'number')
```

![plot of chunk unnamed-chunk-3](figure/unnamed-chunk-32.png) 

ESTIMATE ANCESTRAL STATES
=============================================

The estimated Q matrix should be very similar to that used for the simulations.


```r
tip_vals <- s1$states

states_fit <- rerootingMethod(tr_sim, tip_vals, model = 'ER')

Q_fit <- states_fit$Q

states_probs <- vector()

for(j in 1:(nrow(states_fit$marginal.anc))){
      states_probs[j] <- c('A', 'B')[which.max(states_fit$marginal.anc[j,])]
}

plot(tr_sim, edge.width = 2, show.tip.label = F)
tiplabels(tip_vals, cex = 1.5)
nodelabels(states_probs, cex = 1.5)
```

![plot of chunk unnamed-chunk-4](figure/unnamed-chunk-41.png) 

```r
corrplot(Q_fit, method = 'number')
```

![plot of chunk unnamed-chunk-4](figure/unnamed-chunk-42.png) 

NOTES
====

- Use three parametrisations of the Q matrix. 

- Simulate sequence data along the trees with five sequence lengths, for high and low levels of information content.

- Estimate chronograms in BEAST with a root calibration

- Estimate Q and compare with the simulated

- We expect overestimation of Q for data sets with low posterior support and high simulation Q (and transition rates)

- In the case of low simulation values of Q, we do not expect an association with node support.



