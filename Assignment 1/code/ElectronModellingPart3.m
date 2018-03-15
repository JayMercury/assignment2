%% Part 3
% In this part of the assignment, we are required to create two block in
% the middle to create a bottle neck for the electrons to move through, the
% electrons will also include previous scattering probability. The
% electrons cannot spawn inside the blocks and they would have to bounce
% off the block like when they hit the boundary walls.

% Reset everything
close all
clear

% Constant
q_0 = 1.60217653e-19;                   % electron charge
m_0 = 9.10938215e-31;                   % electron mass
kb = 1.3806504e-23;                     % Boltzmann constant
tmn = 0.2e-12;                          % mean time between collisions

% Region Defining
L = 200e-9;
W = 100e-9;

% Current Condition and variables
num = 1e4;                              % Number of electrons
T = 300;                                % Temperature (Kelvin)
vth_e = sqrt((2*kb*T)/(m_0));           % Thermal velocity of an electron
vth_ex = (vth_e/sqrt(2))*randn(num, 1); % X-component of thermal velocity
vth_ey = (vth_e/sqrt(2))*randn(num, 1); % Y-component of thermal velocity
vthav = mean(sqrt(vth_ex.^2+vth_ey.^2));% Average of thermal velocity

% Electrons Defining
Elec = zeros(num, 4);
Elec(:, 1) = L*rand(num, 1);
Elec(:, 2) = W*rand(num, 1);
Elec(:, 3) = vth_ex;
Elec(:, 4) = vth_ey;
previous = zeros(num, 4);
previous = Elec;

% Electron simulation
figure(2);
t = 1e-11;                           % Total Time
dt = 1e-14;                         % Time Step
Psat = 1 - exp(-dt/tmn);            % Exponential Scattering Probability
numplot = 5;                        % Number of electron plotted
color = hsv(numplot);               % Colour Setup

% Part 3 simulation, setting up limitation for electrons spawning
for m = 1:1:num
    if Elec(m, 1) > 80e-9 && Elec(m, 1) < 120e-9 && (Elec(m, 2) > 60e-9 || Elec(m, 2) < 40e-9)
            Elec(m, 1) = L*rand();
            Elec(m, 2) = W*rand();
    end
end

% Part 3 Simulation, setting up rectangles boundaries
rectangle('Position', [80e-9 0 40e-9 40e-9])
rectangle('Position', [80e-9 60e-9 40e-9 40e-9])
hold on
    
for n = 0:dt:t
    
    % Part 2 Simulation
    if Psat > rand()
        vth_ex = (vth_e/sqrt(2))*randn(num, 1); 
        vth_ey = (vth_e/sqrt(2))*randn(num, 1);
        Elec(:, 3) = vth_ex;
        Elec(:, 4) = vth_ey;
    end
           
    for p = 1:1:num
        previous(p, 1) = Elec(p, 1);
        previous(p, 2) = Elec(p, 2);
        Elec(p, 1) = Elec(p, 1)+ Elec(p, 3)*dt;
        Elec(p, 2) = Elec(p, 2)+ Elec(p, 4)*dt;
    end
    
    % Plotting limited amount of electrons
    figure(2)
    for q = 1:1:numplot
        title('Electrons movement');
        plot([previous(q, 1), Elec(q, 1)], [previous(q, 2), Elec(q,2)], 'color', color(q, :))
        xlim([0 L])
        ylim([0 W])
        hold on
    end
    
    % Setting up the boundaries
    for o = 1:1:num
        % Looping on x-axis
        if Elec(o, 1) > L                       
            Elec(o, 1) = Elec(o, 1) - L;
            previous = Elec;
        end
        if Elec(o, 1) < 0
            Elec(o, 1) = Elec(o, 1) + L;
            previous = Elec;
        end
        % Reflecting on y-axis
        if Elec(o, 2) > W || Elec(o, 2) < 0
            Elec(o, 4) = -1*Elec(o, 4);
        end
        % Part 3 Simulation, boundaries for electrons movements
        if Elec(o, 1) > 80e-9 && Elec(o, 1) < 120e-9 && (Elec(o, 2) < 40e-9 || Elec(o, 2) > 60e-9)
            if Elec(o, 2) < 40e-9
                if previous(o, 2) > 40e-9
                    Elec(o, 4) = -1*Elec(o, 4);
                    Elec(o, 2) = Elec(o, 2) + (40e-9 - Elec(o, 2));
                else
                    Elec(o, 3) = -1*Elec(o, 3);
                    Elec(o, 1) = Elec(o, 1) + (80e-9 - Elec(o, 1));
                end
            end
            if Elec(o, 2) > 60e-9
                if previous(o, 2) < 60e-9
                    Elec(o, 4) = -1*Elec(o, 4);
                    Elec(o, 2) = Elec(o, 2) + (40e-9 - Elec(o, 2));
                else
                    Elec(o, 3) = -1*Elec(o, 3);
                    Elec(o, 1) = Elec(o, 1) + (80e-9 - Elec(o, 1));
                end
            end
        end
    end
    
    % Plotting average temperature
    vthav = mean(sqrt(vth_ex.^2 + vth_ey.^2)); % Average thermal velocity
    aveT = (0.5*m_0*vthav^2)/kb;               % Average temperature
    figure(3)
    plot(n, aveT, 'r.')
    title('Average temperature');
    hold on
end

% Density Plot
Den = hist3(Elec(:, 1:2), 'Nbins', [20, 10]);
figure(4);
surf(Den)
shading interp