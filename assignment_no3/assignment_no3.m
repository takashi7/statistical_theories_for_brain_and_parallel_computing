%% Initialization
clear; close all; clc;

%% (1) Set the Coefficients of simultaneous equations
A_1 = [1 -2 1 2 -1];
A_2 = [-1 1 1 -1 -1];
A_3 = [2 1 -1 -2 -2];
A_4 = [1 2 -1 -1 -1];
A_5 = [-1 -1 1 1 1];
A = [A_1; A_2; A_3; A_4; A_5];
    
b = [2; -3; -2; -1; 1];
    
%% (2) Calculation of Coefficient
exist coefficient.mat file;
if ans == 0
    fprintf('coefficient.mat file does not exist\n');
    fprintf('Caluculating coefficient and make coefficient.mat\n');
    [w, theta, constant] = coefficient_function(A, b);    
    save('coefficient.mat', 'w', 'theta', 'constant');
else
    fprintf('coefficient.mat file exists\n');
    fprintf('loading coefficient.mat\n');
    load('coefficient.mat');
end

%% (3) Set 6 Initial Values for (x1, x2, ... x5) 
fprintf('Setting 6 Initial Values for (x1, x2, ... x5)\n');
x_init_a = [0 0 0 0 0];
x_init_b = [1 0 0 0 0];
x_init_c = [1 1 0 0 0];
x_init_d = [1 1 1 0 0];
x_init_e = [1 1 1 1 0];
x_init_f = [1 1 1 1 1];
x_init_nm = [x_init_a; x_init_b; x_init_c; x_init_d; x_init_e; x_init_f];

%% (4) Calculation of RNN using Deterministic and Binary Model
fprintf('Start Calculating the RNN\n');
x_deterministic = zeros(6, 5);
j = 1;
for x_init = [x_init_a.' x_init_b.' x_init_c.' x_init_d.' x_init_e.' x_init_f.']
    [x_deterministic(j, :), E_sequence] = rnn_deterministic_binary_function(x_init.', w, theta, constant);
    j = j + 1;
end

%% (5) Record in Excel
filename = 'record.xlsx';
record = [x_init_nm, x_deterministic];
xlswrite(filename, record);