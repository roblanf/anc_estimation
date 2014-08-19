# Read data and load ggplot2

library(ggplot2)

dat <- read.table('test_runs_post_1.txt')
colnames(dat) <- c('slen', 'mps', 'tr_dist', 'sim_trans', 'est_hcc', 'est_mean', 'est_sd')

bin_trans <- cut(dat$sim_trans, c(0, 5, 10, 100))
levels(bin_trans) <- c('T=5', 'T=10', 'T=20')
bias_hcc <- dat$est_hcc - dat$sim_trans
bias_post <- dat$est_mean - dat$sim_trans
#est_se <-  (dat$est_sd / sqrt(100))
est_se <- 1.96 * (dat$est_sd / sqrt(100))


dat <- cbind(dat, bin_trans, bias_hcc, bias_post, est_se)

dat$slen <- as.factor(dat$slen)

#par(mfrow = c(1, 3))
#par(mar = c(5, 5, 5, 5))
#par(bg = 'black')
#par(col = 'white')
#par(col.axis = 'white')
#par(col.lab = 'white')
#cols_plots <- rainbow(7)

#dat_A <- dat[dat$bin_trans == 'A', ]

#plot_A <- ggplot(dat_A, aes(x = mps, y = bias_post, colour = slen)) + geom_errorbar(aes(ymin = bias_post - est_se, ymax = bias_post + est_se), width = 0.05) + geom_point() + xlab('Mean posterior node support') + ylab('Estimated - Simulated number of transitions') + scale_colour_discrete(name = 'Sequence length') + ggtitle('Bias in estimated number of transitions')
print(plot_A)

#dat_B <- dat[dat$bin_trans == 'B', ]

#plot_B <- ggplot(dat_B, aes(x = mps, y = bias_post, colour = slen)) + geom_errorbar(aes(ymin = bias_post - est_se, ymax = bias_post + est_se), width = 0.05) + geom_point() + xlab('Mean posterior node support') + ylab('Estimated - Simulated number of transitions') + scale_colour_discrete(name = 'Sequence length') + ggtitle('Expected transitions = 5')
print(plot_B)


plot_all <- ggplot(dat, aes(x = mps, y = bias_post, colour = slen)) + geom_errorbar(aes(ymin = bias_post - est_se, ymax = bias_post + est_se), width = 0.05) + geom_point() + xlab('Mean posterior node support') + ylab('Estimated - Simulated number of transitions') + scale_colour_discrete(name = 'Sequence length') + ggtitle('Bias in estimated number of transitions') + facet_grid(. ~ bin_trans)
print(plot_all)





#plot(dat_A$mps, dat_A$bias_post)
#points(dat_A$mps, dat_A$bias_post + dat_A$est_se, col = 'red', pch = 20 , cex = 0.5)
#points(dat_A$mps, dat_A$bias_post - dat_A$est_se, col = 'red', pch = 20, cex = 0.5)

