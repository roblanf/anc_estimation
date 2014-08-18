source('../../R/functions.R')
#  Seq length :0, 50, 100, 250, 1000, 2000
# Trans expected: 20, 10, 5, 2

# Recod seq length, mean posterior, dist to true tree, expected trans, estimated trans

# 0 data, 100 replicates per number of transitions expected
s_len = 250
trans = rep(c(2, 5, 10, 20), 10)

for(i in 1:length(trans)){

sim_dat <- get_tree_Q(tree_age = 1, taxa = 50, rate = 0.1, n_trans = trans[i], seq_length = s_len)

file_dat <- make_beast_xml(sim_dat$seq_data, f_name = 's_dat', min_root = 0.9, max_root = 1.1)
cat(file_dat, file = 's_dat.xml', sep = '\n')

run_temp <- run_beast(sim_dat = sim_dat, xml_path = 's_dat.xml', beast2_path = '~/Desktop/progs/beast2/bin/beast -overwrite -beagle', tree_ann_path = '~/Desktop/progs/beast2/bin/treeannotator -burnin 10', print_results = F)

fit_states_hcc <- rerootingMethod(run_temp$est_tree, x = sim_dat$tip_states)
est_trans_hcc <-  get_fitted_states(fit_states_hcc, sim_dat$tip_states, run_temp$est_tree)
est_trans_hcc <- sum(sapply(1:nrow(est_trans_hcc), function(x) est_trans_hcc[x, 1] != est_trans_hcc[x, 2]))



est_trans_post <- vector()

for(m in (length(run_temp$post_trees) - 50):length(run_temp$post_trees)){
      print(paste('estimating for tree', m))
      fit_states_temp <- rerootingMethod(run_temp$post_trees[[m]], x = sim_dat$tip_states)
      est_trans_temp <- get_fitted_states(fit_states_temp, sim_dat$tip_states, run_temp$post_trees[[m]])
      est_trans_temp <- sum(sapply(1:nrow(est_trans_temp), function(x) est_trans_temp[x, 1] != est_trans_temp[x, 2]))
      est_trans_post <- c(est_trans_post, est_trans_temp)
      print(paste('n is ', est_trans_temp))
}




res_run <- c(s_len, mean(run_temp$node_support), run_temp$dist_t_tre, sim_dat$numb_trans, est_trans_hcc, mean(est_trans_post), sd(est_trans_post))

print(res_run)

cat(paste(res_run, collapse = ' '), file = 'testing250.txt', sep= '\n', append = T)

}