


seq_dat1 <- read.table('seq_length_test_all.txt', head = F, as.is = T)
colnames(seq_dat1) <- c('slen', 'meanPost', 'treedist')

seq_dat1$slen <- as.factor(seq_dat1$slen)

par(bg = 'black')
par(col = 'white')
par(col.axis = 'white')
par(col.lab = 'white')
par(mar = c(4, 4, 4, 4))
col_points <- rainbow(8)
plot(seq_dat1$meanPost, seq_dat1$treedist, pch = 20, cex = 1.3, col = col_points[as.numeric(seq_dat1$slen)], xlab = 'Mean posterior node support', ylab = 'Distance to the true tree')#, xlim = c(0.6, 1), ylim = c(0, 50))
legend(x = 0.1, y = 40, legend = c(0, 10, 100, 150, 250, 500, 1000, 2000), fill  = col_points, title = 'Sequence length')


