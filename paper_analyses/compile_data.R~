
set1 <- matrix(c(rep(c(0, 50, 3), 10), rep(c(0, 50, 10), 10), rep(c(0, 50, 30), 10)), 30, 3, byrow = T)
set2 <- matrix(c(rep(c(0, 100, 3), 10), rep(c(0, 100, 10), 10), rep(c(0, 100, 30), 10)), 30, 3, byrow = T)
set3 <- matrix(c(rep(c(0, 500, 3), 10), rep(c(0, 500, 10), 10), rep(c(0, 500, 30), 10)), 30, 3, byrow = T)


set4 <- matrix(c(rep(c(10, 50, 3), 10), rep(c(10, 50, 10), 10), rep(c(10, 50, 30), 10)), 30, 3, byrow = T)
set5 <- matrix(c(rep(c(10, 100, 3), 10), rep(c(10, 100, 10), 10), rep(c(10, 100, 30), 10)), 30, 3, byrow = T)
set6 <- matrix(c(rep(c(10, 500, 3), 10), rep(c(10, 500, 10), 10), rep(c(10, 500, 30), 10)), 30, 3, byrow = T)

set7 <- matrix(c(rep(c(20, 50, 3), 10), rep(c(20, 50, 10), 10), rep(c(20, 50, 30), 10)), 30, 3, byrow = T)
set8 <- matrix(c(rep(c(20, 100, 3), 10), rep(c(20, 100, 10), 10), rep(c(20, 100, 30), 10)), 30, 3, byrow = T)
set9 <- matrix(c(rep(c(20, 500, 3), 10), rep(c(20, 500, 10), 10), rep(c(20, 500, 30), 10)), 30, 3, byrow = T)

set10 <- matrix(c(rep(c(50, 50, 3), 10), rep(c(50, 50, 10), 10), rep(c(50, 50, 30), 10)), 30, 3, byrow = T)
set11 <- matrix(c(rep(c(50, 100, 3), 10), rep(c(50, 100, 10), 10), rep(c(50, 100, 30), 10)), 30, 3, byrow = T)
set12 <- matrix(c(rep(c(50, 500, 3), 10), rep(c(50, 500, 10), 10), rep(c(50, 500, 30), 10)), 30, 3, byrow = T)

set13 <- matrix(c(rep(c(100, 50, 3), 10), rep(c(100, 50, 10), 10), rep(c(100, 50, 30), 10)), 30, 3, byrow = T)
set14 <- matrix(c(rep(c(100, 100, 3), 10), rep(c(100, 100, 10), 10), rep(c(100, 100, 30), 10)), 30, 3, byrow = T)
set15 <- matrix(c(rep(c(100, 500, 3), 10), rep(c(100, 500, 10), 10), rep(c(100, 500, 30), 10)), 30, 3, byrow = T)

set16 <- matrix(c(rep(c(1000, 50, 3), 10), rep(c(1000, 50, 10), 10), rep(c(1000, 50, 30), 10)), 30, 3, byrow = T)
set17 <- matrix(c(rep(c(1000, 100, 3), 10), rep(c(1000, 100, 10), 10), rep(c(1000, 100, 30), 10)), 30, 3, byrow = T)
set18 <- matrix(c(rep(c(1000, 500, 3), 10), rep(c(1000, 500, 10), 10), rep(c(1000, 500, 30), 10)), 30, 3, byrow = T)

folders <- paste0('set', 1:18)

compiled_mat <- matrix(NA, 1, 7)
colnames(compiled_mat) <- c('slen', 'ntax', 'exp_t', 'set_name', 'sim_t', 'min_t', 'max_t')

for(i in folders){

      mat3 <- read.table(paste0(i, '/3res_matrix_20t.txt'), head = T)
      mat10 <- read.table(paste0(i, '/10res_matrix_20t.txt'), head = T)
      mat30 <- read.table(paste0(i, '/30res_matrix_20t.txt'), head = T)
      mat_all <- rbind(mat3, mat10, mat30)

      mat_set <- get(i)
      mat_concat <- as.matrix(cbind(mat_set, mat_all))
      compiled_mat <- rbind(compiled_mat, mat_concat)
      print(mat_concat)
}


write.table(compiled_mat, file = 'compiled_data.txt', quote = F, row.names = F) 