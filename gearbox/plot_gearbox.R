#Plot Gearbox data

setwd("./gearbox/")
gearbox <- read.delim("gearbox_data.txt")

#Set colors
require("RColorBrewer")
colors = brewer.pal(4,"Dark2")

plot(gearbox$Torque.kNm, gearbox$Weight.kg/1000, pch=as.numeric(gearbox$Manufacturer)+21, 
     lwd=2, cex=1.5, col=colors[gearbox$Manufacturer], bty="l", xlim=c(0,6000), ylim=c(0,62),
     xlab="Torque (kNm)", ylab="Mass (t)")
grid()

#Add Legend
legend("bottomright", legend=levels(gearbox$Manufacturer), col=colors,pch=22:25, pt.cex=1.5,
       lwd=2,lty=0, title="Manufacturer", bty="n")

linear_estimation<-lm(Weight.kg/1000 ~ Torque.kNm, data=gearbox)
abline(linear_estimation, col="gray", lwd=2, lty=2)

# display equation
linear_coefficients <- round(coef(linear_estimation), 3) 
mtext(bquote(Mass(t) == .(linear_coefficients[2])*Torque (kNm) + .(linear_coefficients[1])), 
      adj=1, padj=0)