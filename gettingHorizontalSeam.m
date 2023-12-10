function horizontalSeamFunc = gettingHorizontalSeam(cumulativeEnergyMapFunc)
    [rows, cols] = size(cumulativeEnergyMapFunc);
    horizontalSeamFunc = zeros(1, cols);
    
    [~, smallestRow] = min(cumulativeEnergyMapFunc(:, cols));
    horizontalSeamFunc(cols) = smallestRow;
    
    for j = cols - 1:-1:1
        topIndex = max(1, smallestRow - 1);
        bottomIndex = min(rows, smallestRow + 1);
        
        % Find the minimum cumulative energy among the current row and its neighbors
        candidates = [cumulativeEnergyMapFunc(topIndex, j), cumulativeEnergyMapFunc(smallestRow, j), cumulativeEnergyMapFunc(bottomIndex, j)];
        [~, minIndex] = min(candidates);
        
        % Update the smallest row index for the current column
        smallestRow = topIndex - 1 + minIndex;
        
        % Store the smallest row index in the horizontal seam
        horizontalSeamFunc(j) = smallestRow;
    end
end
