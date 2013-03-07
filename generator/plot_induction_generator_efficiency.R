#Plot High Speed Induction Generator

#setwd("./generator/")
induction_generator <- read.delim("induction-generator-data.txt")

#Set colors
require("RColorBrewer")
colors = brewer.pal(3,"Dark2")

plot(induction_generator$Power.MW, induction_generator$Efficiency.full, 
     pch=as.numeric(induction_generator$Manufacturer)+21, lwd=2, cex=1.5, 
     col=colors[induction_generator$Manufacturer], bty="l", xlim=c(0,8), ylim=c(95,98),las=1,
     xlab="Power (MW)", ylab="Efficiency (%)")
grid()

#Add Legend
legend("bottomright", legend=c("Siemens (Air cooled)", "Siemens (Water cooled)"), 
       col=colors[2:3], pch=23:25, pt.cex=1.5,lwd=2,lty=0, title="Manufacturer", bty="n")

#Air cooled Siemens Machines
subset_data <- subset(induction_generator, Manufacturer=="Siemens-air", c(Power.MW, Mass.t))
# Non-linear modeln(power fit)
fit <- nls(Efficiency.full ~ a*Power.MW^b,data = induction_generator, 
           start=list(a = 95, b = 0.01))
#Plot power estimation
power_fine <- seq(0, 7.5, length = 101)
lines(power_fine, predict(fit, list(Power.MW= power_fine)), lty=2,lwd=2, col="darkgray")

coefficients <- round(coef(fit), 2) 
mtext(paste("Efficiency (%)=",coefficients[1],"xPower(MW)^",coefficients[2], sep=""), 3,-3.5)

