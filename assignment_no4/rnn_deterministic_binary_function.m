function [x, E_sequence] = rnn_deterministic_binary_function(x_init, w, theta, constant)
%% Set the Initial Values
x = x_init;
size_x = size(x);
E_sequence = [];

%% Calculation
E = energy_function(x, w, theta, constant);
E_sequence = [E_sequence, E];
while E > 0
    for i = 1 : size_x(1,2)        
        S = x * w(:,i) - theta(i);
        if S < 0
            x(:, i) = 0;
        else
            x(:, i) = 1;
        end
        
        E = energy_function(x, w, theta, constant);
        E_sequence = [E_sequence, E];
        if E == 0 || E < 0
            break;
        end
        
    end
end

%% Output
fprintf('Initial Values (x1  x2  x3  x4  x5): ');
disp(x_init);
fprintf('Energy Sequence: ');
disp(E_sequence);
fprintf('Solution       (x1  x2  x3  x4  x5): ');
disp(x);

end