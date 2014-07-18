library(phangorn)
library(phytools)
library(corrplot)
library(TreeSim)
library(NELSI)
source('functions.R')


# SIMULATE CHRONOGRAM WITH ROOT HEIGHT = 1
####################################

tr_sim <- sim.bd.taxa.age(n = 50, numbsim = 1, lambda = 0.5, mu = 0.0, frac = 1, age = 1.00, mrca = FALSE)[[1]]

tr_sim$edge.length <- tr_sim$edge.length * (1 / max(branching.times(tr_sim)))

#plot(tr_sim, edge.width = 2)
#nodelabels(round(allnode.times(tr_sim)[ -1:-length(tr_sim$tip.label) ], 1))

#############################


# SIMULATE BINARY CHARACTER ALONG THE TREE
#############################


Q <- matrix(c(-0.5, 0.5, 0.5, -0.5), 2, 2)
colnames(Q) <- c('A', 'B')
rownames(Q) <- c('A', 'B')

s1 <- sim.history(tr_sim, anc = 'B', Q = Q)
#plot(s1, edge.width = 2, show.tip.label = F)
#tiplabels(s1$states, cex = 1.5)

#nodelabels(get_node_states(s1), cex = 1.5)

#corrplot(Q, method = 'number')


#    Get the sum of the branch lengths, S
#    The expected number of transitions is then just S*Q (right? I'm not completely sure).
#    So, we can get the Q that we want by just choosing a number of transitions (e.g. 1, 2, 5, 10), T, and then Q is just: Q = T/S

S <- sum(tr_sim$edge.length)



# DIAGNOSTICS
# If Q is symmetric, these two should be the same:

print_diagnostics(s1, Q)

# Tesing selecting a Q for a given number of transitions
# Set a value for a symmetric Q to obtain an expected of 5 transitions (T):



q_5 <- get_Q(tr_sim, 5)

s2 <- sim.history(tr_sim, Q = q_5, anc = 'B')



print_diagnostics(s2, q_5)

# Now test that the selection of Q works





stop('wow')
#################################

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
