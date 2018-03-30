function [p, a_p_nm] = rnn_probabilistic_binary_function(w, theta, a, iterate, x_init, x_state, n, m)
%% Set the Initial Values
size_x = size(x_init);
x = zeros(iterate, size_x(1, 2));
x_update = x_init;
count = zeros(1, 8);

%% Computation
for i = 1 : iterate
    for j = 1 : size_x(1,2)
        S = x_update * w(:,j) - theta(j);
        p = 1/(1 + exp((-1)* a * S));
        if rand > 1 * p
            x_update(j) = 0;
        else
            x_update(j) = 1;
        end
    end
        
    for s = 1:8
        if x_update ==  x_state(s, 2:end)
            count(s) = count(s) + 1;
            break;
        end
    end    
    x(i, :) = x_update;        
end

%% p and a_p_nm
sum_count = sum(count);
p = count / sum_count;
a_p_nm = p * (x_state(:, n) .* x_state(:, m));

%% Output
%fprintf('a: %.2f   count: %d \n', a, count);
%disp(x);
end