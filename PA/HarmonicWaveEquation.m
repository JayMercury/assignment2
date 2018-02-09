close all
clear

nx = 50;
ny = nx;
G = sparse(nx*ny);
for i = 1:nx
    for j = 1:ny
        n = j + (i-1)*ny;
        
        if i == 1 || i == nx ||j == 1 || j == ny
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

figure(1) 
spy(G)
[E, D] = eigs(G, 9, 'SM');

figure(2)
X = zeros(nx, ny, 9);
for o = 1:9
    X(:, :, o) = reshape(E(:, o), nx, ny);
    subplot(3, 3, o)
    surf(X(:, :, o))
end