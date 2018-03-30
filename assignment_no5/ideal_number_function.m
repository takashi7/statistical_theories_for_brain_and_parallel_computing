function x_state_max = ideal_number_function(w, theta, constant)
%% (1) Calculation of Coefficient
exist x_state.mat file;
if ans == 0
    fprintf('x_state.mat file does not exist\n');
    fprintf('Caluculating coefficient and make coefficient.mat\n');
    x_state = x_state_function;  
    save('x_state.mat', 'x_state');
else
    fprintf('x_state.mat file exists\n');
    fprintf('loading x_state.mat\n');
    load('x_state.mat');
end

%% Set the Initial Values
x_size = size(x_state); 
energy_state = zeros(x_size(3), 1);
%A_coeff = zeros(10, 1);
ideal = zeros(x_size(3), 1);
N = 1000000;
a = 5;

%% Calculation
for i = 1:x_size(3)
    energy_state(i) = energy_function(x_state(:, :, i), w, theta, constant);
end

A_coeff = 1/ sum(exp((-a) * energy_state));
ideal(:, 1) = N * A_coeff * exp((-a) * energy_state);
[Max, Index] = max(ideal);
fprintf('Max_ideal: %f,   Max_index: %d\n', Max, Index);
x_state_max = x_state(:, :, Index);
fprintf('x_state_max: \n');
disp(x_state_max);

%energy_mini = energy_function(x_state_max, w, theta, constant);
%disp(energy_mini);

%% Output
%fprintf('energy_state:\n');
%disp(energy_state);
%fprintf('ideal:\n');
%disp(ideal);
fprintf('A_coeff:\n');
disp(A_coeff);
fprintf('ideal_sum:\n');
disp(sum(ideal));

%{
%% Record in Excel
filename = 'ideal.xlsx';
record = [energy_state round(ideal)];
xlswrite(filename, record);
%}

end