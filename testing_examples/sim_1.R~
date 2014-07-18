library(phangorn)
library(phytools)
library(geiger)
library(corrplot)

# SIMULATE CHRONOGRAM WITH AGE OF 1

tr_sim <- sim.bdtree(b = 1, d = 0, stop = 'taxa', n = 20, extinct = F)

tr_sim$edge.length <- tr_sim$edge.length * (2 / max(branching.times(tr_sim)))

par(mfrow = c(2, 2))

# SIMULATE BINARY CHARACTER ALONG THE TREE

Q <- matrix(c(-0.5, 0.5, 0.5, -0.5), 2, 2)
colnames(Q) <- c('A', 'B')
rownames(Q) <- c('A', 'B')

s1 <- sim.history(tr_sim, anc = 'B', Q = Q)
plot(s1, edge.width = 2, show.tip.label = F)
tiplabels(s1$states, cex = 1.5)

node_vals <- vector()
for(i in 1:(s1$Nnode)){
  node_vals[i] <- s1$node.states[((s1$edge[, 1]) == (i + length(s1$tip.label))[1]), 1][1]
}

nodelabels(node_vals, cex = 1.5)

corrplot(Q, method = 'number')


# ESTIMATE ANCESTRAL STATES

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

corrplot(Q_fit, method = 'number')
