function seamInsertionImagesUI()
% Create a figure
fig = figure('Position', [150, 150, 1000, 500]);

% Set title and heading
fig.Name = 'Seam Insertion - Averaging';
titleText = uicontrol('Style', 'text', 'String', 'Seam Insertion - Averaging', 'FontSize', 16, 'FontWeight', 'bold', 'HorizontalAlignment', 'center', 'Position', [750, 10, 200, 70]);

pixelReductionEdit = uicontrol('Style', 'edit', 'String', 'Enter pixels to insert', 'Position', [200, 50, 200, 30]);

resizeButton = uicontrol('Style', 'pushbutton', 'String', 'Resize Image', 'Position', [400, 50, 100, 30], 'Callback', @resizeCallback);

originalImageAxes = axes('Parent', fig, 'Position', [0.05, 0.35, 0.4, 0.6]);
resizedImageAxes = axes('Parent', fig, 'Position', [0.55, 0.35, 0.4, 0.6]);
resizedImageAxes.Visible = 'off';

% Load the original image
originalImage = imread('testImage2.jpg');

% Display the original image
imshow(originalImage, 'Parent', originalImageAxes);


function resizeCallback(~, ~)
    tic; % Start timer
    % Get user input for pixel reduction
    pixelReduction = str2double(get(pixelReductionEdit, 'String'));
    resizedImage = resizeImage(originalImage, pixelReduction);
    imshow(resizedImage, 'Parent', resizedImageAxes);
    elapsedTime = toc; % Stop timer and get elapsed time
    fprintf('Elapsed time: %.6f seconds.\n', elapsedTime); % Display the time in the console
end

end

function resizedImage = resizeImage(originalImage, widthReduction)
    % Initialize variables
    inputImage = originalImage;
    
    % Decrease width if selected
    for i = 1:abs(widthReduction)
        energyFunc = energyCalcFunc(inputImage);
        [inputImage, ~] = increaseWidth(inputImage, energyFunc);
    end
    
    % Save the final resized image
    resizedImage = inputImage;
end
