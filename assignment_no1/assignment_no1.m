%% Initialization
clear ; close all; clc
expected = zeros(400,1);
experiment = zeros(400,1);
a_record = zeros(400,1);
iterate_record = zeros(400,1);

%% Set Inputs and Weights
x = [1 0 -1 0 1];
w = [1 2.0 1.2 1.5 -0.5];

%% Calculation
i = 1;
fprintf('   a   Iterate   Expected   Experiment   Error   \n');
for iterate = 1000:500:10000
    for a = 0:0.5:10
        [y, expected(i), experiment(i)] = probabilistic_binary(x, w, a, iterate);
        a_record(i) = a;
        iterate_record(i) = iterate;
        i = i + 1;
    end
end

%% Record in Excel
filename = 'record.xlsx';
record = [a_record iterate_record expected experiment];
xlswrite(filename, record);