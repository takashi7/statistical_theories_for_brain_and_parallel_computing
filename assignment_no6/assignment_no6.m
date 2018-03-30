%% Initialization
clear; close all; clc;
    
%% (1) Distance
% city1: Tokyo
% city2: kanagawa
% city3: tiba
% city4: saitama
distance = [0 27 40 19; ...
            27 0 47 45; ...
            40 47 0 51; ...
            19 45 51 0];
       
%% (2) Calculation of Coefficient
exist coefficient.mat file;
if ans == 0
    fprintf('coefficient.mat file does not exist\n');
    fprintf('Caluculating coefficient and make coefficient.mat\n');
    %[w, theta, constant] = coefficient_function(distance, beta_constarain);   
    i = 1;
    for beta_constarain = [0.1 1 10 50 100 500 1000]
        [w(:,:,i), theta(:,:,i), constant(i)] = coefficient_function(distance, beta_constarain);    
        i = i + 1;
    end
    save('coefficient.mat', 'w', 'theta', 'constant');
else
    fprintf('coefficient.mat file exists\n');
    fprintf('loading coefficient.mat\n');
    load('coefficient.mat');
end

%% (3) Calculation of the State of Solution
exist x_solution.mat file;
if ans == 0
    fprintf('x_solution.mat file does not exist\n');
    fprintf('Caluculating x_solution and make x_solution.mat\n');
    %[E_min, x_solution] = all_traveling_state_function(w, theta, constant);  
    for i = 1:7
        [E_min_store(i), x_solution_store(:,:,:,i), A_coeff(i, :), ideal_mean(i,:), ideal_sum(i,:), ideal_size(:,:,i)] = all_traveling_state_function(w(:,:,i), theta(:,:,i), constant(i));  
    end
    E_min = E_min_store(1);
    x_solution = x_solution_store(:,:,:,1);
    save('x_solution.mat', 'E_min', 'x_solution');
    % Record in Excel
    fprintf('Recording ...\n')
    filename = 'ideal_number.xlsx';
    ideal_number = [A_coeff, round(ideal_mean,1), round(ideal_sum,1)];
    xlswrite(filename, ideal_number);
    fprintf('Finish Recording\n');
else
    fprintf('x_solution.mat file exists\n');
    fprintf('loading x_solution.mat\n');
    load('x_solution.mat');
end

%% (4) Set 16 Initial Values for (x11, x12, ... x44) 
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
x_init_d = [1 1 1 1; ...
            1 1 1 1; ...
            1 1 1 1; ...
            1 1 1 1];

%% (5) Calculation of RNN using Probabilistic and Binary Model
fprintf('Start Calculating the RNN using Probabilistic and Binary Model\n');
count_record = zeros(4, 8, 4, 7);
iterate = 100000;
i = 1;
for beta_constarain = [0.1 1 10 50 100 500 1000]
    fprintf('start beta_constarain: %f\n', beta_constarain);
    j = 1;
    for a = [0 0.5 1 5]
        fprintf('Calculate a = %.1f ...\n', a);
        count_record(1, :, j, i) = rnn_probabilistic_binary_function(x_init_a, w(:,:,i), theta(:,:,i), constant(i), a, iterate, E_min, x_solution, 1, beta_constarain);
        count_record(2, :, j, i) = rnn_probabilistic_binary_function(x_init_b, w(:,:,i), theta(:,:,i), constant(i), a, iterate, E_min, x_solution, 2, beta_constarain);
        count_record(3, :, j, i) = rnn_probabilistic_binary_function(x_init_c, w(:,:,i), theta(:,:,i), constant(i), a, iterate, E_min, x_solution, 3, beta_constarain);
        count_record(4, :, j, i) = rnn_probabilistic_binary_function(x_init_d, w(:,:,i), theta(:,:,i), constant(i), a, iterate, E_min, x_solution, 4, beta_constarain);
        j = j + 1;
    end
    fprintf('finish beta_constarain: %f\n', beta_constarain);
    i = i + 1;
    fprintf('\n');
end 

%% (6) Record in Excel
fprintf('Recording ...\n')
filename = 'probabilistic.xlsx';
beta_constarain = [0.1 1 10 50 100 500 1000];                   
beta_all = [beta_constarain; beta_constarain; beta_constarain; beta_constarain];
a = [0 0.5 1 5];
a_all = [a; a; a; a];
probabilistic = [];
for i = 1:7
    for j = 1:4
        probabilistic = [probabilistic; beta_all(:, i), a_all(:, j), count_record(:, :, j, i)];
    end
end
xlswrite(filename, probabilistic);
fprintf('Finish Recording\n');           