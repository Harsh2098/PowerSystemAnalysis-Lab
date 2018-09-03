% Lab 2

rad120 = (2*pi/3);

% Voltage per phase 230 Volts; Resistance 5 ohm; Inductance j25 ohm
Vm = 120;
R = 5;
Xl = 7;

% frequency = 50Hz
t = 0:0.001:10;
Z = sqrt(R^2 + Xl^2);

Pa = (Vm*Vm*sin(t).*sin(t-atan(Xl/R))/Z); 
Pb = (Vm*Vm*sin(t + rad120).*sin(t+rad120-atan(Xl/R))/Z);
Pc = (Vm*Vm*sin(t - rad120).*sin(t-rad120-atan(Xl/R))/Z);

plot(t, Pa, t, Pb, t, Pc);

%plot(t, Pa+Pb+Pc);
ylim([-400 1800])

reactive_power = (Pa+Pb+Pc)*sin(atan(Xl/R));
true_power = (Pa+Pb+Pc)*cos(atan(Xl/R));

% 3Vm*Vm/2|z| * cos(atan(Xl/R))
