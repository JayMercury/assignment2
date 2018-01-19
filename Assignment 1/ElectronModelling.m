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
T = 300;                                % Kelvin
vth_e = sqrt((2*kb*T)/(pi*m_0));        % Thermal velocity of an electron
vth_ex = vth_e*cos(360*rand(1,num));
vth_ey = vth_e*sin(360*rand(1,num));


% Electrons Defining
Elec = zeros(num, 4);
Elec(:, 1) = 100e-9*rand(num, 1);
Elec(:, 2) = 200e-9*rand(num, 1);
Elec(:, 3) = vth_ex;
Elec(:, 4) = vth_ey;

% Electrons moving
t = 2e-6;
for n = 0:t
    Elec(:, 1) = Elec(:, 1) + Elec(:, 3)*t;
    Elec(:, 2) = Elec(:, 2) + Elec(:, 4)*t;
    plot(Elec(:, 1), Elec(:, 2))
    figure;
    hold on
    n = n + 1e-6;
end
hold off
