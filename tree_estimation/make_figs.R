
library(ggplot2)

seq_dat1 <- read.table('seq_summ1.txt', head = F, as.is = T)
colnames(seq_dat1) <- c('slen', 'meanPost', 'treedist')
seq_dat1 <- seq_dat1[seq_dat1$slen != 2000, ]


seq_dat1$slen <- as.factor(seq_dat1$slen)


p1 <- ggplot(seq_dat1, aes(x = meanPost, y = treedist, colour = slen)) + geom_point() + theme_bw()



pdf(file = 'suppfig1.pdf', useDingbats = F, width = 9, height = 7)
print(p1)
dev.off()


#plot1.2 <- ggplot(dat1.2, aes(x = slen, y =  ((error_max - error_min) / 2) + error_min)) + geom_errorbar(aes(ymin = error_min, ymax = error_max), width = 4) + xlim(0, 205) + facet_wrap(~exp_t + ntax, scales = 'free') + ylim(-2, 10) + ylab('Error in estimated number of transitions (Esitimated / simulated)') + xlab('Sequence length') + ggtitle('Errors in estimates vs. sequence length \n(Expected transitions, number of taxa)') + theme(axis.ticks = element_blank(), axis.text.x = element_blank()) + theme_bw() + geom_abline(intercept = 1, slope = 0)







stop('arrete')


par(bg = 'black')
par(col = 'white')
par(col.axis = 'white')
par(col.lab = 'white')
par(mar = c(4, 4, 4, 4))
col_points <- rainbow(9)
plot(seq_dat1$meanPost, seq_dat1$treedist, pch = 20, cex = 2, col = col_points[as.numeric(seq_dat1$slen)], xlab = 'Mean posterior node support', ylab = 'Distance to the true tree')#, xlim = c(0.6, 1), ylim = c(0, 50))
legend(x = 0.1, y = 40, legend = c(0, 10, 20, 50, 100, 200, 500, 1000, 2000), fill  = col_points, title = 'Sequence length')

