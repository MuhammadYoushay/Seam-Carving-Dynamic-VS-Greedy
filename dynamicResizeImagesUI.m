function dynamicResizeImagesUI()
% Create a figure
fig = figure('Position', [150, 150, 1000, 500]);

% Set title and heading
fig.Name = 'Seam Remover - Dynamic';
titleText = uicontrol('Style', 'text', 'String', 'Seam Remover - Dynamic', 'FontSize', 16, 'FontWeight', 'bold', 'HorizontalAlignment', 'center', 'Position', [750, 10, 200, 70]);

% Create UI elements for dimension selection
dimSelectionButtonGroup = uibuttongroup('Visible','off',...
                  'Position',[0.15 0.14 0.2 0.2],'SelectionChangedFcn',@selectionChanged);
              
r1 = uicontrol(dimSelectionButtonGroup,'Style',...
                  'radiobutton',...
                  'String','Width',...
                  'Position',[10 60 100 30],...
                  'HandleVisibility','off');
              
r2 = uicontrol(dimSelectionButtonGroup,'Style','radiobutton',...
                  'String','Height',...
                  'Position',[10 30 100 30],...
                  'HandleVisibility','off');
              
dimSelectionButtonGroup.Visible = 'on';

pixelReductionEdit = uicontrol('Style', 'edit', 'String', 'Enter pixel reduction', 'Position', [200, 50, 200, 30]);

resizeButton = uicontrol('Style', 'pushbutton', 'String', 'Resize Image', 'Position', [400, 50, 100, 30], 'Callback', @resizeCallback);

originalImageAxes = axes('Parent', fig, 'Position', [0.05, 0.35, 0.4, 0.6]);
resizedImageAxes = axes('Parent', fig, 'Position', [0.55, 0.35, 0.4, 0.6]);
resizedImageAxes.Visible = 'off';

% Load the original image
originalImage = imread('testImage3.jpg');

% Display the original image
imshow(originalImage, 'Parent', originalImageAxes);

% Initialize reduction type
reductionType = 'Width';

function selectionChanged(src, event)
    reductionType = event.NewValue.String;
end

function resizeCallback(~, ~)
    tic; % Start timer
    
    % Get user input for pixel reduction
    pixelReduction = str2double(get(pixelReductionEdit, 'String'));
    
    % Resize the input image based on user selection
    if strcmp(reductionType, 'Width')
        resizedImage = resizeImage(originalImage, pixelReduction, 0);
    else
        resizedImage = resizeImage(originalImage, 0, pixelReduction);
    end
    
    % Display the resized image
    imshow(resizedImage, 'Parent', resizedImageAxes);
    
    elapsedTime = toc; % Stop timer and get elapsed time
    
    fprintf('Elapsed time: %.6f seconds.\n', elapsedTime); % Display the time in the console
end


end

function resizedImage = resizeImage(originalImage, widthReduction, heightReduction)
    % Initialize variables
    inputImage = originalImage;
    
    % Decrease width if selected
    for i = 1:abs(widthReduction)
        energyFunc = energyCalcFunc(inputImage);

        [inputImage, ~] = decreaseWidth(inputImage, energyFunc);
    end
    
    % Decrease height if selected
    for i = 1:abs(heightReduction)
        energyFunc = energyCalcFunc(inputImage);
        [inputImage, ~] = decreaseHeight(inputImage, energyFunc);
    end
    
    % Save the final resized image
    resizedImage = inputImage;
end
