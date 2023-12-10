function [reducedColorImg, reducedEnergyImg] = decreaseWidth(im, energyImg)
[rowMax,colMax, ~] = size(im);
cumulativeEnergy = cumulativeEnergyMapFunc(energyImg, 'VERTICAL');
verticalSeam = gettingVerticalSeam(cumulativeEnergy);

updatedImage = uint8(zeros(rowMax, colMax - 1, 3)); % 3 b/c RGB channels
updatedEnergyImg = zeros(rowMax, colMax - 1);

for i = 1 : rowMax %iterate through all y vals
    seamColVal = verticalSeam(i);
    %edge case 1 
    if seamColVal == 1 % leftmost of matrix 
        updatedImage(i, :, :) = im(i, seamColVal + 1 : colMax, :);
        updatedEnergyImg(i, :) = energyImg(i, seamColVal + 1 : colMax);
        
        continue
    end
    %edge case 2
    if seamColVal == colMax %rightmost of matrix
        updatedImage(i, :, :) = im(i, 1 : seamColVal - 1, :);
        updatedEnergyImg(i,:) = energyImg(i, 1 : seamColVal - 1);
        continue;
        
    end
    
    firstHalfR = im(i, 1 : seamColVal - 1, 1);
    firstHalfG = im(i, 1 : seamColVal - 1, 2);
    firstHalfB = im(i, 1 : seamColVal - 1, 3);
    
    secondHalfR = im(i, seamColVal + 1 : colMax, 1);
    secondHalfG = im(i, seamColVal + 1 : colMax, 2); 
    secondHalfB = im(i, seamColVal + 1 : colMax, 3); 
   
    rVal = cat(2, firstHalfR, secondHalfR);
    gVal = cat(2, firstHalfG, secondHalfG);
    bVal = cat(2, firstHalfB, secondHalfB);
    
    firstHalfEnergy = energyImg(i, 1 : seamColVal - 1);
    secondHalfEnergy = energyImg(i, seamColVal + 1 : colMax);
    energyCombined = cat(2, firstHalfEnergy, secondHalfEnergy);
    
    updatedImage(i, :, 1) = rVal;
    updatedImage(i, :, 2) = gVal;
    updatedImage(i, :, 3) = bVal;
    
    updatedEnergyImg(i, :) = energyCombined;
end

reducedColorImg = updatedImage;
reducedEnergyImg = updatedEnergyImg;
end