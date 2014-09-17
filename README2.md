This folder contains the runs for the ancestral state reconstructions. The settings are described in generate_datasets.R
The folder for each of the settings contains the estimated trees, the simulatied tree, and the log files. 

# Next steps:

## Inherent bias:
	- For each true tree, simulate 3, 10, and 30 transitions
	- re-estimate the number of transitions with the estimated tree
	- Do the previous two steps for sequence lengths of:
	  - 0 
	  - 10
	  - 20
	  - 50
	  - 100
	  - 1000 ( This sholud be similar to the tree truee)

	 - In each case use three numbers of taxa 50, 100, and 500
	 *The trees are currently being estimated in ~/Desktop/anc_state_runs/*

	 - For each sequence length Plot Estimated vs. simulated number of transitions and colour by number of taxa, to produce seven plots (true tree, and six sequence lengths)

## Simulate 3, 10 and 30 transitions over each tree and each number of taxa:
   - For each combination of number of simulated transitions and number of taxa plot the error in the estimated number of transitions (with 95% credible interval) vs. the mean posterior support (analogous to sequence length). This sholud result in 9 plots (3 ntax and 3 nsubst)



