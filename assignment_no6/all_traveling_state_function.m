function [E_min, x_solution, A_coeff, ideal_mean, ideal_sum, ideal_size] = all_traveling_state_function(w, theta, constant)
%% Set the Initial Values
x_all_traveling = E_zero_function;
size_x_all_traveling = size(x_all_traveling);
E_all_traveling = zeros(1, size_x_all_traveling(3));
index_solution = [];
city_order = zeros(4, size_x_all_traveling(3));
%
x_all_state = x_state_function; 
size_x_all_state = size(x_all_state); 
E_all_state = zeros(1, size_x_all_state(3));
index_state = [];
N = 100000;

%% Calculation
% Calculate the Minimum Energy
for i = 1:size_x_all_traveling(3)
    E_all_traveling(i) = energy_function(x_all_traveling(:,:,i), w, theta, constant);
end
E_min = min(E_all_traveling);

% Calculate the states of solution
for j = 1:size_x_all_traveling(3)
    if E_all_traveling(j) == E_min
        index_solution = [index_solution, j];
    end
end
x_solution = x_all_traveling(:, :, index_solution);

% Calculate the all order of traveling
for k = 1:size_x_all_traveling(3)
    for order = 1:4
        city_order(order, k) = find(x_all_traveling(:, order, k));
    end
end

% Calculate the ideal number of solution state
for l = 1:size_x_all_state(3)
    E_all_state(l) = energy_function(x_all_state(:,:,l), w, theta, constant);
    if E_all_state(l) == E_min
        index_state = [index_state, l];
    end
end
a_num = 1;
for a = [0 0.5 1 5]
    A_coeff(:, a_num) = 1/ sum(exp((-a) * E_all_state));
    ideal_number(:, 1) = N * A_coeff(:, a_num) * exp((-a) * E_all_state);
    ideal_solution(:, a_num) = ideal_number(index_state, 1);
    a_num = a_num + 1;
end
ideal_mean = mean(ideal_solution);
ideal_sum = sum(ideal_solution);
ideal_size = size(ideal_solution);

%% Output
%{
fprintf('E_min\n');
disp(E_min);
fprintf('x_solution\n');
disp(x_solution);
fprintf('A_coeff:\n');
disp(A_coeff);
fprintf('ideal_solution:\n');
disp(ideal_solution);

%% Record in Excel
fprintf('Recording ...\n')
filename = 'all_travelling.xlsx';
all_travelling = [city_order; E_all_traveling];
xlswrite(filename, all_travelling);
fprintf('Finish Recording\n');
%}
end


%% function 
% (1) E_zero_function(w, theta, constant)
% (2) coefficient_function
% (3) queen_energy_function(x)
% (4) x_state_function

%% (1) E_zero_function(w, theta, constant)
    function x_ideal = E_zero_function
        %% Calculate Coefficient and all x_state
        [w, theta, constant] = coefficient_function;
        x_state = x_state_function;  
        %% Set the Initial Values
        x_size = size(x_state); 
        energy_state = zeros(x_size(3), 1);
        %% Calculation
        for i = 1:x_size(3)
            energy_state(i) = energy_function(x_state(:, :, i), w, theta, constant);
        end
        x_ideal = x_state(:, :, find(~energy_state));        
    end

%% (2) coefficient_function
    function [w, theta, constant] = coefficient_function
        %% Set the Initial Values
        x = zeros(4);
        alpah = zeros(4);
        beta = zeros(16);
        theta = zeros(4);
        w = zeros(16);
        %% Calculation
        constant = queen_energy_function(x);
        for i = 1:4
            for j = 1:4
                x(i, j) = 1;
                alpah(i, j) = queen_energy_function(x);
                theta(i, j) = alpah(i, j) - constant;
                x(x == 1) = 0;
            end 
        end
        for i = 1:4
            for j = 1:4
                for n = 1:4
                    for m = 1:4
                        x(i, j) = 1;
                        x(n, m) = 1;
                        beta(4*(i-1)+n, 4*(j-1)+m) = queen_energy_function(x);
                        if i == n && j == m
                            w(4*(i-1)+n, 4*(j-1)+m) = 0;
                        else
                            w(4*(i-1)+n, 4*(j-1)+m) = alpah(n, m) + alpah(i, j) - beta(4*(i-1)+n, 4*(j-1)+m) - constant;
                        end
                        x(x == 1) = 0;
                    end
                end
            end
        end
    end

%% (3) queen_energy_function(x)
    function E = queen_energy_function(x)
        %% Set the Initial Values 
        E_row = 0;
        E_column = 0;
        %% Calculation
        for i = 1:4
            E_row = E_row + (sum(x(i, :)) -1)^2;
            E_column = E_column + (sum(x(:, i)) -1)^2;
        end
        E = E_row + E_column;
    end

%% (4) x_state_function
    function x_state = x_state_function
        %% Set the Initial Values 
        x_state = zeros(4, 4, 2^16);
        %% Calculation
        i = 1;
        for j_1 = [0 1]
            for j_2 = [0 1]
                for j_3 = [0 1]
                    for j_4 = [0 1]
                        for j_5 = [0 1]
                            for j_6 = [0 1]
                                for j_7 = [0 1]
                                    for j_8 = [0 1]
                                        for j_9 = [0 1]
                                            for j_10 = [0 1] 
                                                for j_11 = [0 1]
                                                    for j_12 = [0 1]
                                                        for j_13 = [0 1]
                                                            for j_14 = [0 1]
                                                                for j_15 = [0 1]
                                                                    for j_16 = [0 1]
                                                                        x_state(:, :, i) = [j_1 j_2 j_3 j_4; ...
                                                                                            j_5 j_6 j_7 j_8; ...
                                                                                            j_9 j_10 j_11 j_12; ...
                                                                                            j_13 j_14 j_15 j_16];
                                                                        i = i + 1;
                                                                    end
                                                                end
                                                            end
                                                        end
                                                    end
                                                end
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
    end           