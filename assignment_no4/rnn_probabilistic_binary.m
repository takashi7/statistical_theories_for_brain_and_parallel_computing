function count = rnn_probabilistic_binary(x_state, x_init, w, theta, a, iterate)
%% Set the Initial Values
size_x = size(x_init);
x = zeros(iterate, size_x(1, 2));
x_update = x_init;

%{
for k = 1:iterate
    x(k,:) = x_init;
end
%}

count = zeros(1, 32);

iterate_count = 1;

%% Calculation
for i = 1 : iterate
    if mod(i, 100) == 0
        fprintf('iterate : %d\n', i);
    end
    for j = 1 : size_x(1,2)
        S = x_update * w(:,j) - theta(j);
        p = 1/(1 + exp((-1)* a * S));
        if rand > 1 * p
            x_update(j) = 0;
        else
            x_update(j) = 1;
        end
    end
        
    for s = 1:32
        if x_update ==  x_state(s, :)
            count(s) = count(s) + 1;
            break;
        end
    end
    
    x(i, :) = x_update;
        
end

%% Output
%fprintf('a: %.2f   count: %d \n', a, count);
%disp(x);
end