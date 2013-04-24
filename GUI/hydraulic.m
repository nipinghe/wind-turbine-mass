%Function to estimate hydraulic pump efficiency and mass
%Example: [eff, mass]=hydraulic(20,3e6,15)

%   INPUTS
%Power: Input Power in MW
%Speed: Input speed in rpm

%   OUTPUTS
% gear_efficiency:The efficiency of gearbox :0-1
% gear_mass: Total mass in kg


function [hydraulic_efficiency, hydraulic_mass] = hydraulic(P,speed)

Torque=P*1e3/(speed*2*pi/60); %Torque in kNm

  % Mass %    
  %mass of single pump
  hydraulic_pump_mass=round(4.19*Torque+2730);
  
  %Hydraulic gear total mass
  k=2.2; %hydraulic pump + hydraulic motor + accumulators
  hydraulic_mass=round(2.2*hydraulic_pump_mass);
  
%   %Disabled
%   %modify with more realistic values
%   %Calculate efficiency using polynomial fit
%   %data of MB240, MB3200 [1]
%   %speed=[20,18,16,13,12,8,18,16,15,14,11,8,6];
%   %eff=[0.9,0.92,0.93,0.94,0.95,0.94,0.89,0.91,0.92,0.93,0.94,0.94,0.93];
%   %p=polyfit[speed,eff,4]  %polynomial fit 4th degree
%   %p=[6.8936e-06,-2.9847284e-04,0.0038371,-0.0140615,0.9315878];
%   %with extended MB1200
%   p=[-4.2447273203e-06,3.12185213e-04,-0.00796388,0.08111423,0.6632] ;
%   
%   hydraulic_pump_efficiency=polyval(p,speed);  %get efficiency for the current speed
%   
%   %upper and lower limits
%   if (hydraulic_pump_efficiency >0.95) 
%       hydraulic_pump_efficiency=0.95;
%   end
%   
%   if (hydraulic_pump_efficiency <0.89)  % If speed increases viscous losses increases
%       hydraulic_pump_efficiency=0.89;
%   end
  hydraulic_pump_efficiency=0.935;  %efficiency of single unit
  
  hydraulic_efficiency=round(100*hydraulic_pump_efficiency^2-0.01)/100; 
  % Total efficiency of the hysraulic pump, motor and losses in the high
  % pressure line. The 1% loss will increase considerably for a sea level
  % generation
 

end

% %References
% 
%[1] Bosch Rexroth Catalog
%http://hagglunds.us/Upload/20060809110911A_en395.pdf