function energyFunc = energyCalcFunc(image)

    % Compute gradients using the built-in MATLAB function
    [DX, DY] = gradient(double(rgb2gray(image)));

    % Compute energy using the sum of absolute gradients method
    energyFunc = abs(DX) + abs(DY);
end

% function energyFunc = energyCalcFunc(image)
%     % Convert the image to grayscale
%     grayImage = rgb2gray(image);
% 
%     % Calculate local entropy for each pixel
%     localEntropy = entropyfilt(grayImage);
% 
%     % Normalize local entropy to have values between 0 and 1
%     % This step is optional depending on how you plan to use the energy function
%     minEntropy = min(localEntropy(:));
%     maxEntropy = max(localEntropy(:));
%     energyFunc = (localEntropy - minEntropy) / (maxEntropy - minEntropy);
% end

% function energyFunc = energyCalcFunc(image)
%     % Convert the image to grayscale
%     grayImage = rgb2gray(image);
% 
%     % Compute gradients using the Sobel operator
%     DX = edge(grayImage, 'Sobel', [], 'horizontal');
%     DY = edge(grayImage, 'Sobel', [], 'vertical');
% 
%     % Compute energy using the sum of absolute gradients method
%     energyFunc = DX + DY;
% end

% function energyFunc = energyCalcFunc(image)
%     % Convert the image to grayscale
%     grayImage = rgb2gray(image);
% 
%     % Compute gradients using the Prewitt operator
%     DX = edge(grayImage, 'Prewitt', [], 'horizontal');
%     DY = edge(grayImage, 'Prewitt', [], 'vertical');
% 
%     % Compute energy using the sum of absolute gradients method
%     energyFunc = DX + DY;
% end


