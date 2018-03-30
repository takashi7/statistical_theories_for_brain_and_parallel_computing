function x_state = x_state_function

x_state = zeros(4, 4, 2^16);
i = 1;
for j_1 = [0 1]
    for j_2 = [0 1]
        for j_3 = [0 1]
            for j_4 = [0 1]
                for j_5 = [0 1]
                    for j_6 = [0 1]
                        for j_7 = [0 1]
                            for j_8 = [0 1]
                                for j_9 = [0 1]
                                    for j_10 = [0 1] 
                                        for j_11 = [0 1]
                                            for j_12 = [0 1]
                                                for j_13 = [0 1]
                                                    for j_14 = [0 1]
                                                        for j_15 = [0 1]
                                                            for j_16 = [0 1]
                                                                x_state(:, :, i) = [j_1 j_2 j_3 j_4; ...
                                                                                    j_5 j_6 j_7 j_8; ...
                                                                                    j_9 j_10 j_11 j_12; ...
                                                                                    j_13 j_14 j_15 j_16];
                                                                i = i + 1;
                                                            end
                                                        end
                                                    end
                                                end
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end
disp(x_state);

end             