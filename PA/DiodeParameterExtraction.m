close all
clear

Is = 0.01e-12;
Ib = 0.1e-12;
Vb = 1.3;
Gp = 0.1;
V = linspace(-1.95, 0.7, 200);
I = Is*(exp(1.2/0.025*V)-1) + Gp*V - Ib*exp(-1.2/0.025*(V+Vb));
Isr = randn(1, 200)*0.2*Is;
Ir = Isr.*(exp(1.2/0.025*V)-1) + Gp*V - Ib*exp(-1.2/0.025*(V+Vb));

figure(1)
p4 = polyfit(V, I, 4);
p8 = polyfit(V, I, 8);
f1 = polyval(p4, V);
f2 = polyval(p8, V);
plot(V, I);
title("V vs. I w/o 20% random variation")
hold on
plot(V, f1, 'r--');
plot(V, f2, 'b--');
grid on;

figure(2)
semilogy(V, abs(I));
title("V vs. log(I) w/o 20% random variation")
grid on;

figure(3)
p4r = polyfit(V, Ir, 4);
p8r = polyfit(V, Ir, 8);
f1r = polyval(p4r, V);
f2r = polyval(p8r, V);
plot(V, Ir)
title("V vs. I with 20% random variation")
hold on
plot(V, f1r, 'r--');
plot(V, f2r, 'b--');
grid on;

figure(4)
semilogy(V, abs(Ir));
title("V vs. log(I) with 20% random variation")
grid on;

figure(5)
fo = fittype('A.*(exp(1.2*x/25e-3)-1)+B.*-C*(exp(1.2*(-(x+D))/25e-3)-1)');
ff = fit(V',I',fo);
If = ff(V);
plot(V, If)
title("Fitted curves with explictly setting B and D")
grid on;

figure(6)
fo1 = fittype('A.*(exp(1.2*x/25e-3)-1)+0.1.*-C*(exp(1.2*(-(x+1.3))/25e-3)-1)');
ff1 = fit(V',I',fo1);
If1 = ff1(V);
plot(V, If1)
title("Fitted curves with explictly setting D")
grid on;

figure(7)
fo2 = fittype('A.*(exp(1.2*x/25e-3)-1)+B.*-C*(exp(1.2*(-(x+1.3))/25e-3)-1)');
ff2 = fit(V',I',fo2);
If2 = ff2(V);
plot(V, If2)
title("Fitted curves w/o explictly setting")
grid on;

inputs = V.';
targets = I.';
hiddenLayerSize = 10;
net = fitnet(hiddenLayerSize);
net.divideParam.trainRatio = 70/100;
net.divideParam.valRatio = 15/100;
net.divideParam.testRatio = 15/100;
[net,tr] = train(net,inputs,targets);
outputs = net(inputs);
errors = gsubtract(outputs,targets);
performance = perform(net,targets,outputs)
view(net)
Inn = outputs