function x_state = x_state_function
%{
x_state = [0 0 0 0 0;
           1 0 0 0 0;
           1 1 0 0 0;
           1 0 1 0 0;
           1 0 0 1 0;
           1 0 0 0 1;
           1 1 1 0 0;
           1 1 0 1 0;
           1 1 0 0 1;
           1 0 1 1 0;
           1 0 1 0 1;
           1 0 0 1 1;           
           1 1 1 1 0;
           1 1 1 0 1;
           1 1 0 1 1;
           1 0 1 1 1;        
           1 1 1 1 1;
           0 1 0 0 0;           
           0 1 1 0 0;
           0 1 0 1 0;
           0 1 0 0 1;
           0 1 1 1 0;
           0 1 1 0 1;
           0 1 0 1 1
           0 1 1 1 1;           
           0 0 1 0 0;           
           0 0 1 1 0;
           0 0 1 0 1;
           0 0 1 1 1;           
           0 0 0 1 0;
           0 0 0 1 1;
           0 0 0 0 1;];
size(x_state)
%}

x_state = zeros(2^5, 5);
i = 1;
for j = [0 1]
    for k = [0 1]
        for l = [0 1]
            for m = [0 1]
                for n = [0 1]
                    x_state(i, :) = [j k l m n];
                    i = i + 1;
                end
            end
        end
    end
end
disp(x_state);

end 
              
    
    
    
    
