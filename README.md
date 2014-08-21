Ancestral reconstruction bias
==============================

Seabastian Duchene


Aug 21 2014

New simulations:
--------------

Inherent bias
-------------

	 - Estimated trans with true tree vs. simulated number of transitions (this is the inherent bias of the method. We expect that the 'saturation point' will depend on the number of taxa)

	   - 1000 taxa
	   - 100 taxa
	   - 50 taxa

	 - Estimated trans with 1000 nuc tree vs. simulated trans (This sholud be similar to the previous simulation, with a trend line that increases and slowly saturates)

	   - 1000 taxa
	   - 100 taxa
	   - 50 taxa

	 - Estimated trans with 100 nuc tree vs. simulated trans (I expect that this will be a flat line for a high number of transitions)

	   - 1000 taxa
	   - 100 taxa
	   - 50 taxa


Bias for different number of transitions (T), taxa (N), and sequence lengths (l) vs. bias
-----------------------------------------------------------------------------------------

Note that in this context we refer to bias as T estimated with the posterior - T estimated with the true tree

	- T = 3, 10, 30
	
	- N = 50, 100, 500

	- l = 0, 10, 20, 50, 100, 1000

Note that we only need ~ 10 tres per sequence length and number of taxa, which results in 180 runs
	








Simulate 10 trees for each 



Aug 11 2014

Currently runnig:
----------------

Folder comp_analyses_setup is runnig some of the settings. They are recording the sequence length, mean node support, distance to the true tree, simulated number of transitions, and estimated number of transitions.
These results can be compiled. They should be binned by simulated number of transitions. The different binnings can be plotted as: estimated transitions - simulated transitions vs. mean posterior support.


Select settings for simulations:
--------------------------------

- [~~Select *Q* based on a given number of transitions.~~](https://github.com/sebastianduchene/anc_estimation/tree/tesing_examples/test_Q)

- [~~Check that T_expected (*Texp*) corresponds to T_observed (*Tobs*) in simulations, and compare with the estimated (*Test*) using the correct tree.~~](https://github.com/sebastianduchene/anc_estimation/tree/tesing_examples/test_Trans_estimates)

- [~~Make BEAST file with matching substitution, tree, and clock models. Set the calibration to the root age used to simulate the data.~~](https://github.com/sebastianduchene/anc_estimation/tree/tesing_examples/tree_estimation)

  - ~~Make function to run beast2, and tree annotator.~~

  - ~~Make function to read annotated tree and get posterior probs of nodes.~~

  - ~~Try tree reconstruction with 0, 10, 100, and 1000, with a rate of 0.1. Get mean posterior for each of these and dist.topo for the true and the estimated tree.~~

- [~~Set 3 transitions rates and sequence lengths, for a total of 9 (3*3) simulation settings. Use these to simulate sequence data along the trees. Note that for the simulation data, the taxon states are in the output of the function get_tree_Q.~~](https://github.com/sebastianduchene/anc_estimation/tree/tesing_examples/comp_analyses_setup)


 - ~~Make function to run the BEAST file from R and obtain the HCC tree after the run.~~

- ~~Write function to get the MPS, *Tobs*, *Test* with the HCC tree, and number of variable sites.~~

- ~~Run a total of 100 replicates per simulation setting.~~