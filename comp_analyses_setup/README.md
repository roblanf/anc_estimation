Preliminary results
==================


Load data. Include a variable for the bias in the estimated number of transitions


```r
dat <- read.table('test_runs_1.txt')
dat <- cbind(dat, (dat[, 5] - dat[, 4]) ) # / dat[, 5])
```

Bin the number of simulated transitions as follows:

High:  x>=10
Median: 5<=x<10
Low: x<5



```r
colnames(dat) <- c('slen', 'posterior', 'treedist', 'sim_trans', 'est_trans', 'bias')
dat$slen <- as.factor(dat$slen)

h_trans <- which(dat$sim_trans >= 10)
m_trans <- which(dat$sim_trans < 10 & dat$sim_trans >= 5)
l_trans <- which(dat$sim_trans < 5)
```



Plot mean posterior node support vs the bias.


```r
par(mfrow = c(1, 3))
par(mar = c(5, 5, 5, 5))
#par(bg = 'black')
#par(col = 'white')
#par(col.axis = 'white')
#par(col.lab = 'white')
cols_plots <- rainbow(4)

plot(dat$posterior[h_trans], dat$bias[h_trans], pch = 20, ylim = c(-20, 20), col = cols_plots[dat$slen[h_trans]], cex = 2, xlab = 'Mean posterior node support', ylab = 'Simulated transitions - Estimated transitions', cex.lab = 1.5)
lines(x = c(0, 1), y = c(0, 0), col = 'black', lwd = 2)
legend(x = 0.6, y = 15, bty = 'n', legend = c('0', '50', '100', '250'), fill = cols_plots, title = 'Sequence length', cex = 2)
text(x = 0.3, y = 20, labels = expression(bold('High number of transitions (T>=10)')), cex = 1.5)

plot(dat$posterior[m_trans], dat$bias[m_trans], pch = 20, ylim = c(-20, 20), col = cols_plots[dat$slen[m_trans]], cex = 2, xlab = 'Mean posterior node support', ylab = '', cex.lab = 1.5)
lines(x = c(0, 1), y = c(0, 0), col = 'black', lwd = 2 )
text(x = 0.35, y = 20, labels = expression(bold('Medium number of transitions (5<=T<10)')), cex = 1.5)

plot(dat$posterior[l_trans], dat$bias[l_trans], pch = 20, ylim = c(-20, 20), col = cols_plots[dat$slen[l_trans]], cex = 2, xlab = 'Mean posterior node support', ylab = '', cex.lab = 1.5)
lines(x = c(0, 1), y = c(0, 0), col = 'black' , lwd = 2)
text(x = 0.3, y = 20, labels = expression(bold('Low number of transitions (T<5)')), cex = 1.5)
```

![plot of chunk unnamed-chunk-3](figure/grey_plot.png) 

Future runs
==========

- Inlclude sequence lengths of 10 and 20 to fill the gap of the mean posterior support in the range of 0 to 0.3. 


Notes
----
- Use scripts in runs_X folders