%% Initialization
clear; close all; clc;

%% (1) Set the x state and Compute q and a_q_nm
x_state_0 = ones(1, 8);
x_state_1 = [0 0 0 0 1 1 1 1];
x_state_2 = [0 0 1 1 0 0 1 1];
x_state_3 = [0 1 0 1 0 1 0 1];
x_state = [x_state_0; x_state_1; x_state_2; x_state_3];
q = [0.25 0 0 0.25 0 0.25 0 0.25];
a_q_nm = zeros(4, 3);
for n = 1:4
    for m = 2:4
        if n ~= m
            a_q_nm(n, m-1) = x_state(n, :) .* x_state(m, :) * q.';
        end
    end
end

%% (2) Set the 3 initial values to w_nm
w_nm_a = [-1 -1 -1; ...
         0  1  1; ...
         1  0  1; ...
         1  1  0];
w_nm_b = [0 0 0; ...
          0 0 0; ...
          0 0 0; ...
          0 0 0];
w_nm_c = [1 1 1; ...
          1 1 1; ...
          1 1 1; ...
          1 1 1];
%%
for w = 1:3 
    if w == 1
        w_nm = w_nm_a;
    elseif w == 2
        w_nm = w_nm_b;
    else
        w_nm = w_nm_c;
    end
    double(w_nm);

    %% (3) Set 3 Initial Values for (x1, x2, x3) 
    fprintf('Setting 3 Initial Values for (x1, x2, x3)\n');
    x_init_a = [0 0 0];
    x_init_b = [0 1 0];
    x_init_c = [1 1 1];
    x_init_nm = [x_init_a; x_init_b; x_init_c];

    %% (4) Update w_nm until E becomes sufficiently small or Update 500 times by Computing RNN
    fprintf('Start Calculating the RNN\n');
    a_record = zeros(1, 27);
    p_store = zeros(8, 27);
    a_p_nm_store = zeros(4, 3, 27);
    w_nm_store = zeros(4, 3, 27);
    E_store = zeros(500, 27);
    i = 1;
    for x_init = [x_init_a.' x_init_b.' x_init_c.']
        fprintf('\n x_init = (x0  x1  x2  x3  x4  x5):'); disp(x_init.');
        for a = 0:0.1:0.8
            fprintf('Compute a = %.1f ...\n', a);
            a_record(i) = a;
            [p_store(:, i), a_p_nm_store(:, :, i), w_nm_store(:, :, i), E_store(:, i)] = update_function(w_nm, a, x_init, x_state, q, a_q_nm);                           
            i = i + 1;
        end
    end

    %% (5) Plot Error E
    index_0 = zeros(1,27);
    for j = 0:2
        figure;
        for i = 1+9*j : 9*(j+1)
            index = find(~E_store(:, i));
            if isempty(index) == 1
                index = 0;            
                plot(E_store(:, i)); ylim([0 0.8]);
                hold on;
            else
                index_0(i) = index(1);
                plot(E_store(1:index_0(i)-1, i)); ylim([0 0.8]);
                hold on;
            end    
        end
        xlabel('The Number of Update'); ylabel('The Error G between p and q');
        lgd = legend('0','0.1','0.2','0.3','0.4','0.5','0.6','0.7','0.8','Location','east');
        title(lgd,'The Value of \alpha')
    end

    %% (6) Record in Excel
    if w == 1
        fprintf('Recording ...\n')
        filename_1 = 'record_1.xlsx'; filename_2 = 'record_2.xlsx'; 
        record_1 = [p_store; E_store]; 
        record_2 = [];
        for i = 1:27
            record_2 = [record_2; a_p_nm_store(:, :, i) w_nm_store(:,:,i)]; 
        end
        xlswrite(filename_1, record_1); xlswrite(filename_2, record_2);
        save('result2', 'p_store', 'a_p_nm_store','w_nm_store','E_store');
    elseif w == 2
        fprintf('Recording ...\n')
        filename_3 = 'record_3.xlsx'; filename_4 = 'record_4.xlsx'; 
        record_3 = [p_store; E_store]; 
        record_4 = [];
        for i = 1:27
            record_4 = [record_4; a_p_nm_store(:, :, i) w_nm_store(:,:,i)]; 
        end
        xlswrite(filename_3, record_3); xlswrite(filename_4, record_4);
        save('result3', 'p_store', 'a_p_nm_store','w_nm_store','E_store');
    else
        fprintf('Recording ...\n')
        filename_5 = 'record_5.xlsx'; filename_6 = 'record_6.xlsx'; 
        record_5 = [p_store; E_store]; 
        record_6 = [];
        for i = 1:27
            record_6 = [record_6; a_p_nm_store(:, :, i) w_nm_store(:,:,i)]; 
        end
        xlswrite(filename_5, record_5); xlswrite(filename_6, record_6);
        save('result4', 'p_store', 'a_p_nm_store','w_nm_store','E_store');
    end
    
end
fprintf('finish\n')