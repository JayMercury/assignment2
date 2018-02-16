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
            V(n) = 1;
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

series = zeros(30,20);
a = 30;
b = 10;
x = linspace(-10, 10, 20);
y = linspace(0, 30, 30);
[xx, yy] = meshgrid(x,y);
for n = 1: 2: 600
    series = (series + (cosh(n*pi*xx/a).*sin(n*pi*yy/a))./(n*cosh(n*pi*b/a)));
    figure(3)
    surf(x, y, (4/pi)*series)
    pause(0.01)
end