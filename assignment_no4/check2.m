%{
if x == x_state
    fprintf('ok\n');
else
    fprintf('no\n')
end
%}
%{
count = zeros(32, 1);
    for s = 1:32
        if x ==  x_state(s, :)
            count(s) = count(s) + 1;
            break;
        end
        fprintf('s: %d\n', s);
    end
 %}
%% Initialization
clear; close all; clc;

%% coefficient
fprintf('coefficient\n');
load('coefficient.mat')


%% x_state
fprintf('x_state\n');
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

%% calculate
%{
fprintf('calculate\n');
iterate = 30;
a = 5;
x_ini = [0 0 0 0 0];
count = rnn_probabilistic_binary(x_state, x_ini, w, theta, a, iterate);
find(count == max(count)) % 20
%}

%%
fprintf('Start Calculating the RNN\n');
a_record = zeros(3,2);
count_record = zeros(3,32, 2);
count_max = zeros(3, 2);
iterate = 20;
x_ini_a = [0 0 0 0 0]; x_ini_b= [1 1 1 1 1];

i = 1; j = 1;
for x_ini = [x_ini_a.' x_ini_b.']
    fprintf('\n x_ini = (x0  x1  x2  x3  x4  x5):'); disp(x_ini.');
    for a = [0 0.5 5]
        fprintf('Calculate a = %.1f ...\n', a);
        a_record(i,j) = a;
        count_record(i, :, j) = rnn_probabilistic_binary(x_state, x_ini.', w, theta, a, iterate);
        %count_max(i, j) = find(count_record(i, :, j) == max(count_record(i, :, j))); % 20
        i = i + 1;
    end
    j = j + 1;
end

%fprintf('count_max :  \n');
%disp(count_max);

%% (5) Record in Excel
filename = 'record.xlsx';
record = [];
for j = 1:2
    record = [record; a_record(:, j), count_record(:, :, j)];
end
xlswrite(filename, record);