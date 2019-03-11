function R = transformNearestNeighborInterpolation(I, affineTransformation)
    I_size = size(I);
    I_height = I_size(1);
    I_width = I_size(2);
    nIndices = I_height*I_width;
    
    [X, Y] = meshgrid(1:I_width, 1:I_height);
    indices = [X(:)'; Y(:)'; ones(1, nIndices)];
    
    % Apply the affine transformation on the coordinates of the original
    % image, as to calculate the new position of an original coordinate.
    transformedIndices = (affineTransformation' * indices);
    % Prepare the transformed image.
    R = zeros(I_height, I_width);
    
    % Loop through each coordinate and get the pixel value at each original
    % position after applying the affine transformation.
    for i = 1:nIndices
        R(indices(2, i), indices(1, i)) = pixelValue(I, ...
            transformedIndices(1, i), transformedIndices(2, i));
    end
    R = mat2gray(R);
end