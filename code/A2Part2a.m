close all
clear

nx = 50;
ny = nx*3/2;
G = sparse(nx*ny);
V = zeros(nx*ny, 1);
sigma1 = 1;
sigma2 = 1e-2;
box = [nx*2/5 nx*3/5 ny*2/5 ny*3/5];

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

E = G\V;
figure(1)
spy(G);

figure(2)
X = zeros(nx, ny, 1);
for i = 1:nx
    for j = 1:ny
        n = j + (i-1)*ny;
        X(i,j) = E(n);
    end
end
surf(X)
axis tight