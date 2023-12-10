function resizedImage = greedySeamCarveWidth(originalImage, newSize)
    [height, width, ~] = size(originalImage);
    desiredWidth = newSize(2);
    
    % Convert the image to grayscale for energy calculation
    grayImage = rgb2gray(originalImage);
    
    % Calculate the energy map (gradient magnitude)
    energyMap = imgradient(grayImage, 'prewitt');

    % Carve out vertical seams
    currentImage = originalImage;
    for i = 1:width-desiredWidth
        % Find seam of minimum energy
        seam = findVerticalSeam(currentImage, energyMap);

        % Remove the seam
        currentImage = removeVerticalSeam(currentImage, seam);
        energyMap = removeVerticalSeam(energyMap, seam);
    end
    
    resizedImage = currentImage;
end

function seam = findVerticalSeam(image, energyMap)
    [~, width] = size(energyMap);
    seam = zeros(size(image, 1), 1);
    
    % Start with the lowest energy pixel in the first row
    [~, minIndex] = min(energyMap(1, :));
    seam(1) = minIndex;
    
    for row = 2:size(image, 1)
        % Look at the 3 neighbors in the next row and choose the minimum
        prevMinIndex = seam(row - 1);
        range = max(prevMinIndex - 1, 1):min(prevMinIndex + 1, width);
        [~, offset] = min(energyMap(row, range));
        seam(row) = range(offset(1));
    end
end

function imageWithoutSeam = removeVerticalSeam(image, seam)
    [height, ~, numChannels] = size(image);
    imageWithoutSeam = zeros(height, size(image, 2) - 1, numChannels, 'uint8');

    for i = 1:height
        imageWithoutSeam(i, :, :) = [image(i, 1:seam(i)-1, :), image(i, seam(i)+1:end, :)];
    end
end
