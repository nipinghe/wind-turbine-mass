%Function to calculate the EESG
%Electrically excited synchronous generator
%1500 rpm machine
%Cooling options= air, water

%Example:
%[sg_mass, sg_efficiency]=eesg_generator(2,1500,air)

% Inputs
% P: Power in MW

function [sg_mass, sg_efficiency]=eesg_generator(P,speed,cooling)

Torque=P*1e3/(speed*2*pi/60); %Torque in kNm

%High Speed Generator %
if speed >= 1500 %Multi-stage gearbox
   
% Mass %
    switch cooling % Get Tag of selected object.
        case 'air' %Air cooling     
            sg_mass=round(2350*P^1.13);
        case 'water' %Water Cooling
            sg_mass=round(1880*P^1.13);     
    end


%Efficiency(%) Rated Load
%sg_efficiency=roundn(0.9772*P^0.0048,-2); %Round to 2 digits %removed for
%Matlab 2008 compatibility
sg_efficiency=round(100*0.9772*P^0.0048)/100; %Round to 2 digits
else %Generator With single-stage gearbox or direct-drive

           sg_mass=round(35.3*Torque+8862);
           sg_efficiency=round(100*0.8653* P^0.0323)/100;
    
end

end


%Ref:
%[1]:Upwind Report