%% Initialization
clear ; close all; clc

%% (1) Set a dummy neuron
x0 = 1;
theta = -0.5;
%% (2) Set 6 Initial Values for (x1, x2, ... x5) 
x_init_a = [x0 0 0 0 0 0];
x_init_b = [x0 1 0 0 0 0];
x_init_c = [x0 1 1 0 0 0];
x_init_d = [x0 1 1 1 0 0];
x_init_e = [x0 1 1 1 1 0];
x_init_f = [x0 1 1 1 1 1];
%% (3) Set Connection Weights
w0 = [0 -theta -theta -theta -theta -theta];
w1 = [0 0 -1 -1 -1 -1];
w2 = [0 -1 0 -1 -1 -1];
w3 = [0 -1 -1 0 -1 -1];
w4 = [0 -1 -1 -1 0 -1];
w5 = [0 -1 -1 -1 -1 0];
w = [w0; w1; w2; w3; w4; w5];

%% (4) Calculation of Deterministic and Binary Model
x_deterministic = zeros(6);
j = 1;
for x_init = [x_init_a.' x_init_b.' x_init_c.' x_init_d.' x_init_e.' x_init_f.']
    x_deterministic(j, :) = rnn_deterministic_binary(x_init.', w);
    j = j + 1;
end

%% (5) Calculation of Probabilistic and Binary Model
a_record = zeros(20,6);
count_record = zeros(20,6);
iterate = 10000;
i = 1; j = 1;
for x_init = [x_init_a.' x_init_b.' x_init_c.' x_init_d.' x_init_e.' x_init_f.']
    fprintf('\n x_init = (x0  x1  x2  x3  x4  x5):'); disp(x_init.');
    for a = 0:0.5:10
        a_record(i,j) = a;
        count_record(i,j) = rnn_probabilistic_binary(x_init.', w, a, iterate);
        i = i + 1;
    end
    j = j + 1;
end

%% (6) Record in Excel
filename = 'record.xlsx';
record = [a_record(1:21,1) count_record(1:21,1) a_record(22:42,2) count_record(22:42,2) a_record(43:63,3) count_record(43:63,3) a_record(64:84,4) count_record(64:84,4) a_record(85:105,5) count_record(85:105,5) a_record(106:126,6) count_record(106:126,6)];
xlswrite(filename, record);