% Lab 2
 
% Defining 120 deg. in radians
rad120 = (2*pi/3);
 
% Voltage per phase 120 Volts; Resistance 5 ohm; Inductance j7 ohm
Vm = 120;
R = 5;
Xl = 7;
 
% frequency = 50Hz
t = 0:0.001:10;
Z = sqrt(R^2 + Xl^2);
 
Pa = (Vm*Vm*sin(t).*sin(t-atan(Xl/R))/Z); 
Pb = (Vm*Vm*sin(t + rad120).*sin(t+rad120-atan(Xl/R))/Z);
Pc = (Vm*Vm*sin(t - rad120).*sin(t-rad120-atan(Xl/R))/Z);
 
plot(t, Pa, t, Pb, t, Pc)

title('Instantaneous Power transfered to each load in 3-\phi')
xlabel('time (seconds)')
ylabel('Instantaneous Power (W)')
legend('Phase R', 'Phase Y', 'Phase B')

 
% Setting y-axis limits
ylim([-400 1800])
