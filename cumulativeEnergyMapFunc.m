function energyAccumulationMapFunc = cumulativeEnergyMapFunc(energyFunc, direction)
    energyAccumulationMapFunc = energyFunc;

    [rows, cols] = size(energyFunc);

    if strcmp(direction, 'HORIZONTAL')
        energyAccumulationMapFunc(:, 1) = energyFunc(:, 1);
        for col = 2:cols
            for row = 1:rows
                if (row == 1)
                    energyAccumulationMapFunc(row, col) = energyFunc(row, col) + min([energyAccumulationMapFunc(row, col-1), energyAccumulationMapFunc(row+1, col-1)]);
                    continue
                end
                if (row == rows)
                    energyAccumulationMapFunc(row, col) = energyFunc(row, col) + min([energyAccumulationMapFunc(row, col-1), energyAccumulationMapFunc(row-1, col-1)]);
                    continue
                end
                energyAccumulationMapFunc(row, col) = energyFunc(row, col) + min([energyAccumulationMapFunc(row+1, col-1), energyAccumulationMapFunc(row, col-1), energyAccumulationMapFunc(row-1, col-1)]);
            end
        end
    elseif strcmp(direction, 'VERTICAL')
        energyAccumulationMapFunc(1, :) = energyFunc(1, :);
        for row = 2:rows
            for col = 1:cols
                if (col == 1)
                    energyAccumulationMapFunc(row, col) = energyFunc(row, col) + min([energyAccumulationMapFunc(row-1, col), energyAccumulationMapFunc(row-1, col+1)]);
                    continue
                end
                if (col == cols)
                    energyAccumulationMapFunc(row, col) = energyFunc(row, col) + min([energyAccumulationMapFunc(row-1, col), energyAccumulationMapFunc(row-1, col-1)]);
                    continue
                end
                energyAccumulationMapFunc(row, col) = energyFunc(row, col) + min([energyAccumulationMapFunc(row-1, col), energyAccumulationMapFunc(row-1, col+1), energyAccumulationMapFunc(row-1, col-1)]);
            end
        end
    end
end


