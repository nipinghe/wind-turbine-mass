%Function to estimate gearbox efficiency, mass and cost
%Example: [eff, mass, cost]=gearbox(20,3e6,15)

%   INPUTS
% gear_ratio: The gear ratio 1==> Direct Drive (1,15) Single Stage Gearbox,
% >15 Three stage gearbox
%Torque: Mechanical Input torque in Nm
%Speed: Input speed in rpm

%   OUTPUTS
% gear_efficiency:The efficiency of gearbox :0-1
% gear_mass: Total mass in kg
% gear_cost: Estimated total cost in £

function [gear_efficiency, gear_mass, gear_cost ] = gearbox(gear_ratio,torque,speed)


if gear_ratio == 1                                                  %Gear Ratio =100 -> Direct Drive System
     gear_efficiency=1;
     gear_mass=0;       %No gearbox
     gear_cost=0;       %no gearbox cost



elseif (gear_ratio >1 && gear_ratio <=15)                          % 1<Gear Ratio <15  Single Stage Gearbox Case [1]
     gear_efficiency = 0.985;                                       %Single Planetary Gearbox from Zhang2011a[2], [3]
     %gear_mass=10;                 % Change with more realistic value!!!!
     
     gear_mass=round(0.0883*torque^0.774);                                   %Single-stage gearbox with medium speed generator [5]
     gear_cost=gear_mass*6;                                         %Specific cost of single stage gearbox= €6/kg[4]


else                                                                %Gear Ratio>15 -> MultiStage Gearbox
     gear_efficiency = 0.96;                                        %from Zhang2011a[2]
     gear_mass=round(10.511e-3*torque+3178);                               %Estimated Mass from the gearbox manufacturers
     gear_cost=gear_mass*10;                                        %Specific cost of three stage gearbox= €10/kg[4]
     
     %gear_mass=70.94*(torque/1000)^0.759                           %from [5]
     %gear_cost=12.58*power_rating(kw)^1.249                        %from [5]
end;

    

end




% %References
% 
%[1] J. R. Cotrell, “A preliminary evaluation of a multiple-generator drive train configuration for wind turbines”, 
%     in 2002 ASME Wind Energy Symposium, AIAA Aerospace Sciences Meeting and Exhibit, 40th, Collection of Technical Papers, Reno, NV, Jan. 14-17, 2002.
%[2]  Zhang, Z., Matveev, A., Øvrebø, S., Nilssen, R., Nysveen, A., & Rigg, R. (2011). State of the Art in Generator Technology for Offshore Wind Energy Conversion Systems. IEMDC-11 (pp. 1147-1152).  
%[3]  Li, H., Chen, Z., & Polinder, H. (2009). Optimization of Multibrid Permanent-Magnet Wind Generator Systems. IEEE Transactions on Energy Conversion, 24(1), 82-92. doi:10.1109/TEC.2008.2005279
%[4]  UpWind- Design Limits and Solutions for Very Large Wind Turbines ( Deliverable D1B2-b3) - EU 6th Frame Project. (2011). Retrieved from www.upwind.eu
%[5]:Fingersh, L., Hand, M., & Laxson, A. (2006). 
%Wind Turbine Design Cost and Scaling Model Wind Turbine Design Cost and Scaling Model.