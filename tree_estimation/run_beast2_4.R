source('../R/functions.R')

#~/Desktop/progs/beast2/bin/beast

#0, 10, 20, 50, 100, 200, 500, 1000, 2000


s_len = 0
for(i in 1:10){

sim_dat1 <- get_tree_Q(tree_age = 1, taxa = 50, rate = 0.1, n_trans = 10, seq_length = s_len)
#write.dna(sim_dat1$seq_data, file = 'sdat_temp_150.fasta', format = 'fasta', nbcol = -1, colsep = '')

file_dat1 <- make_beast_xml(sim_dat1$seq_data, f_name = 'test_dat0', min_root = 0.9, max_root = 1.1)
cat(file_dat1, file= 'test_dat0.xml', sep = '\n')

out_test1 <- run_beast(xml_path = 'test_dat0.xml', beast2_path = '~/Desktop/progs/beast2/bin/beast -overwrite -beagle', tree_ann_path = '~/Desktop/progs/beast2/bin/treeannotator -burnin 10')
#system('rm out_temp.tree')
cat(paste(s_len, mean(out_test1$node_support), out_test1$dist_t_tre, sep = ' '), file = 'seq_length_test0.txt', sep = '\n', append = T)

}

s_len = 10
for(i in 1:10){

sim_dat1 <- get_tree_Q(tree_age = 1, taxa = 50, rate = 0.1, n_trans = 10, seq_length = s_len)
#write.dna(sim_dat1$seq_data, file = 'sdat_temp_150.fasta', format = 'fasta', nbcol = -1, colsep = '')

file_dat1 <- make_beast_xml(sim_dat1$seq_data, f_name = 'test_dat10', min_root = 0.9, max_root = 1.1)
cat(file_dat1, file= 'test_dat10.xml', sep = '\n')

out_test1 <- run_beast(xml_path = 'test_dat10.xml', beast2_path = '~/Desktop/progs/beast2/bin/beast -overwrite -beagle', tree_ann_path = '~/Desktop/progs/beast2/bin/treeannotator -burnin 10')
#system('rm out_temp.tree')
cat(paste(s_len, mean(out_test1$node_support), out_test1$dist_t_tre, sep = ' '), file = 'seq_length_test10.txt', sep = '\n', append = T)

}

s_len = 20
for(i in 1:10){

sim_dat1 <- get_tree_Q(tree_age = 1, taxa = 50, rate = 0.1, n_trans = 20, seq_length = s_len)
#write.dna(sim_dat1$seq_data, file = 'sdat_temp_150.fasta', format = 'fasta', nbcol = -1, colsep = '')

file_dat1 <- make_beast_xml(sim_dat1$seq_data, f_name = 'test_dat20', min_root = 0.9, max_root = 1.1)
cat(file_dat1, file= 'test_dat20.xml', sep = '\n')

out_test1 <- run_beast(xml_path = 'test_dat20.xml', beast2_path = '~/Desktop/progs/beast2/bin/beast -overwrite -beagle', tree_ann_path = '~/Desktop/progs/beast2/bin/treeannotator -burnin 20')
#system('rm out_temp.tree')
cat(paste(s_len, mean(out_test1$node_support), out_test1$dist_t_tre, sep = ' '), file = 'seq_length_test20.txt', sep = '\n', append = T)

}

s_len = 50
for(i in 1:10){

sim_dat1 <- get_tree_Q(tree_age = 1, taxa = 50, rate = 0.1, n_trans = 50, seq_length = s_len)
#write.dna(sim_dat1$seq_data, file = 'sdat_temp_150.fasta', format = 'fasta', nbcol = -1, colsep = '')

file_dat1 <- make_beast_xml(sim_dat1$seq_data, f_name = 'test_dat50', min_root = 0.9, max_root = 1.1)
cat(file_dat1, file= 'test_dat50.xml', sep = '\n')

out_test1 <- run_beast(xml_path = 'test_dat50.xml', beast2_path = '~/Desktop/progs/beast2/bin/beast -overwrite -beagle', tree_ann_path = '~/Desktop/progs/beast2/bin/treeannotator -burnin 50')
#system('rm out_temp.tree')
cat(paste(s_len, mean(out_test1$node_support), out_test1$dist_t_tre, sep = ' '), file = 'seq_length_test50.txt', sep = '\n', append = T)

}


