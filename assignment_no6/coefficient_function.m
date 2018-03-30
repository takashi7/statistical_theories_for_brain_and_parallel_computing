function [w, theta, constant] = coefficient_function(distance, beta_constarain)
%% Set the Initial Values
x = zeros(4);
alpah = zeros(4);
beta = zeros(16);
theta = zeros(4);
w = zeros(16);

%%
constant = travelling_salesman_energy_function(x, distance, beta_constarain);

for i = 1:4
    for j = 1:4
        x(i, j) = 1;
        alpah(i, j) = travelling_salesman_energy_function(x, distance, beta_constarain);
        theta(i, j) = alpah(i, j) - constant;
        x(x == 1) = 0;
    end 
end

for i = 1:4
    for j = 1:4
        for n = 1:4
            for m = 1:4
                x(i, j) = 1;
                x(n, m) = 1;
                beta(4*(i-1)+n, 4*(j-1)+m) = travelling_salesman_energy_function(x, distance, beta_constarain);
                if i == n && j == m
                    w(4*(i-1)+n, 4*(j-1)+m) = 0;
                else
                    w(4*(i-1)+n, 4*(j-1)+m) = alpah(n, m) + alpah(i, j) - beta(4*(i-1)+n, 4*(j-1)+m) - constant;
                end
                x(x == 1) = 0;
            end
        end
    end
end

fprintf('w: \n');
disp(w);
fprintf('theta: \n');
disp(theta);
fprintf('constant: \n');
disp(constant);

end