function R = transformNearestNeighborInterpolation(I, matrix)
    I_size = size(I);
    I_height = I_size(1);
    I_width = I_size(2);
    % Prepare the transformed image.
    R = zeros(I_height, I_width);
    
    coords = [x y 1]';
    transformedCoords = matrix * coords;
    for t = 1:length(transformedCoords(1,:))
        transformedCoords(:,t) = transformedCoords(:,t) / ...
            transformedCoords(3,t);
    end
    
    % Loop through each coordinate and get the 
    for x = 1:I_width
        for y = 1:I_height
            coord = [x y 1]';
            transformedCoords = matrix * coord;
            for t = 1:length(transformedCoords(1,:))
                transformedCoords(:,t) = transformedCoords(:,t) / ...
                    transformedCoords(3,t);
            end
            transformedCoords
            R(y, x) = I();
        end
    end
end