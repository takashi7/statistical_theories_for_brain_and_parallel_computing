function E = error_function(q, p)
%% Set the Initial Values
E = 0;

%% Computation
for i = 1:8
    if q(i) == 0
        continue;
    else
        E = E + q(i) * log(q(i) / (p(i) + 1e-10));
    end
end

%% Output
%fprintf('E = %d \n', E);

end