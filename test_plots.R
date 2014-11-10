library(ggplot2)

dat_raw <- read.table('compiled_data_post.txt', head = T, as.is = T)

#dat_raw$error_min <- (dat_raw$min_t - dat_raw$sim_t) / dat_raw$sim_t
#dat_raw$error_max <- (dat_raw$max_t - dat_raw$sim_t) / dat_raw$sim_t

dat_raw$error_min <- dat_raw$min_t / dat_raw$sim_t
dat_raw$error_max <- dat_raw$max_t / dat_raw$sim_t


dat1.1 <- dat_raw
dat1.1$ntax <- factor(dat1.1$ntax)
dat1.1$slen <- factor(dat1.1$slen)

#plot1.1 <- ggplot(dat1.1, aes(x = jitter(sim_t), y = ((error_max - error_min) / 2) + error_min)) + geom_errorbar(aes(ymin = error_min , ymax = error_max), width = 0.5) + xlab('Simulated number of transitions') + ylab('Estimated number of transitions') + geom_abline(intercept = 1, slope = 0)  + xlim(0, 30) + facet_wrap(~slen + ntax, ncol = 3) + ggtitle('Estimated vs. simulated number of transitions \n(Sequence length, number of taxa)') + theme_bw() + ylim(0, 5)

plot1.1 <- ggplot(dat1.1, aes(x = jitter(exp_t), y = sim_t)) + geom_point() + facet_wrap(~ntax, ncol = 3)

#+ geom_errorbar(aes(ymin = error_min , ymax = error_max), width = 0.5) + xlab('Simulated number of transitions') + ylab('Estimated number of transitions') + geom_abline(intercept = 1, slope = 0)  + xlim(0, 30) + facet_wrap(~slen + ntax, ncol = 3) + ggtitle('Estimated vs. simulated number of transitions \n(Sequence length, number of taxa)') + theme_bw() + ylim(0, 5)


#print(plot1.1)

#stop('dechire')

#####

dat1.2 <- dat_raw
#dat1.2$ntax <- factor(paste(dat1.2$ntax, 'taxon tree'))
#dat1.2$nax <- relevel(dat1.2$ntax, ref = '50 taxon tree')

#dat1.2$slen[dat1.2$slen == 1000] <- dat1.2$slen[dat1.2$slen == 1000] - 800
#dat1.2$exp_t <- factor(paste(dat1.2$exp_t, 'expected transitions'))
#dat1.2$exp_t <- relevel(dat1.2$exp_t, ref = '3 expected transitions')

dat1.2$slen <- jitter(dat1.2$slen, amount = 2)
dat1.2$mean_post <- jitter(dat1.2$mean_post, amount = 0.02)


#plot1.2 <- ggplot(dat1.2, aes(x = slen, y =  ((error_max - error_min) / 2) + error_min)) + geom_errorbar(aes(ymin = error_min, ymax = error_max), width = 4) + xlim(0, 205) + facet_wrap(~exp_t + ntax, scales = 'free') + ylim(-2, 10) + ylab('Error in estimated number of transitions (Esitimated / simulated)') + xlab('Sequence length') + ggtitle('Errors in estimates vs. sequence length \n(Expected transitions, number of taxa)') + theme(axis.ticks = element_blank(), axis.text.x = element_blank()) + theme_bw() + geom_abline(intercept = 1, slope = 0)

plot1.2 <- ggplot(dat1.2, aes(x = mean_post, y = ((error_max - error_min) / 2) + error_min)) + geom_errorbar(aes(ymin = error_min, ymax = error_max, width = 0.0)) + facet_wrap(~exp_t + ntax, scales = 'free')+ xlab('Mean posterior node support from reconstructed trees') + theme(axis.ticks = element_blank(), axis.text.x = element_blank()) + theme_bw() + geom_abline(intercept = 1, slope = 0, col = 'black', lty = 3) + ylab (expression(paste('Estimated ', 'transitions', ' on reconstructed tree / Estimated ', 'transitions',' on true tree '))) + ylim(0, 21)  + geom_point(size = 2)+ xlim(0, 1) 


pdf(file = 'Fig1_post_500tax.pdf', useDingbats = F, width = 12, height = 7)
print(plot1.2)
dev.off()
