function ideal = ideal_number_function(x_state, w, theta, constant)
%% Set the Initial Values
x_size = size(x_state); 
energy_state = zeros(x_size(1), 1);
A_coeff = zeros(10, 1);
ideal = zeros(x_size(1), 10);
N = 10000;

%% Calculation
for i = 1:x_size(1)
    energy_state(i) = energy_function(x_state(i, :), w, theta, constant);
end

j = 1;
for a = 0:0.5:5
    A_coeff(j) = 1/ sum(exp((-a)*energy_state));
    ideal(:, j) = N * A_coeff(j) * exp((-a)*energy_state);
    j = j + 1;
end

%% Output
fprintf('energy_state:\n');
disp(energy_state);
fprintf('ideal:\n');
disp(ideal);
fprintf('A_coeff:\n');
disp(A_coeff);
fprintf('ideal_sum:\n');
disp(sum(ideal));

%% Record in Excel
filename = 'ideal.xlsx';
record = [energy_state round(ideal)];
xlswrite(filename, record);

end