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
vth_ex = vth_e*cos(2*pi*rand(1,num));   % X-component of thermal velocity
vth_ey = vth_e*sin(2*pi*rand(1,num));   % Y-component of thermal velocity
% Maxwell-Boltzmann Distribution of x-component thermal velocity
nx = (m_0/(2*pi*kb*T))^(1/2)*exp(-(m*vth_ex.^2)/(2*kb*T)); 
% Maxwell-Boltzmann Distribution of y-component thermal velocity
ny = (m_0/(2*pi*kb*T))^(1/2)*exp(-(m*vth_ey.^2)/(2*kb*T)); 

% Electrons Defining
Elec = zeros(num, 4);
Elec(:, 1) = L*rand(num, 1);
Elec(:, 2) = W*rand(num, 1);
Elec(:, 3) = vth_ex;
Elec(:, 4) = vth_ey;

% Electron moving
t = 1e-10;
dt = 1e-15;
for n = 0:dt:t
    plot(Elec(:, 1), Elec(:,2),  'b.')
    xlim([0 L])
    ylim([0 W])
    Elec(:, 1) = Elec(:, 1)+ Elec(:, 3)*dt;
    Elec(:, 2) = Elec(:, 2)+ Elec(:, 4)*dt;
    hold on
    pause(0.001)
    
    % Setting up boundaries
    for m = 1:1:num
        % Looping on x-axis
        if Elec(m, 1) > L                       
            Elec(m, 1) = Elec(m, 1) - L;
        end
        if Elec(m, 1) < 0
            Elec(m, 1) = Elec(m, 1) + L;
        end
        % Reflecting on y-axis
        if Elec(m, 2) > W || Elec(m, 2) < 0
            Elec(m, 4) = -1*Elec(m, 4);
        end
    end
end
