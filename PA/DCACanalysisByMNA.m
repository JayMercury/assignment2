close all
clear 

R1 = 1;
G1 = 1/R1;
c = 0.25;
R2 = 2;
G2 = 1/R2;
L = 0.2;
R3 = 10;
G3 = 1/R3;
a = 100;
R4 = 0.1;
G4 = 1/R4;
Ro = 1000;
Go = 1/Ro;

C = [0 0 0 0 0 0 0;
    -c c 0 0 0 0 0;
    0 0 -L 0 0 0 0;
    0 0 0 0 0 0 0;
    0 0 0 0 0 0 0;
    0 0 0 0 0 0 0;
    0 0 0 0 0 0 0;];

G = [1 0 0 0 0 0 0;
    -G2 G1+G2 -1 0 0 0 0;
    0 1 0 -1 0 0 0;
    0 0 -1 G3 0 0 0;
    0 0 0 0 -a 1 0;
    0 0 0 G3 -1 0 0;
    0 0 0 0 0 -G4 G4+Go];

V = zeros(7,1);
F = zeros(7,1);

f1 = figure;
f2 = figure;

for v = -10:1: 10
    F(1,1) = v;
    V = G\F;
    
    set(0, 'CurrentFigure', f1)
    scatter(v, V(7,1), 'r.')
    hold on
    title('Vo in DC case')
    
    set(0, 'CurrentFigure', f2)
    scatter(v, V(4,1), 'b.')
    hold on
    title('V3 in DC case')
    
    
    
end

