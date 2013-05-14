%Function to calculate structural mass and cost of the low speed shaft
%Applicable ONLY for high speed drive trains

%Example:
%[shaft_mass, shaft_cost]=low_speed_shaft(2)

% Inputs
% P: Power in MW

function [shaft_mass, shaft_cost]=low_speed_shaft(P)
%% Constants %%

p_air = 1.225;  % Air Density in kg/m^3
Cp = 0.515;     % Maximum Power Coefficient 
v_w = 11.3;     % Rated Wind Speed in m/s


%% Main Variables %%

P=P.*1e6;    % Power in MW
D_blade = round(1./sqrt(0.5*p_air*Cp*pi*v_w^3/4./P));    % Rotor Blade Diameter in m [1]


%% Outputs %%

shaft_mass = round(0.0142.*D_blade.^2.888); % Shaft Mass in kg
shaft_cost = round(0.54.*shaft_mass);   % Shaft Cost in euros
%original equation in $, divided by 1.308 to convert to €


end


%Ref:
%[1]:Fingersh, L., Hand, M., & Laxson, A. (2006). 
%Wind Turbine Design Cost and Scaling Model Wind Turbine Design Cost and Scaling Model.