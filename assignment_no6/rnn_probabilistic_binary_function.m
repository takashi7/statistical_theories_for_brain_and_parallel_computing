function count = rnn_probabilistic_binary_function(x_init, w, theta, constant, a, iterate, E_min, x_solution, id, beta_constarain)
%% Set the Initial Values
size_x = size(x_init);
%x = zeros(iterate, size_x(1, 2));
x_update = x_init;
count = zeros(1, 8);

%% Calculation
for i = 1 : iterate
    if mod(i, 10000) == 0
        fprintf('(beta_constarain, a, id, iterate) = (%.1f, %.1f, %d, %d)\n', beta_constarain, a, id, i);
        disp(count);
        %fprintf('x_update\n');
        %disp(x_update);
    end
    for j = 1 : size_x(1,1)
        for k = 1 : size_x(1,2)            
            w_s = w(4*j-3:4*j, 4*k-3:4*k);
            S = sum(sum(x_update .* w_s)) - theta(j, k);            
            p = 1/(1 + exp((-1)* a * S));
            if rand > 1 * p
                x_update(j, k) = 0;
            else
                x_update(j, k) = 1;
            end          
        end
    end
    
    E = energy_function(x_update, w, theta, constant);
    if E == E_min
        for s = 1:8
            if x_update ==  x_solution(:, :, s)
                count(s) = count(s) + 1;
                break;
            end
        end
    end
end

%% Output
%fprintf('a: %.2f   count: %d \n', a, count);
%disp(x);
end