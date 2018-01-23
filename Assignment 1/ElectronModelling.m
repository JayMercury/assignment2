% clear all
clearvars
clearvars -GLOBAL
close all
format shorte

% Constant
q_0 = 1.60217653e-19;                   % electron charge
hb = 1.054571596e-34;                   % Dirac constant
h = hb * 2 * pi;                        % Planck constant
m_0 = 9.10938215e-31;                   % electron mass
kb = 1.3806504e-23;                     % Boltzmann constant
eps_0 = 8.854187817e-12;                % vacuum permittivity
mu_0 = 1.2566370614e-6;                 % vacuum permeability
c = 299792458;                          % speed of light
g = 9.80665;                            % metres (32.1740 ft) per s²
am = 1.66053892e-27;

% Region Defining
L = 200e-9;
W = 100e-9;

% Current Condition and variables
num = 5;                                % Number of electrons
T = 300;                                % Temperature (Kelvin)
vth_e = sqrt((2*kb*T)/(pi*m_0));        % Thermal velocity of an electron
vth_ex = vth_e*cos(360*rand(1,num));
vth_ey = vth_e*sin(360*rand(1,num));


% Electrons Defining
Elec = zeros(num, 4);
Elec(:, 1) = 100e-9*rand(num, 1);
Elec(:, 2) = 200e-9*rand(num, 1);
Elec(:, 3) = vth_ex;
Elec(:, 4) = vth_ey;

% Setting up region restriction
% Looping on x-axis
if Elec(:, 1) > 100e-9                       
    Elec(:, 1) = Elec(:, 1) - 100e-9;
elseif Elec(:, 1) < 100e-9
    Elec(:, 1) = Elec(:, 1) + 100e-9;
else
    Elec(:, 1) = Elec(:, 1);
end
% Reflecting on y-axis
if Elec(:, 2) > 200e-9 | Elec(:, 2) < 200e-9 
    Elec(:, 4) = -1*Elec(:, 4);
else
    Elec(:, 2) = Elec(:, 2);
end

% Electron moving
t = 1e-6;
dt = 1e-5;
for n = 0:dt:t
    plot(Elec(:, 1), Elec(:,2), 'b*')
    Elec(:, 1) = Elec(:, 1)+ Elec(:, 3)*dt;
    Elec(:, 2) = Elec(:, 2)+ Elec(:, 4)*dt;
    hold on
    pause(0.01)
end
