function [w, theta, constant] = coefficient_function(A, b)
%% Expand
syms x1 x2 x3 x4 x5;
x = [x1; x2; x3; x4; x5];
E = expand((A(1, :) * x - b(1))^2 + ...
           (A(2, :) * x - b(2))^2 + ...
           (A(3, :) * x - b(3))^2 + ...
           (A(4, :) * x - b(4))^2 + ...
           (A(5, :) * x - b(5))^2 );
fprintf('E = ');
disp(E);
[c, t] = coeffs(E);

%% Set the Coefficient
w_1 = [0, -c(2), -c(3), -c(4), -c(5)];
w_2 = [-c(2), 0, -c(8), -c(9), -c(10)];
w_3 = [-c(3), -c(8), 0, -c(13), -c(14)];
w_4 = [-c(4), -c(9), -c(13), 0, -c(17)];
w_5 = [-c(5), -c(10), -c(14), -c(17), 0];
w = [w_1; w_2; w_3; w_4; w_5];
  
theta = [c(1)+c(6), c(7)+c(11), c(12)+c(15), c(16)+c(18), c(19)+c(20)];

constant = c(21);

end