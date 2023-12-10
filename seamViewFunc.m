function seamViewFunc(image,seam,seamDirection)

[rowMax, colMax, ~] = size(image);

if strcmp(seamDirection, 'HORIZONTAL')
    xVals = [1 : colMax];
    yVals = seam; 
    
    imagesc(image);
    hold on
    
    scatter(xVals, yVals, 1, [1 0 0]);
    
end

if strcmp(seamDirection, 'VERTICAL')
    xVals = seam;
    yVals = [1 : rowMax];
    
    imagesc(image);
    hold on
    
    scatter(xVals, yVals, 1, [0 0 1]);
    
end

end