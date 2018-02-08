nx = 25;
ny = 25;
G = sparse(nx*ny);
E = zeros(nx*ny, 1);
for m = 1: 1: nx*ny
    G(m, m) = 1;
end
for i = 1:nx
    for j = 1:ny
        n = j + (i-1)*ny;
        
        if i == 1 || i == nx ||j == 1 || j == nx
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
