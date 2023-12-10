function enlarged_image = enlargeImage(input_image, pixels_to_add)
    [M, N, chn] = size(input_image);

    FN = N + pixels_to_add;

    OM = M; ON = N;
    O_im = input_image;
    N_rem = N - pixels_to_add;
    [Y, X] = meshgrid(1:N, 1:M);
    removed = zeros(M, N);

    % traverse until we get the desired width
    while N > N_rem
        disp(N);
        cost = energyCalcFunc(input_image);
        dp = zeros(M, N);
        from = zeros(M, N);
        dp(1, :) = cost(1, :);
        from(1, :) = 1:N;

        for i = 2:M
            for j = 1:N
                dp(i, j) = dp(i - 1, j);
                from(i, j) = j;
                if j > 1 && dp(i - 1, j - 1) < dp(i, j)
                    dp(i, j) = dp(i - 1, j - 1);
                    from(i, j) = j - 1;
                end
                if j < N && dp(i - 1, j + 1) < dp(i, j)
                    dp(i, j) = dp(i - 1, j + 1);
                    from(i, j) = j + 1;
                end
                dp(i, j) = dp(i, j) + cost(i, j);
            end
        end

        [~, idx] = min(dp(M, :));
        for i = M:-1:1
            removed(i, Y(i, idx)) = 1;
            input_image(i, idx:N - 1, :) = input_image(i, idx + 1:N, :);
            Y(i, idx:N - 1) = Y(i, idx + 1:N);
            idx = from(i, idx);
        end
        input_image = input_image(:, 1:N - 1, :);
        Y = Y(:, 1:N - 1);
        N = N - 1;

    end

    input_image = double(O_im);
    new_im = zeros(M, FN, chn);

    for i = 1:OM
        k = 1;

        for j = 1:ON
            new_im(i, k, :) = input_image(i, j, :);
            k = k + 1;
            if removed(i, j) == 1

                if (j > 1) && (j < N)
                    new_im(i, k, :) = (input_image(i, j - 1, :) + input_image(i, j, :) + input_image(i, j + 1, :)) / 3;
                else
                    new_im(i, k, :) = input_image(i, j, :);
                end
                k = k + 1;
            end
        end

    end

    enlarged_image = uint8(new_im);
    
    % Display the enlarged image
    imshow(enlarged_image);
end
