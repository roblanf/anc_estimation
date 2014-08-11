source('../R/functions.R')

#~/Desktop/progs/beast2/bin/beast


s_len = 500
for(i in 1:100){

sim_dat1 <- get_tree_Q(tree_age = 1, taxa = 50, rate = 0.1, n_trans = 10, seq_length = s_len)
write.dna(sim_dat1$seq_data, file = 'sdat_temp.fasta', format = 'fasta', nbcol = -1, colsep = '')

file_dat1 <- make_beast_xml(sim_dat1$seq_data, f_name = 'test_dat1', min_root = 0.9, max_root = 1.1)
cat(file_dat1, file= 'test_dat1.xml', sep = '\n')

out_test1 <- run_beast(xml_path = 'test_dat1.xml', beast2_path = '~/Desktop/progs/beast2/bin/beast -overwrite -beagle', tree_ann_path = '~/Desktop/progs/beast2/bin/treeannotator -burnin 10')
#system('rm out_temp.tree')
cat(paste(s_len, mean(out_test1$node_support), out_test1$dist_t_tre, sep = ' '), file = 'seq_length_test.txt', sep = '\n', append = T)

}

