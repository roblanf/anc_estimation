Ancestral reconstruction bias
==============================

Seabastian Duchene

Jul 17 2014

Select settings for simulations:
--------------------------------

- [~~Select *Q* based on a given number of transitions.~~](https://github.com/sebastianduchene/anc_estimation/tree/tesing_examples/test_Q)

- [~~Check that T_expected (*Texp*) corresponds to T_observed (*Tobs*) in simulations, and compare with the estimated (*Test*) using the correct tree.~~](https://github.com/sebastianduchene/anc_estimation/tree/tesing_examples/test_Trans_estimates)

- [~~Make BEAST file with matching substitution, tree, and clock models. Set the calibration to the root age used to simulate the data.~~](https://github.com/sebastianduchene/anc_estimation/tree/tesing_examples/tree_estimation)

  - Make function to run beast2, and tree annotator.

  - Make function to read annotated tree and get posterior probs of nodes.

  - Try tree reconstruction with 0, 10, 100, and 1000, with a rate of 0.1. Get mean posterior for each of these and dist.topo for the true and the estimated tree.

- Set 3 transitions rates and sequence lengths, for a total of 9 (3*3) simulation settings. Use these to simulate sequence data along the trees. Note that for the simulation data, the taxon states are in the output of the function get_tree_Q.


- Make function to run the BEAST file from R and obtain the HCC tree after the run.

- Write function to get the MPS, *Tobs*, *Test* with the HCC tree, and number of variable sites.

- Run a total of 100 replicates per simulation setting.