close all
clear

nx = 50;
ny = nx*3/2;
G = sparse(nx*ny);
V = zeros(nx*ny, 1);

for i = 1:nx
    for j = 1:ny
        n = j + (i-1)*ny;
        
        if i == 1
            G(n, :) = 0;
            G(n, n) = 1;
            V(n) = 1;
        elseif i == nx
            G(n, :) = 0;
            G(n, n) = 1;
            V(n) = 0;
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

E = G\V;

figure(2)
X = zeros(nx, ny, 1);
for i = 1:nx
    for j = 1:ny
        n = j + (i-1)*ny;
        X(i,j) = E(n);
    end
end
surf(X)