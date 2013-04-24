%Function to calculate structural mass and cost of the main bearing
%Input may be in the vectoral form
%Example:
%[main_bearing_mass, main_bearing_cost]=main_bearing(2)

% Inputs
% P: Power in MW

function [main_bearing_mass, main_bearing_cost] = main_bearing(P)
%% Constants %%

p_air = 1.225;  % Air Density in kg/m^3
Cp = 0.515;     % Maximum Power Coefficient 
v_w = 11.3;     % Rated Wind Speed in m/s


%% Main Variables %%

P=P.*1e6;    % Power in MW
D_blade = round(1./sqrt(0.5*p_air*Cp*pi*v_w^3/4./P));    % Rotor Blade Diameter in m [1]


%% Outputs %%

main_bearing_mass = 2*round((D_blade.*8/600-0.033)*0.0092.*(D_blade.^2.5)); % Bearing Mass in kg
% 2 is added to include bearing housing mass
main_bearing_cost = round(main_bearing_mass.*13.45);                     % Bearing Cost in euros
%original equation in 17.6 $, divided by 1.308 to convert to €

end


%Ref:
%[1]:Fingersh, L., Hand, M., & Laxson, A. (2006). 
%Wind Turbine Design Cost and Scaling Model Wind Turbine Design Cost and Scaling Model.
