%% Part 1(b)
% In part b, we are now trying to solve the case completely with finite
% difference method and analytical series solution, then comparing them to
% see the difference between two methods.

% Reset Everything
close all
clear

% Setting variables
nx = 50;                % Length of the region
ny = nx*3/2;            % Width of the region, 3/2 of length
G = sparse(nx*ny);      % Initialize a G matrix
D = zeros(nx*ny, 1);    % Initialize a matrix for G matrix operation

% Implement the G matrix for two dimension case
for i = 1:nx
    for j = 1:ny
        n = j + (i-1)*ny;
        
        if i == 1
            G(n, :) = 0;
            G(n, n) = 1;
            D(n) = 1;
        elseif i == nx
            G(n, :) = 0;
            G(n, n) = 1;
            D(n) = 1;
        elseif j == 1
            G(n, :) = 0;
            G(n, n) = 1;
        elseif j == ny
            G(n, :) = 0;
            G(n, n) = 1;
        else
            G(n, n) = -4;
            G(n, n+1) = 1;
            G(n, n-1) = 1;
            G(n, n+ny) = 1;
            G(n, n-ny) = 1;
        end
    end
end

V = G\D;    % Calculating the voltage with G matrix

figure(1)
X = zeros(nx, ny, 1);   % Initializing a matrix for inverting G matrix
% Inverting G matrix
for i = 1:nx
    for j = 1:ny
        n = j + (i-1)*ny;
        X(i,j) = V(n);
    end
end
surf(X)     % Surface plot of voltage of two dimension
axis tight
title("Surface plot of voltage of two dimension case with numerical method")

% Setting up variable for the series
series = zeros(ny,nx);          
a = ny;                         
b = nx/2;
x = linspace(-nx/2, nx/2, 50);
y = linspace(0, ny, ny);
[xx, yy] = meshgrid(x,y);

% Solving the series by iterations
for n = 1: 2: 600
    series = (series + (cosh(n*pi*xx/a).*sin(n*pi*yy/a))./(n*cosh(n*pi*b/a)));
    figure(2)
    surf(x, y, (4/pi)*series)
    axis tight
    view(-128, 31);
    pause(0.01)
end
title("Surface plot of voltage of two dimension case with analytical method")
%% Discussion
% By using the series solution and solving it through iterations, it is
% possible to approach the solution that the finite difference method is
% able to create. However, the solution will start to break down if there
% are more than around 600 iterations for the series solution since the
% _cosh_ and _sin_ in the series solution will approach to infinity around
% that point of iterations.
%
% To conclude, There is no limitation on solving
% complicated equations by using numerical method, except for hardware
% limitation if the equation is too complicated to compute; Using
% analytical method would be great for solving more simpler solution since
% it take less time relative to numerical method, however it might not able
% to compute the most accurate solution with the limitation of the equation
% itself since some equation could break down from certain components in
% the equation approaching to infinity.