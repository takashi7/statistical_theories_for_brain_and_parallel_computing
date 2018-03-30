function length = length_function(x, distance)
%% Set the Initial Values
length = 0;

%% Length Term
for i = 1:4
    for j = 1:4
        for k =1:4
            if i < 4
                length = length + x(j, i) * x(k, i+1) * distance(j, k);
                %fprintf('(length, i) = (%d, %d)\n', length, i);
            else
                length = length + x(j, i) * x(k, 1) * distance(j, k);
                %fprintf('(length, i) = (%d, %d)\n', length, i);
            end
        end
    end
end

%fprintf('x = \n');
%disp(x);
%fprintf('length: %d\n', length);

end