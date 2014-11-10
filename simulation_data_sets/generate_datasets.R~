source('../R/functions.R')

# Simulate the following settings. Save the true tree topology and the posterior of trees

# n_tax = 50, 100, 500
# s_len = 0, 10, 20 , 50, 100, 1000


set_num <- 1:18

for(set in set_num){
  ###
  if(set == 1){
    n_tax = 50
    s_len = 0
  }

  if(set == 2){
    n_tax = 100
    s_len = 0
  }

  if(set == 3){
    n_tax = 500
    s_len = 0
  }

  ###
  if(set == 4){
    n_tax = 50
    s_len = 10
  }

  if(set == 5){
    n_tax = 100
    s_len = 10
  }

  if(set == 6){
    n_tax = 500
    s_len = 10
  }

  ###
  if(set == 7){
    n_tax = 50
    s_len = 20
  }

  if(set == 8){
    n_tax = 100
    s_len = 20
  }

  if(set == 9){
    n_tax = 500
    s_len = 20
  }

  ###
  if(set == 10){
    n_tax = 50
    s_len = 50
  }

  if(set == 11){
    n_tax = 100
    s_len = 50
  }

  if(set == 12){
    n_tax = 500
    s_len = 50
  }


  ###
  if(set == 13){
    n_tax = 50
    s_len = 100
  }

  if(set == 14){
    n_tax = 100
    s_len = 100
  }

  if(set == 15){
    n_tax = 500
    s_len = 100
  }

  ###
  if(set == 16){
    n_tax = 50
    s_len = 1000
  }

  if(set == 17){
    n_tax = 100
    s_len = 1000
  }

  if(set == 18){
    n_tax = 500
    s_len = 1000
  }

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