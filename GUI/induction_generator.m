%Function to calculate the induction motor mass and efficiency
%1500 rpm machine
%Cooling options= air, water

%Example:
%[IG_mass, IG_efficiency]=induction_generator(2,air)

% Inputs
% P: Power in MW

function [IG_mass, IG_efficiency]=induction_generator(P,speed,cooling)

%High Speed Generator %
if speed >= 1500 %Multi-stage gearbox
   
% Mass %
    switch cooling % Get Tag of selected object.
        case 'air' %Air cooling     
            IG_mass=round(3900*P^0.7);
        case 'water' %Water Cooling
            IG_mass=round(3170*P^0.7);     
    end


%Efficiency(%) Rated Load
IG_efficiency=round(100*0.9564*P^0.01)/100; %Round to 2 digits

else    %Generator With single-stage gearbox

Torque=P*1e3/(speed*2*pi/60); %Torque in kNm
  % Mass %
    switch cooling % Get Tag of selected object.
        case 'air' %Air cooling     
            IG_mass=round(38.6*Torque+3847);
        case 'water' %Water Cooling %20 lighter than air cooled
            IG_mass=round(30.88*Torque+3077);     
    end
    
IG_efficiency = round (100*0.90082* P^0.029)/100;
end

end


%Ref:
%[1]:Fingersh, L., Hand, M., & Laxson, A. (2006). 
%Wind Turbine Design Cost and Scaling Model Wind Turbine Design Cost and Scaling Model.
