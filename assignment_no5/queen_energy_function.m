function E = queen_energy_function(x)
%% 
E_row = 0;
E_column = 0;

%%
for i = 1:4
    E_row = E_row + (sum(x(i, :)) -1)^2;
    E_column = E_column + (sum(x(:, i)) -1)^2;
end

E = E_row + E_column;

end