Ancestral reconstruction bias
==============================

Seabastian Duchene

Jul 17 2014

Select settings for simulations:
--------------------------------

- [~~Select *Q* based on a given number of transitions.~~](https://github.com/sebastianduchene/anc_estimation/tree/tesing_examples/test_Q)

- [~~Check that T_expected (*Texp*) corresponds to T_observed (*Tobs*) in simulations, and compare with the estimated (*Test*) using the correct tree.~~](https://github.com/sebastianduchene/anc_estimation/tree/tesing_examples/test_Trans_estimates)

- Set 3 transitions and 3 substitution rates, for a total of 9 (3*3) simulation settings. Use these to simulate sequence data along the trees. Each substitution rate value should produce different numbers of variable sites, ranging from low (~0.05), medium (~0.1), and high (~0.5). For a sequence length of 1000 nucleotides. For the simulations of the sequence data, append the character state to the taxon name.

- Make BEAST file with matching substitution, tree, and clock models. Set the calibration to the root age used to simulate the data.

- Make function to run the BEAST file from R and obtain the HCC tree after the run.

- Write function to get the MPS, *Tobs*, *Test* with the HCC tree, and number of variable sites.

- Run a total of 100 replicates per simulation setting.