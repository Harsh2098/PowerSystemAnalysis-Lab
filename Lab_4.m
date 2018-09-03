n = input('Enter number of buses: ');

admittance = zeros(n,n);
charging = zeros(n,n);

for i = 1:n
    for j = 1:n
        admittance(i,j) = input(['Enter admittance ' num2str(i) '-' num2str(j) ' :']);
    end
end

for i = 1:n
    for j = 1:n
        charging(i,j) = input('Enter charging admittance :');
    end
end

answer = zeros(n,n);

for i = 1:n
    for j = 1:n
        if i == j
            for x = 1:n
                answer(i,j) = answer(i,j) + admittance(i,x) + charging(i,x);
            end
        else
            answer(i,j) = admittance(i,j) * -1;
        end
    end
end
