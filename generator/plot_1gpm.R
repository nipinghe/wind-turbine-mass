## @knitr plot1gpm
#Plot High Speed Induction Generator

setwd("../generator/")
g1pm_generator <- read.delim("1GPM-generator-data.txt")

#Set colors
#require("RColorBrewer", quietly=TRUE)
colors = brewer.pal(3,"Dark2")

plot(g1pm_generator$Torque.kNm, g1pm_generator$Mass.t,pch=21,  
     col=colors[1], bty="l", las=1,
     xlab="Torque (kNm)", ylab="Mass (t)")
grid()

linear_estimation<-lm(Mass.t ~ Torque.kNm, data=g1pm_generator)
abline(linear_estimation, col="gray", lwd=2, lty=2)

# display equation
linear_coefficients <- round(coef(linear_estimation), 3) 
#mtext(bquote(Mass(t) == .(linear_coefficients[2])*Torque (kNm) + .(round(linear_coefficients[1],1))), adj=1, padj=7)
