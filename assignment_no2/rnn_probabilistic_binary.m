function count = rnn_probabilistic_binary(x_init, w, a, iterate)
%% Set the Initial Values
size_x = size(x_init);
x = ones(iterate, size_x(1, 2));
for k = 1:iterate
    x(k,:) = x_init;
end

x_zero = [1 1 0 0 0 0];
count = 0;

%% Calculation
for j = 1 : iterate
    for i = 2 : size_x(1,2)
        S = x(j, :) * w(:,i);
        p = 1/(1 + exp((-1)* a * S));
        if rand > 1 * p
            x(j, i) = 0;
        else
            x(j, i) = 1;
        end
    end
    if sqrt((x(j,:) - x_zero) * (x(j,:) - x_zero).') < 2
        count = count + 1;
    end
end

%% Output
%fprintf('a: %.2f   count: %d \n', a, count);
disp(x);
end