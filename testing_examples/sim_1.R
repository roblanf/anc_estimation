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

plot(tr_sim, edge.width = 2)
nodelabels(round(allnode.times(tr_sim)[ -1:-length(tr_sim$tip.label) ], 1))

#############################


# SIMULATE BINARY CHARACTER ALONG THE TREE
#############################

par(mfrow = c(2, 1))

Q <- matrix(c(-0.5, 0.5, 0.5, -0.5), 2, 2)
colnames(Q) <- c('A', 'B')
rownames(Q) <- c('A', 'B')

s1 <- sim.history(tr_sim, anc = 'B', Q = Q)
plot(s1, edge.width = 2, show.tip.label = F)
tiplabels(s1$states, cex = 1.5)

nodelabels(get_node_states(s1), cex = 1.5)

corrplot(Q, method = 'number')


#    Get the sum of the branch lengths, S
#    The expected number of transitions is then just S*Q (right? I'm not completely sure).
#    So, we can get the Q that we want by just choosing a number of transitions (e.g. 1, 2, 5, 10), T, and then Q is just: Q = T/S

S <- sum(tr_sim$edge.length)

# If Q is symmetric, these two should be the same:
expected_trans_AB <- S * Q[2, 1]
expected_trans_BA <- S * Q[1, 2]

observed_trans_AB <- sum((s1$node.states[, 1] == 'A') & (s1$node.states[, 2] == 'B'))
observed_trans_BA <- sum((s1$node.states[, 1] == 'B') & (s1$node.states[, 2] == 'A'))


print(paste("Expected A -> B transitions", expected_trans_AB))
print(paste("Observed A -> B transitions", observed_trans_AB))

print(paste("Expected B -> A transitions", expected_trans_BA))
print(paste("Observed B -> A transitions", observed_trans_BA))

print(paste("The EXPECTED total number of transitions is:", expected_trans_AB))
print(paste("The OBSERVED total number of transitions is:", sum(s1$node.states[, 1] != s1$node.states[, 2])))



# Tesing selecting a Q for a given number of transitions
# Set a value for a symmetric Q to obtain an expected of 5 transitions (T):
T <- 5
trans_prob <- T /S
q_5 <- matrix( c(-trans_prob, trans_prob, trans_prob, -trans_prob), 2, 2)
colnames(q_5) <- c('A', 'B')
rownames(q_5) <- colnames(q_5)

s2 <- sim.history(tr_sim, Q = q_5, anc = 'B')






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
