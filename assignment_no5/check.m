x0 = [0 0 0 0; ...
      0 0 0 0; ...
      0 0 0 0; ...
      0 0 0 0];

x1 = [1 0 0 0; ...
      0 1 0 0; ...
      0 0 1 0; ...
      0 0 0 1];
 
x2 = [0 1 0 0; ...
      1 0 0 0; ...
      0 0 0 1; ...
      0 0 1 0];
  
x3 = [1 1 1 1; ...
      1 1 1 1; ...
      1 1 1 1; ...
      1 1 1 1];
  
fprintf('shoule not be 0\n');
energy_function(x0, w, theta, C);
fprintf('shoule be 0\n');
energy_function(x1, w, theta, C);
fprintf('shoule be 0\n');
energy_function(x2, w, theta, C);
fprintf('shoule not be 0\n');
energy_function(x3, w, theta, C);
