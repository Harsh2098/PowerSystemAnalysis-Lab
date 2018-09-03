% Defining constant
k = 2 * 10^(-7);

D = 1;
s = 0.1;
r = 0.01;
rd = r*0.7788;

disp('1. Inductance of 3-phase transmission line with 1 sub');
disp('2. Inductance of 3-phase transmission line with 2 sub');
disp('3. Inductance of 3-phase transmission line with 3 sub');
disp('4. Inductance of 3-phase transmission line with 4 sub');
choice = input('Choice :');

answer = -1;

switch choice
    case 1
        answer = 2*k*log(D/rd);
        
    case 2 
        answer = 2*k*log(D/(sqrt(rd*s)));
        
    case 3
        temp = (rd*s*s)^(0.33334);
        answer = 2*k*log(D/(temp*((rd*s*2*s)^(0.066667)*temp))^(1/2));
        
    case 4
        answer = 2*k*log(D/(rd*4*r*r*sqrt(8)*r)^0.25);
        
end

disp(answer);
        
        