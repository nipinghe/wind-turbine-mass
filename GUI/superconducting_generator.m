%Function to calculate the superconducting mass and efficiency
%Direct drive machine

%Example:
%[HTS_mass, HTS_efficiency]=superconducting_generator(Power(MW),Speed(rpm))

% Inputs
% P: Power in MW

function [HTS_mass, HTS_efficiency]=superconducting_generator(P,Speed)
%% Mass %%

Torque=1000*P*30/Speed/pi; %torque in kNm [1]

HTS_mass=round(11*Torque+45000);  %mass in kg


HTS_efficiency=round(100*0.975*P^0.005)/100; %Round to 2 digits

end

%Ref
%[1] Homopolar Superconducting generator Keysan Mueller 2011