close all
clear

m = 100;
n = 100;
iter = 1e20;
Vmn = zeros(m, n);
BC = 1;
Vmn(:, 1) = BC;
Vmn(:, 100) = BC;

for k = 1:1:1e6
    
    for i = 2:1:m-1
        for j = 2:1:n-1
%             if j == 1
%                 Vmn(i,j) = (Vmn(i+1, j)+Vmn(i-1,j)+Vmn(i,j+1))/3;
%             elseif j == n
%                 Vmn(i,j) = (Vmn(i+1, j)+Vmn(i-1,j)+Vmn(i,j-1))/3;
%             else
                Vmn(i,j) = (Vmn(i+1, j)+Vmn(i-1,j)+Vmn(i,j-1)+Vmn(i,j+1))/4;
%             end
        end
    end
    surf(Vmn);
    pause(1e-100) 
end