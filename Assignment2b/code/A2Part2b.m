%% Part 2(b)
% In part 2(b), we are investigating the difference between current density
% and various mesh size.

% Reset Everything
close all
clear

% Creating a loop for increasing the mesh size
for a = 20:10:100

    % Setting variables
    ny = a*3/2;         % Width of the region, 3/2 of length
    G = sparse(a*ny);   % Initialize a G matrix
    D = zeros(1, a*ny); % Initialize a matrix for G matrix operation
    S = zeros(ny, a);   % Initialize a matrix for sigma
    sigma1 = 1;         % Setting up parameter of sigma in different region
    sigma2 = 1e-2;
    box = [a*2/5 a*3/5 ny*2/5 ny*3/5];  % Setting up the bottle neck
    
    % Implement the G matrix with the bottle neck condition in the region
    for i = 1:a
        for j = 1:ny
            n = j + (i-1)*ny;
            
            if i == 1
                G(n, :) = 0;
                G(n, n) = 1;
                D(n) = 1;
            elseif i == a
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
    for L = 1 : a
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
    X = zeros(ny, a, 1);
    for i = 1:a
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
    
    % Creating plot for comparing current density with various mesh size
    figure(1)
    hold on
    if a == 20
        Cy = sum(J, 1);                 
        C = sum(Cy);
        previousC = C;
        plot([a, a], [previousC, C])
    end
    if a > 20
        previousC = C;
        Cy = sum(J, 2);
        C = sum(Cy);
        plot([a-10, a], [previousC, C])
    end
    title("Current vs. mesh size")

end

%% Discussion
% The current density will increase proportional to the increasing mesh
% size.