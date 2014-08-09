library(phangorn)
library(phytools)
library(corrplot)
library(TreeSim)
library(NELSI)
source('../R/functions.R')

# Using a lognormal rate with sd of 0.3


test_1 <- get_tree_Q(tree_age = 1, taxa = 50, rate = 0.1, n_trans = 10, seq_length = 1000)

write.dna(test_1$seq_data, file = 'test_1.fasta', format = 'fasta', nbcol = -1, colsep = '')


test_2 <- get_tree_Q(tree_age = 1, taxa = 50, rate = 0.1, n_trans = 10, seq_length = 0)

write.dna(test_2$seq_data, file = 'test_2.fasta', format = 'fasta', nbcol = -1, colsep = '')

