% Corona power loss and plotting graph between power and temperature
 
clear;
clc;
 
m_o = 1;
g_o = 21.2;  % kV/cm
 
disp('Atmospheric Parameters');
pressureHg = input('Enter the pressure in mm Hg :');
temperature = input('Enter the temperature (celcius) :');
 
freq = input('Enter the frequency of transmission lines :');
radius = input('Enter the radius of transmission line (in cm) :');
D = input('Enter the distance between the transmission lines (in m) :');
V = input('Enter the operating voltage (Line-Neutral):');
years = input('Enter the year of installation of lines :');
 
% Irregularity factor : Current Year - 2018
m_v = exp((-exp(1))*(2018 - years)/100); 
 
% To calculate surface factor
disp('1. Smooth conductor');
disp('2. Rough-surfaced conductor');
disp('3. Stranded conductors');
choice = input('Choice :');
 
switch choice
    case 1
        m_o = 1;
    case 2
        m_o = 0.95;
    case 3
        m_o = 0.85;
end
 
 
disp('1. Fair weather condition');
disp('2. Storm weather conditions');
weather = input('Choice :');
 
del = 3.92*pressureHg/(273+temperature);
Vc = radius*g_o*del*m_o*log(100*D/radius);
Vv = radius*g_o*del*m_v*(1+0.3/sqrt(radius*del))*log(100*D/radius);
 
if weather == 2
    Vc = Vc*0.8;
    Vv = Vv*0.8;
end
 
V = V/sqrt(3);
Pc = (240/del)*(25+freq)*sqrt(radius/(100*D))*(V-Vc)^2*10^(-5);
 
temp = 20:1:200;
pres = 20:1:200;
rad = 0:0.1:4;
m0_var = 0.6:0.01:1;
 
loss_temp_variation = (240./(3.92*pressureHg./(273+temp)))*(25+freq)*sqrt(radius./(100*D))*(V-Vc)^2*10^(-5);
loss_pressure_variation = (240./(3.92*pres./(273+temperature)))*(25+freq)*sqrt(radius./(100*D))*(V-Vc)^2*10^(-5);
 
temp_rad = 0;
temp_mv = 0;
max_loss_radius = 0.1;
max_loss = 0;
 
peeks_rad_loss = zeros(41);
peeks_m0_loss = zeros(41);
 
for i = 1:41
    temp_rad = temp_rad + 0.1;
    temp_mv = temp_mv + 0.01;
    peeks_rad_loss(i) = 241 * 10^(-5) * ((freq+25)/del) * sqrt(temp_rad/(100*D)) * (V - (temp_rad*g_o*m_o*del*log(100*D/temp_rad)))^2;
    peeks_m0_loss(i) = 241 * 10^(-5) * ((freq+25)/del) * sqrt(radius/(100*D)) * (V - (radius*g_o*temp_mv*del*log(100*D/radius)))^2;
    
    if peeks_rad_loss(i) > max_loss
        max_loss = peeks_rad_loss(i);
        max_loss_radius = temp_rad;
    end
end
 
fprintf('\n');
disp('Enter paramters to calculate equivalent HVDC Corona Loss Characteristics-');
H = input('Enter the mean height of conductors:');
S = input('Enter the pole spacing:');
g_surface_grad = input('Enter the maximum surface gradient :');
sub_conductors = input('Enter the number of sub-conductors :');
 
% DC conductor surface coeffecient is taken as 0.15-0.35 (practical average)
new_del = 3.92*pressureHg/75.01/(273+temperature);

% Plot for varying ratio of Spacing to Height; Check where it saturates
ratio_var = 1:1:100;
P_dc_ratio_loss = 2*V*((2/pi)*atan(2./ratio_var) + 1) * 0.25 * sub_conductors * radius/100 * 2^(0.25*(g_surface_grad-g_o*new_del)) * 10^(-3);
figure(4);
plot(ratio_var, P_dc_ratio_loss);

%Calculating fixed loss of given static inputs
P_dc_loss = 2*V*((2/pi)*atan(2*H/S) + 1) * 0.25 * sub_conductors * radius/100 * 2^(0.25*(g_surface_grad-g_o*new_del)) * 10^(-3);
 
%Calculate least ratio for HVDC loss
least_ratio = 0;
for j = 1:99
    if P_dc_ratio_loss(j) - P_dc_ratio_loss(j+1) <= 0.001
        least_ratio = j;
        break
    end
end

% Display computations back to user
fprintf('\n\nCritical Disruptive voltage = %f kV rms\n', Vc);
fprintf('Visual Disruptive voltage = %f kV rms\n', Vv);
fprintf('Maximum Radius Loss = %f cm\n', max_loss_radius);
fprintf('Equivalent DC Power Loss = %f kW/km\n', P_dc_loss);
fprintf('Least ratio of Height:Spacing for HVDC lines = %d:%d\n', 1, least_ratio);
fprintf('Corona loss = %f kW/ph/km\n\nPlotting power loss variation graphs...', Pc);
 
figure(1);
plot(temp, loss_temp_variation, pres, loss_pressure_variation);
title('Corona Power Loss vs Temprature & Pressure');
xlabel('Temperature(\circC) / Pressure (mm Hg)');
ylabel('Corona Power Loss (kW)');
legend('Temperature', 'Pressure');
 
figure(2);
plot(rad, peeks_rad_loss, m0_var, peeks_m0_loss);
title('Corona Power Loss & Radius by Peeks Formula');
xlabel('Radius (cm) / Irregularity Factor');
ylabel('Corona Power Loss (kW)');
legend('Radius Variation', 'Irregularity Factor Variation');
