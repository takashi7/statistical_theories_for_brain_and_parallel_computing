%% Initialization
clear; close all; clc;
    
%% (1) Calculation of Coefficient
exist coefficient.mat file;
if ans == 0
    fprintf('coefficient.mat file does not exist\n');
    fprintf('Caluculating coefficient and make coefficient.mat\n');
    [w, theta, constant] = coefficient_function;    
    save('coefficient.mat', 'w', 'theta', 'constant');
else
    fprintf('coefficient.mat file exists\n');
    fprintf('loading coefficient.mat\n');
    load('coefficient.mat');
end

%% (2) Set 16 Initial Values for (x11, x12, ... x44) 
fprintf('Setting 6 Initial Values for (x11, x12, ... x44)\n');
x_init_a = [0 0 0 0; ...
            0 0 0 0; ...
            0 0 0 0; ...
            0 0 0 0];
x_init_b = [1 1 1 1; ...
            0 0 0 0; ...
            0 0 0 0; ...
            0 0 0 0];
x_init_c = [1 0 0 0; ...
            1 0 0 0; ...
            1 0 0 0; ...
            1 0 0 0];
x_init_d = [1 0 0 1; ...
            0 1 1 0; ...
            0 1 1 0; ...
            1 0 0 1];        
x_init_e = [1 1 1 1; ...
            1 1 1 1; ...
            1 1 1 1; ...
            1 1 1 1];
        
%% (3) Calculation of RNN using Deterministic and Binary Model
fprintf('Start Calculating the RNN using Deterministic and Binary Model\n');
[x_deterministic_a, E_sequence_a] = rnn_deterministic_binary_function(x_init_a, w, theta, constant);
[x_deterministic_b, E_sequence_b] = rnn_deterministic_binary_function(x_init_b, w, theta, constant);
[x_deterministic_c, E_sequence_c] = rnn_deterministic_binary_function(x_init_c, w, theta, constant);
[x_deterministic_d, E_sequence_d] = rnn_deterministic_binary_function(x_init_d, w, theta, constant);
[x_deterministic_e, E_sequence_e] = rnn_deterministic_binary_function(x_init_e, w, theta, constant);
 
%% (4) Record in Excel
fprintf('Recording ...\n')
filename = 'deterministic.xlsx';
deterministic = [x_init_a, x_init_b, x_init_c, x_init_d, x_init_e; ...
                 x_deterministic_a, x_deterministic_b, x_deterministic_c, x_deterministic_d, x_deterministic_e];         
xlswrite(filename, deterministic);
fprintf('Finish Recording\n');

%% (5) Calculate the most frequent state x_ideal
x_ideal = E_zero_function(w, theta, constant);

%% (6) Calculation of RNN using Probabilistic and Binary Model
fprintf('Start Calculating the RNN using Probabilistic and Binary Model\n');
count_record = zeros(3, 24, 3);
iterate = 1000000;
i = 1;
for a = [0 0.5 5]
    fprintf('Calculate a = %.1f ...\n', a);
    count_record(1, :, i) = rnn_probabilistic_binary_function(x_init_a, w, theta, constant, a, iterate, x_ideal, 1);
    count_record(2, :, i) = rnn_probabilistic_binary_function(x_init_c, w, theta, constant, a, iterate, x_ideal, 2);
    count_record(3, :, i) = rnn_probabilistic_binary_function(x_init_e, w, theta, constant, a, iterate, x_ideal, 3);
    i = i + 1;
end

%% (7) Record in Excel
fprintf('Recording ...\n')
filename = 'probabilistic.xlsx';
probabilistic = [];
for i = 1:3
    probabilistic = [probabilistic; count_record(:, :, i)];
end
xlswrite(filename, probabilistic);
fprintf('Finish Recording\n');