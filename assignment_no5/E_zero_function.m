function x_ideal = E_zero_function(w, theta, constant)
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
N = 1000000;
a = 5;

%% Calculation
for i = 1:x_size(3)
    energy_state(i) = energy_function(x_state(:, :, i), w, theta, constant);
end

x_ideal = x_state(:, :, find(~energy_state));
%disp(x_ideal);

end

