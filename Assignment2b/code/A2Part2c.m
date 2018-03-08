%% Part 2(c)
% In part 2(c), we are now investigating the difference between current
% density and various bottle-neck sizes.

% Reset Everything
close all
clear

% Creating a loop for decreasing the bottle-neck size
for a = 0.1:1e-2:0.9

    % Setting variables
    nx = 50;            % Length of the region
    ny = nx*3/2;        % Width of the region, 3/2 of length
    G = sparse(nx*ny);  % Initialize a G matrix
    D = zeros(1, nx*ny);% Initialize a matrix for G matrix operation
    S = zeros(ny, nx);  % Initialize a matrix for sigma
    sigma1 = 1;         % Setting up parameter of sigma in different region
    sigma2 = 1e-2;
    box = [nx*2/5 nx*3/5 ny*a ny*(1-a)]; % Setting up the bottle-neck
    
    % Implement the G matrix with the bottle-neck condition in the region
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
                if i > box(1) && i < box(2)
                    G(n, n) = -3;
                    G(n, n+1) = sigma2;
                    G(n, n+ny) = sigma2;
                    G(n, n-ny) = sigma2;
                else
                    G(n, n) = -3;
                    G(n, n+1) = sigma1;
                    G(n, n+ny) = sigma1;
                    G(n, n-ny) = sigma1;
                end
            elseif j == ny
                if i > box(1) && i < box(2)
                    G(n, n) = -3;
                    G(n, n+1) = sigma2;
                    G(n, n+ny) = sigma2;
                    G(n, n-ny) = sigma2;
                else
                    G(n, n) = -3;
                    G(n, n+1) = sigma1;
                    G(n, n+ny) = sigma1;
                    G(n, n-ny) = sigma1;
                end
            else
                if i > box(1) && i < box(2) && (j < box(3)||j > box(4))
                    G(n, n) = -4;
                    G(n, n+1) = sigma2;
                    G(n, n-1) = sigma2;
                    G(n, n+ny) = sigma2;
                    G(n, n-ny) = sigma2;
                else
                    G(n, n) = -4;
                    G(n, n+1) = sigma1;
                    G(n, n-1) = sigma1;
                    G(n, n+ny) = sigma1;
                    G(n, n-ny) = sigma1;
                end
            end
        end
    end
    
    % Implement a matrix for sigma
    for L = 1 : nx
        for W = 1 : ny
            if L >= box(1) && L <= box(2)
                S(W, L) = sigma2;
            else
                S(W, L) = sigma1;
            end
            if L >= box(1) && L <= box(2) && W >= box(3) && W <= box(4)
                S(W, L) = sigma1;
            end
        end
    end
        
    % Calculating the voltage
    V = G\D';
        
    % Inverting the G matrix
    X = zeros(ny, nx, 1);
    for i = 1:nx
        for j = 1:ny
            n = j + (i-1)*ny;
            X(j,i) = V(n);
        end
    end
        
    % Calculating the electric field from voltage
    [Ex, Ey] = gradient(X);
        
    % Calculating the current density
    Jx = S.*Ex;
    Jy = S.*Ey;
    J = sqrt(Jx.^2 + Jy.^2);
        
    % Creating plot for comparing current density with various bottle-neck size
    figure(1)
    hold on
    if a == 0.1
        Cy = sum(J, 2);
        C = sum(Cy);
        previousC = C;
        plot([a, a], [previousC, C])
    end
    if a > 0.1
        previousC = C;
        Cy = sum(J, 2);
        C = sum(Cy);
        plot([a-1e-2, a], [previousC, C])
    end
    title("Current vs. various bottle-necks")

end

%% Discussion
% The current density will slowly decreasing then exponentially decreasing
% into a constant flat line as the bottle-neck decreases.