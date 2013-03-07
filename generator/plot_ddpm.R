#Plot High Speed Induction Generator

#setwd("./generator/")
ddpm_generator <- read.delim("ddpm-generator-data.txt")

#Set colors
require("RColorBrewer")
colors = brewer.pal(3,"Dark2")

plot(ddpm_generator$Torque.kNm, ddpm_generator$Mass.t,pch=21, lwd=2, cex=1.5, 
     col=colors[1], bty="l", xlim=c(0,10000),las=1,
     xlab="Torque (kNm)", ylab="Mass (t)")
grid()

linear_estimation<-lm(Mass.t ~ Torque.kNm, data=ddpm_generator)
abline(linear_estimation, col="gray", lwd=2, lty=2)

# display equation
linear_coefficients <- round(coef(linear_estimation), 3) 
mtext(bquote(Mass(t) == .(linear_coefficients[2])*Torque (kNm) + .(round(linear_coefficients[1],1))), adj=1, padj=7)

