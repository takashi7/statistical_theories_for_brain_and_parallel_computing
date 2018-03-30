function x = rnn_deterministic_binary(x_init, w)
%% Set the Initial Values
x = x_init;
size_x = size(x);
%% Calculation
for i = 2 : size_x(1,2)
    S = x * w(:,i);
    if S < 0
        x(:, i) = 0;
    else       
        x(:, i) = 1;  
    end
end

%% Output
fprintf('(x0  x1  x2  x3  x4  x5):')
disp(x);

end