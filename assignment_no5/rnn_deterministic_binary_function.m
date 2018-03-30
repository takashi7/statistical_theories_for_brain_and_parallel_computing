function [x, E_sequence] = rnn_deterministic_binary_function(x_init, w, theta, constant)
%% Set the Initial Values
x = x_init;
size_x = size(x);
E_sequence = [];
local_count = 0;
local = [];

%% Calculation
E = energy_function(x, w, theta, constant);
E_sequence = [E_sequence, E];
while E > 0
    for i = 1 : size_x(1,1)
        for j = 1 : size_x(1, 2)
            %fprintf('(i, j) = (%d, %d)\n', i,j);
            w_s = w(4*i-3:4*i, 4*j-3:4*j);
            S = sum(sum(x .* w_s)) - theta(i, j);
            if S < 0
                x(i, j) = 0;
            else
                x(i, j) = 1;
            end
            %disp(x);
            E = energy_function(x, w, theta, constant);
            E_sequence = [E_sequence, E];
            if E == 0 || E < 0
                break;
            end
            %fprintf('(i, j) = (%d, %d)\n', i,j);
            %fprintf('E: %d\n', E);
        end
        if E == 0 || E < 0
            break;
        end
    end
    local_count =local_count + 1;    
    local = [local E];
    if local_count > 3
        if local(local_count - 2) == local(local_count)
            fprintf('Local Minima\n');
            break;
        end
    end
end

%% Output
fprintf('Initial Values (x1  x2  x3  x4  x5): \n');
disp(x_init);
fprintf('Energy Sequence: \n');
disp(E_sequence.');
fprintf('Solution       (x1  x2  x3  x4  x5): \n');
disp(x);

end