function [y, expected, experiment] = probabilistic_binary(x, w, a, iterate)
%% Calculation
S = x * w.';
p = 1/(1 + exp((-1)* a * S));
y = zeros(iterate, 1);
count = 0;
for i = 1:iterate
    if rand < 1 * p || rand == 1 * p
        y(i) = 1;
        count = count + 1;
    end
end

%% Output
expected = round(iterate * p);
experiment = count;
error = abs(experiment - expected) / expected * 100;
fprintf('   %0.2f   %d   %d   %d   %d   \n', a,iterate,expected,experiment,round(error));

end