% Lab 5

% Sample scenarios (used for testing purpose)
%   impedence = [1.25i,0.25i,0,0; 0.25i,0,0.4i,0.125i; 0,0.4i,1.25i,0.2i; 0, 0.125i, 0.2i, 0;];
%   impedence = [0.1i,0.2i,0,0.25i; 0.2i,0.1i,0.3i,0.4i; 0,0.3i,0,0.15i; 0.25i, 0.4i, 0.15i, 0;];

clear;
clc;

%Program Starts
n = input('Enter the number of buses :');

impedence = zeros(n,n);
visited = zeros(n);

for i = 1:n
    for j = 1:i
        if(i==j)
            impedence(i,j) = input(['Enter impedence between bus ' num2str(i) ' and ref. (Zero if not connected) :']);
        else
            impedence(i,j) = input(['Enter impedence ' num2str(i) '-' num2str(j) ' (Zero if not connected) :']);
            impedence(j,i) = impedence(i,j);
        end
    end
end

disp('Impedence Matrix (between individual buses)');
disp(impedence);

answer = zeros(n,n);

%Choice is to indicate type of connection
% 1 = New bus to ref.  
% 2 = New bus to existing Z
% 3 = Existing Z and ref.
% 4 = Line between 2 existing buses

choice = -1;
currentSize = 0;
temp = -1; %For case 2 - to check for visited bus

for i = 1:n
    for j = 1:i
        if impedence(i,j) == 0
            continue
        end
        
        if i==j && i==1
            choice = 1;
            
        elseif xor(visited(i),visited(j))
            if(visited(i) == 1)
                temp = i;
            else
                temp = j;
            end
            choice = 2;
            
        elseif i==j   
            choice = 3;
            
        elseif visited(i) == 1 && visited(j) == 1
            choice = 4;
        end
        
        switch choice
            case 1
                answer(1,1) = impedence(1,1);
                currentSize = 1;
                
            case 2
                answer(:,currentSize+1) = answer(:,temp);
                answer(currentSize+1,:) = answer(temp,:);
                answer(currentSize+1, currentSize+1) = answer(temp, temp) + impedence(i,j);
                
                currentSize = currentSize + 1;
            case 3
                intermediate = zeros(n,n);
                for x=1:currentSize
                    for y=1:currentSize
                        intermediate(x,y) = answer(x,i)*answer(i,y);
                    end
                end
                                   
              intermediate = (1/(impedence(i,i) + answer(i,i)))*intermediate;
              answer = answer - intermediate;
              
              counter = currentSize+1;         
              while counter <= n
                  answer(:,counter) = 0;
                  answer(counter,:) = 0;
                  counter = counter + 1;
              end
                               
            case 4          
                intermediate = zeros(n,n);
                for x=1:n
                    for y=1:n
                        intermediate(x,y) = (answer(x,i)-answer(x,j))*(answer(i,y)-answer(j,y));
                    end
                end                           
                
                intermediate = (1/(answer(i,i) + answer(j,j) + impedence(i,j) - 2*answer(i,j)))*intermediate;
                answer = answer - intermediate;         
        end        
        
        visited(i) = 1;
        visited(j) = 1;
        
    end
end

disp('Z-bus');
disp(answer);