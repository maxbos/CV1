%% Pixel Value
% Returns pixel value at specified (x,y) coordinates.
function color = pixelValue(image, x, y)

    [m, n] = size(image);
    % check if coordinates are in image
    if ~inImage(size(image), x, y)
        color = 0;
        return
    end
    
    color = image(floor(y + 0.5), floor(x + 0.5));
end