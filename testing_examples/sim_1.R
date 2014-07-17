library(phangorn)
library(phytools)
library(geiger)


# SIMULATE CHRONOGRAM WITH AGE OF 1

tr_sim <- sim.bdtree(b = 1, d = 0, stop = 'taxa', n = 10, extinct = F)

tr_sim$edge.length <- tr_sim$edge.length * (1 / max(branching.times(tr_sim)))

plot(tr_sim, edge.width = 2)
nodelabels(round(branching.times(tr_sim), 2))


# SIMULATE BINARY CHARACTER ALONG THE TREE

Q <- matrix(c(-0.5, 0.5, 0.5, -0.5), 2, 2)
colnames(Q) <- c('A', 'B')
rownames(Q) <- c('A', 'B')

s1 <- sim.history(tr_sim, Q)
plot(s1, edge.width = 2, show.tip.label = F)
tiplabels(s1$states)

node_vals <- vector()
for(i in 1:(s1$Nnode)){
  node_vals[i] <- s1$node.states[((s1$edge[, 1]) == (i + length(s1$tip.label))[1]), 1][1]
}

nodelabels(node_vals)

# ESTIMATE ANCESTRAL STATES