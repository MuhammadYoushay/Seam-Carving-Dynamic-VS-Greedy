function [enlargedColorImg, enlargedEnergyImg] = increaseHeight(im, energyImg)
[rowMax, colMax, ~] = size(im);
cumulativeEnergy = cumulativeEnergyMapFunc(energyImg, 'HORIZONTAL');
horizontalSeam = gettingHorizontalSeam(cumulativeEnergy);

enlargedImage = uint8(zeros(rowMax + 1, colMax, 3)); % Increase height by 1
enlargedEnergyImg = zeros(rowMax + 1, colMax);

for i = 1:colMax
    seamRowVal = horizontalSeam(i);
    
    for channel=1:3 % Iterate over the color channels
        % Copy all the rows up to the seam's row
        enlargedImage(1:seamRowVal, i, channel) = im(1:seamRowVal, i, channel);
        % Copy all the rows after the seam's row
        enlargedImage(seamRowVal+2:end, i, channel) = im(seamRowVal+1:end, i, channel);
        
        % Insert the average of the seam's row and the next row
        if seamRowVal < rowMax
            enlargedImage(seamRowVal+1, i, channel) = ...
                (double(im(seamRowVal, i, channel)) + double(im(seamRowVal+1, i, channel))) / 2;
        else
            % Handle the case when the seam is at the last row
            enlargedImage(seamRowVal+1, i, channel) = im(seamRowVal, i, channel);
        end
    end
    
    % Fill in energy image
    % Copy all the energy values up to the seam's row
    enlargedEnergyImg(1:seamRowVal, i) = energyImg(1:seamRowVal, i);
    % Copy all the energy values after seam's row
    enlargedEnergyImg(seamRowVal+2:end, i) = energyImg(seamRowVal+1:end, i);
    
    % Handle the horizontal seam energy for the inserted row
    if seamRowVal < rowMax
        enlargedEnergyImg(seamRowVal+1, i) = ...
            (energyImg(seamRowVal, i) + energyImg(seamRowVal+1, i)) / 2;
    else
        % Handle the case when the seam is at the last row
        enlargedEnergyImg(seamRowVal+1, i) = energyImg(seamRowVal, i);
    end
end

enlargedColorImg = enlargedImage;
enlargedEnergyImg = enlargedEnergyImg;
end
