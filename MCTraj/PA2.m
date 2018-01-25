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

% Electron defining
Vx = 0;
x = 0;
F = 10;

% Moving
t = 1000;
dt = 1;
sumV = 0;
for n = 0:dt:t
    if rand() <= 0.05
        Vx = 0;
    else
        Vx = Vx + F*dt;
    end
    x = x + Vx*dt;
    subplot(2, 1, 1);
    plot(n, x, 'b.')
    sumV = sumV + Vx;
    if (n ~= 0)
        AveV = Vx/n;
    end
    subplot(2, 1, 2);
    plot(n, Vx, 'b.')
    hold on
    pause(0.01)
end
title('Drift velocity is'+ num2str(AveV));