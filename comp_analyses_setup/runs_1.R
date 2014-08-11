source('../R/functions.R')
#  Seq length :0, 100, 250, 1000, 2000
# Trans expected: 20, 10, 5, 2

# Recod seq length, mean posterior, dist to true tree, expected trans, estimated trans

# 0 data 
s_len = 100
trans = 4



for(i in 1:10){

sim_dat <- get_tree_Q(tree_age = 1, taxa = 50, rate = 0.1, n_trans = trans, seq_length = s_len)

file_dat <- make_beast_xml(sim_dat$seq_data, f_name = 's_dat', min_root = 0.9, max_root = 1.1)
cat(file_dat, file = 's_dat.xml', sep = '\n')

run_temp <- run_beast(sim_dat = sim_dat, xml_path = 's_dat.xml', beast2_path = '~/Desktop/progs/beast2/bin/beast -overwrite -beagle', tree_ann_path = '~/Desktop/progs/beast2/bin/treeannotator -burnin 10', print_results = F)

fit_states <- rerootingMethod(run_temp$est_tree, x = sim_dat$tip_states)

est_trans <-  get_fitted_states(fit_states, sim_dat$tip_states, run_temp$est_tree)

est_trans <- sum(sapply(1:nrow(est_trans), function(x) est_trans[x, 1] != est_trans[x, 2]))

res_run <- c(s_len, mean(run_temp$node_support), run_temp$dist_t_tre, sim_dat$numb_trans, est_trans)

print(res_run)

cat(paste(res_run, collapse = ' '), file = 'testing1.txt', sep= '\n', append = T)

}