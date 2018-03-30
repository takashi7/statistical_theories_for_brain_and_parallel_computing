function [p, a_p_nm, w_nm, E_store] = update_function(w_nm, a, x_init, x_state, q, a_q_nm)
%% Set the Initial Values
iterate = 1000;
a_p_nm = zeros(4, 3);
epsilon = 1e1;
count_update = 0;
E_store = zeros(500, 1);

%% Computation
while count_update < 500
    for n = 1:4
        for m = 2:4
            if n == m
                w_nm(n, m-1) = 0;
            elseif n < m
                theta_rnn = -w_nm(1, :); w_rnn = w_nm(2:end, :);
                [p, a_p_nm(n, m-1)] = rnn_probabilistic_binary_function(w_rnn, theta_rnn, a, iterate, x_init.', x_state.', n, m);
                w_nm(n, m-1) = w_nm(n, m-1) - epsilon * a * (a_p_nm(n, m-1) - a_q_nm(n, m-1)); 
            elseif n == 3                
                a_p_nm(3, 1) = a_p_nm(2, 2);
                w_nm(3, 1) = w_nm(2, 2);
            elseif m-1 == 1
                a_p_nm(4, 1) = a_p_nm(2, 3);
                w_nm(4, 1) = w_nm(2, 3);
            else
                a_p_nm(4, 2) = a_p_nm(3, 3);
                w_nm(4, 2) = w_nm(3, 3);                             
            end
        end
    end
    E = error_function(q, p);
    E_store(count_update + 1) = E;
    if E < 0.05
        break;
    end    
    count_update = count_update + 1;
    if mod(count_update, 10) == 0
        fprintf('count_update = %d \n', count_update);
        fprintf('E = %d \n', E);
    end        
end

%% Output
p = p.';
fprintf('p = \n');
disp(p);
fprintf('a_p_nm = \n');
disp(a_p_nm);
fprintf('w_nm = \n');
disp(w_nm);

end