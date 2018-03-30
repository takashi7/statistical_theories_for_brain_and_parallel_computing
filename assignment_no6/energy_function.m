function E = energy_function(x, w, theta, constant)
%% Calculation
E = 0;

for i = 1:4
    for j = 1:4
        E = E + theta(i, j) * x(i, j);
        for n = 1:4
            for m = 1:4               
                E = E + -1/2 * w(4*(i-1)+n, 4*(j-1)+m) * x(i, j) * x(n, m);
            end
        end
    end
end

E = E + constant;

%% Output
%fprintf('E:');
%disp(E);

end