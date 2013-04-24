%Function to calculate the permanent magnet generator mass and efficiency

%Cooling options= air, water

%Example:
%[pm_mass, pm_efficiency]=pm_generator(2,10,'air')

% Inputs
% P: Power in MW

function [pm_mass, pm_efficiency]=pm_generator(P,speed,cooling)

Torque=P*1e3/(speed*2*pi/60); %Torque in kNm

%High Speed Generator %
if speed >= 1500 %Multi-stage gearbox
   
% Mass %
    switch cooling % Get Tag of selected object.
        case 'air' %Air cooling     
            pm_mass=round(660*P^1.21);
        case 'water' %Water Cooling
            pm_mass=round(0.85*660*P^1.21);     
    end

%Efficiency(%) Rated Load
pm_efficiency=round(100*0.97218*P^0.003)/100; %Round to 2 digits


elseif speed < 1500 && speed > 30 %Generator With single-stage gearbox
    
 % Mass %
    switch cooling % Get Tag of selected object.
        case 'air' %Air cooling     
            pm_mass=round(29.6*Torque+1464);
        case 'water' %Water Cooling %20 lighter than air cooled
            pm_mass=round(0.85*29.6*Torque+1464);     
    end
    
pm_efficiency = round (100*0.9332* P^0.016)/100;

else %Direct Drive case
           pm_mass=round(27.6*Torque+2813);
           pm_efficiency=round (100*0.9332* P^0.016)/100;
    
end

end


%Ref:
%Upwind Report deliverables
