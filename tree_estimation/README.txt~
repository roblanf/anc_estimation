Test tree reconstruction with different numbers of sites
========================================================

This is the summary of some analyses of simulated data in BEAST2 to select sequence length. 
I have simulated datasets with 0, 10, 150, 250, 500, 1000, and 2000 nucleotides using a tre with root-node age of 1. The branch rates are drawn from a lognormal distribution with mean 0.1 and standard deviation of 0.1 (10%). 
The restults below show the PH85 tree distance between the true and the simulated tree and the mean posterior support for data sets with different sequence lengths.


```{r}
system('cat seq_length_test.txt seq_length_test_150.txt seq_length_test_200.txt seq_length_test_250.txt seq_length_test_500.txt > seq_length_all.txt')
seq_dat1 <- read.table('seq_length_test_all.txt', head = F, as.is = T)
colnames(seq_dat1) <- c('slen', 'meanPost', 'treedist')

seq_dat1$slen <- as.factor(seq_dat1$slen)

par(bg = 'black')
par(col = 'white')
par(col.axis = 'white')
par(col.lab = 'white')
par(mar = c(4, 4, 4, 4))
col_points <- rainbow(8)
plot(seq_dat1$meanPost, seq_dat1$treedist, pch = 20, cex = 1, col = col_points[as.numeric(seq_dat1$slen)], xlab = 'Mean posterior node support', ylab = 'Distance to the true tree') #, xlim = c(0.6, 1), ylim = c(0, 20))
legend(x = 0.1, y = 40, legend = c(0, 10, 100, 150, 250, 500, 1000, 2000), fill  = col_points, title = 'Sequence length')
```



There are some strange outliers. These are probably analyses with low ESS. The trend matches the expectation that mean node support scales negatively with the distance to the true tree. We can obtain a representative set of simulations by using data sets with 0, 100, 250, 1000, and 2000



