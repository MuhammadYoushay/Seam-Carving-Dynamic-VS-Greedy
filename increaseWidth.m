function [enlargedColorImg, enlargedEnergyImg] = increaseWidth(im, energyImg)
    [rowMax, colMax, ~] = size(im);
    cumulativeEnergy = cumulativeEnergyMapFunc(energyImg, 'VERTICAL');  % Use 'VERTICAL' for cumulative energy in the vertical direction
    verticalSeam = gettingVerticalSeam(cumulativeEnergy);  % Implement a function similar to gettingHorizontalSeam for vertical seam
    
    enlargedImage = uint8(zeros(rowMax, colMax + 1, 3)); % Increase width by 1
    enlargedEnergyImg = zeros(rowMax, colMax + 1);

    for j = 1:rowMax
        seamColVal = verticalSeam(j);

        for channel = 1:3 % Iterate over the color channels
            % Copy all the columns up to the seam's column
            enlargedImage(j, 1:seamColVal, channel) = im(j, 1:seamColVal, channel);
            % Copy all the columns after the seam's column
            enlargedImage(j, seamColVal+2:end, channel) = im(j, seamColVal+1:end, channel);

            % Insert the average of the seam's column and the next column
            if seamColVal < colMax
                enlargedImage(j, seamColVal+1, channel) = ...
                    (double(im(j, seamColVal, channel)) + double(im(j, seamColVal+1, channel))) / 2;
            else
                % Handle the case when the seam is at the last column
                enlargedImage(j, seamColVal+1, channel) = im(j, seamColVal, channel);
            end
        end

        % Fill in energy image
        % Copy all the energy values up to the seam's column
        enlargedEnergyImg(j, 1:seamColVal) = energyImg(j, 1:seamColVal);
        % Copy all the energy values after seam's column
        enlargedEnergyImg(j, seamColVal+2:end) = energyImg(j, seamColVal+1:end);

        % Handle the vertical seam energy for the inserted column
        if seamColVal < colMax
            enlargedEnergyImg(j, seamColVal+1) = ...
                (energyImg(j, seamColVal) + energyImg(j, seamColVal+1)) / 2;
        else
            % Handle the case when the seam is at the last column
            enlargedEnergyImg(j, seamColVal+1) = energyImg(j, seamColVal);
        end
    end

    enlargedColorImg = enlargedImage;
    enlargedEnergyImg = enlargedEnergyImg;
end
