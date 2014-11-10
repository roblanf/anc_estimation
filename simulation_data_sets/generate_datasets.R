source('../R/functions.R')



#This code generates 10 data sets according to the simulations settings in settings_data.csv. For each simulated data set it makes the BEAST2 xml file and it saves the tree topology

# Read settings:
sim_settings <- read.table('settings_data.csv', head = T, sep = ',')

for(set in 1:nrow(sim_settings)){

  n_tax <- sim_settings$n_tax[set]
  s_len <- sim_settings$s_len[set]

  print(paste0('Simulating set', set))
  system(paste0('mkdir set', set))
  setwd(paste0('set', set))
  for(i in 1:10){
      print(paste0('making set', set, '_', i, '.xml'))
      sim_temp <- get_tree_Q(taxa = n_tax, seq_length = s_len)
      tre_temp <- sim_temp$phylogram
      seq_temp <- sim_temp$seq_data
      xml_temp <- make_beast_xml(seq_data = seq_temp, f_name = paste0('set', set, '_', i), min_root = 0.9, max_root = 1.1)
      cat(xml_temp, file= paste0('set', set, '_', i, '.xml'), sep = '\n')
      write.tree(tre_temp, file = paste0('set', set, '_', i, '.tree '))
  }
  setwd('..')
}