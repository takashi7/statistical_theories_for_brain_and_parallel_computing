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

%% (3) Set the x state
fprintf('\n');
x_state = zeros(32, 5);
i = 1;
for j = [0 1]
    for k = [0 1]
        for l = [0 1]
            for m = [0 1]
                for n = [0 1]
                    x_state(i, :) = [j k l m n];
                    i = i + 1;
                end
            end
        end
    end
end

%% (3) Set 6 Initial Values for (x1, x2, ... x5) 
fprintf('Setting 6 Initial Values for (x1, x2, ... x5)\n');
x_init_a = [0 0 0 0 0];
x_init_b = [0 0 1 0 0];
x_init_c = [1 1 1 1 1];
x_init_nm = [x_init_a; x_init_b; x_init_c];

%% (5) Calculation of Probabilistic and Binary Model
fprintf('Start Calculating the RNN\n');
a_record = zeros(10,3);
count_record = zeros(10,32, 3);
iterate = 10000;
i = 1; j = 1;
for x_init = [x_init_a.' x_init_b.' x_init_c.']
    fprintf('\n x_init = (x0  x1  x2  x3  x4  x5):'); disp(x_init.');
    for a = 0:0.5:5
        fprintf('Calculate a = %.1f ...\n', a);
        a_record(i,j) = a;
        count_record(i, :, j) = rnn_probabilistic_binary(x_state, x_init.', w, theta, a, iterate);
        i = i + 1;
    end
    j = j + 1;
end

%% (5) Record in Excel
fprintf('Recording ...\n')
filename = 'record.xlsx';
record = [];
for j = 1:3
    record = [record; a_record(:, j), count_record(:, :, j)];
end
xlswrite(filename, record);