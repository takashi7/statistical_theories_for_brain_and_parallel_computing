function E = travelling_salesman_energy_function(x, distance, beta_constarain)
%% Set the Initial Values
E_row = 0;
E_column = 0;
E_length = 0;

%% Length Term
for i = 1:4
    for j = 1:4
        for k =1:4
            if i < 4
                E_length = E_length + x(j, i) * x(k, i+1) * distance(j, k);
            else
                E_length = E_length + x(j, i) * x(k, 1) * distance(j, k);
            end
        end
    end
end

%% Constraing Term
for i = 1:4
    E_row = E_row + (sum(x(i, :)) -1)^2;
    E_column = E_column + (sum(x(:, i)) -1)^2;
end

%% Energy
E = E_length + beta_constarain * (E_row + E_column);

end