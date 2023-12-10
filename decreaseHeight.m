function [reducedColorImg, reducedEnergyImg] = decreaseHeight(im, energyImg)
[rowMax,colMax, ~] = size(im);
cumulativeEnergy = cumulativeEnergyMapFunc(energyImg, 'HORIZONTAL');
horizontalSeam = gettingHorizontalSeam(cumulativeEnergy);

updatedImage = uint8(zeros(rowMax - 1, colMax, 3)); % 3 b/c RGB channels
updatedEnergyImg = zeros(rowMax - 1, colMax);

for i = 1 : colMax %iterate through all x vals
    seamRowVal = horizontalSeam(i);
    %edge case 1 
    if seamRowVal == 1 % top of matrix 
        updatedImage(:, i, :) = im(seamRowVal + 1 : rowMax, i, :);
        updatedEnergyImg(:, i) = energyImg(seamRowVal + 1 : rowMax, i);
        
        continue
    end
    %edge case 2
    if seamRowVal == rowMax %bottom of matrix
        updatedImage(:, i, :) = im(1 : seamRowVal - 1, i, :);
        updatedEnergyImg(:,i) = energyImg(1 : seamRowVal - 1, i);
        continue;
        
    end
    
    firstHalfR = im(1:seamRowVal - 1, i, 1);
    firstHalfG = im(1:seamRowVal - 1, i, 2);
    firstHalfB = im(1:seamRowVal - 1, i, 3);
    
    secondHalfR = im(seamRowVal + 1 : rowMax, i, 1);
    secondHalfG = im(seamRowVal + 1 : rowMax, i, 2); 
    secondHalfB = im(seamRowVal + 1 : rowMax, i, 3); 
   
    rVal = cat(1, firstHalfR, secondHalfR);
    gVal = cat(1, firstHalfG, secondHalfG);
    bVal = cat(1, firstHalfB, secondHalfB);
    
    firstHalfEnergy = energyImg(1:seamRowVal - 1, i);
    secondHalfEnergy = energyImg(seamRowVal + 1 : rowMax, i);
    energyCombined = cat(1, firstHalfEnergy, secondHalfEnergy);
    
    updatedImage(:, i, 1) = rVal;
    updatedImage(:, i, 2) = gVal;
    updatedImage(:, i, 3) = bVal;
    
    updatedEnergyImg(:, i) = energyCombined;
end

reducedColorImg = updatedImage;
reducedEnergyImg = updatedEnergyImg;
end