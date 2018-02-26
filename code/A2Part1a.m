%% Assignment 2
%% Part 1(a)
%In this assignment,we are trying to implement an electrostatic potential
%into our previous electron movement model, however, in order to do that,
%we would need to use Finite Difference Method to calculate the Laplace's
%equation of the electronstatic potential.
%In part 1, we are just trying to familarize ourselves with a one
%dimensional case of the Laplace's equation.

% Reset everything
close all
clear

% Setting variables
nx = 50;                % Length of the region
ny = nx*3/2;            % Width of the region, 3/2 of length
G = sparse(nx*ny);      % Initialize a G matrix
D = zeros(nx*ny, 1);    % Initialize a matrix for G matrix operation

% Implement the G matrix for one dimension case
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
            D(n) = 0;
        elseif j == 1
            G(n, :) = 0;
            G(n, n) = -3;
            G(n, n+1) = 1;
            G(n, n+ny) = 1;
            G(n, n-ny) = 1;
        elseif j == ny
            G(n, n) = -3;
            G(n, n-1) = 1;
            G(n, n+ny) = 1;
            G(n, n-ny) = 1;
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

X = zeros(nx, ny, 1);   % Initializing a matrix for inverting G matrix

% Inverting G matrix
for i = 1:nx
    for j = 1:ny
        n = j + (i-1)*ny;
        X(i,j) = V(n);
    end
end

% Surface plot of Voltage of one dimension
figure(1)
surf(X)     
axis tight
title("Surface plot of voltage of one dimension case")
view(-128, 31);