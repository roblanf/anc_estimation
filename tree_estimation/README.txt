Test tree reconstruction with different numbers of sites
========================================================

This is the summary of some analyses of simulated data in BEAST2 to select sequence length. 
I have simulated datasets with 0, 10, 150, 250, 500, 1000, and 2000 nucleotides using a tre with root-node age of 1. The branch rates are drawn from a lognormal distribution with mean 0.1 and standard deviation of 0.1 (10%). 
The restults below show the PH85 tree distance between the true and the simulated tree and the mean posterior support for data sets with different sequence lengths.


```{r}


seq_dat1 <- read.table('seq_summ1.txt', head = F, as.is = T)
colnames(seq_dat1) <- c('slen', 'meanPost', 'treedist')

seq_dat1$slen <- as.factor(seq_dat1$slen)

par(bg = 'black')
par(col = 'white')
par(col.axis = 'white')
par(col.lab = 'white')
par(mar = c(4, 4, 4, 4))
col_points <- rainbow(9)
plot(seq_dat1$meanPost, seq_dat1$treedist, pch = 20, cex = 2, col = col_points[as.numeric(seq_dat1$slen)], xlab = 'Mean posterior node support', ylab = 'Distance to the true tree')#, xlim = c(0.6, 1), ylim = c(0, 50))
legend(x = 0.1, y = 40, legend = c(0, 10, 20, 50, 100, 200, 500, 1000, 2000), fill  = col_points, title = 'Sequence length')




```



This has very few outliers. The relationship looks more linear than last time.


