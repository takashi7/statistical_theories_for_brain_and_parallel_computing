x = [1 0 0 1 1];
E_store = 0;
x_nm = x.' * x;
for k = 1 : 5
    E_store = E_store + w(k,:) * x_nm(:, k);
end
E = -1/2 * E_store + theta * x.' + constant