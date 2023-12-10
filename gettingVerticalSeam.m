function verticalSeamFunc = gettingVerticalSeam(cumulativeEnergyMapFunc)
    [rows, cols] = size(cumulativeEnergyMapFunc);
    verticalSeamFunc = zeros(rows, 1);
    
    [~, smallestCol] = min(cumulativeEnergyMapFunc(rows, :));
    verticalSeamFunc(rows) = smallestCol;
    
    for i = rows - 1:-1:1
        leftIndex = max(1, smallestCol - 1);
        rightIndex = min(cols, smallestCol + 1);
        
        % Find the minimum cumulative energy among the current column and its neighbors
        candidates = [cumulativeEnergyMapFunc(i, leftIndex), cumulativeEnergyMapFunc(i, smallestCol), cumulativeEnergyMapFunc(i, rightIndex)];
        [~, minIndex] = min(candidates);
        
        % Update the smallest column index for the current row
        smallestCol = leftIndex - 1 + minIndex;
        
        % Store the smallest column index in the vertical seam
        verticalSeamFunc(i) = smallestCol;
    end
end
