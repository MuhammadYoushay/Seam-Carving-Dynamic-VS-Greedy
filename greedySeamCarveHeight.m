function resizedImage = greedySeamCarveHeight(originalImage, newSize)
    [height, width, ~] = size(originalImage);
    desiredHeight = newSize(1);
    
    % Convert the image to grayscale for energy calculation
    grayImage = rgb2gray(originalImage);
    
    % Calculate the energy map (gradient magnitude)
    energyMap = imgradient(grayImage, 'prewitt');

    % Carve out horizontal seams
    currentImage = originalImage;
    for i = 1:height-desiredHeight
        % Find seam of minimum energy
        seam = findHorizontalSeam(currentImage, energyMap);

        % Remove the seam
        currentImage = removeHorizontalSeam(currentImage, seam);
        energyMap = removeHorizontalSeam(energyMap, seam);
    end
    
    resizedImage = currentImage;
end

function seam = findHorizontalSeam(image, energyMap)
    [height, width] = size(energyMap);
    seam = zeros(1, size(image, 2));
    
    % Start with the lowest energy pixel in the first column
    [~, minIndex] = min(energyMap(:, 1));
    seam(1) = minIndex;
    
    for col = 2:size(image, 2)
        % Look at the 3 neighbors in the next column and choose the minimum
        prevMinIndex = seam(col - 1);
        range = max(prevMinIndex - 1, 1):min(prevMinIndex + 1, height);
        [~, offset] = min(energyMap(range, col));
        seam(col) = range(offset(1));
    end
end

function imageWithoutSeam = removeHorizontalSeam(image, seam)
    [height, width, numChannels] = size(image);
    imageWithoutSeam = zeros(height - 1, width, numChannels, 'uint8');

    for i = 1:width
        imageWithoutSeam(:, i, :) = [image(1:seam(i)-1, i, :); image(seam(i)+1:end, i, :)];
    end
end

