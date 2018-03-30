function E = energy_function(x, w, theta, constant)
%% Calculation
E_store = 0;
x_nm = x.' * x;
for k = 1 : 5
    E_store = E_store + w(k,:) * x_nm(:, k);
end
E = double(-1/2 * E_store + theta * x.' + constant);

%% Output
%fprintf('E:');
%disp(E);

end