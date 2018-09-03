% Lab 1 - Case 1

Vm = 10;
R = 5;
Xl = 5; 
Xc = 5;
x = 0:pi/100:2*pi;

Pr = ((Vm*Vm)/R)*((1-cos(2*x))/2);
Pl = ((Vm*Vm)/(2*Xl))*cos(2*x);
Pc = -((Vm*Vm)/(2*Xc))*cos(2*x);

plot(x,Pr, x,Pl, x,Pc)
title('Instantaneous Power drawn by RLC Parallel Circuit')
xlabel('\omegat')
ylabel('Power')
legend('Resistor','Inductor','Capacitor')
