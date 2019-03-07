function [transformation] = RANSAC(matches, fa, fb, nIterations, nPoints)
%
%
    nMatches = length(matches(1,:));
    
    % Prepare the coordinates of the matching keypoints from the first
    % image.
    coords = [fa(1, matches(1, :)); % x coordinates
              fa(2, matches(1, :)); % y coordinates
              ones(1, length(fa(1, matches(1, :)))) % z coordinates
             ];
    
    for n = 1:nIterations
        % Get `nPoints` random indices from the whole set of matches.
        index = randi(nMatches, [1 nPoints]);
        % Get the subset of matches.
        selection = matches(:, index);
        % Construct the A matrix from the subset of matches.
        x = fa(1, selection(1, :));
        y = fa(2, selection(1, :));
        oddRows = [x, y, 0, 0, 1, 0];
        evenRows = [0, 0, x, y, 0, 1];
        A = [oddRows; evenRows];
        % Construct b from the subset of matches.
        b = [fb(1, selection(2, :)) fb(2, selection(2, :))]';
        x = pinv(A)*b;
        % Using the transformation parameters, transform the location of
        % all points.
        transformedCoords = x * coords;
        % Normalize all transformed coords by their z dimension, setting
        % z to 1.
        for t = 1:length(transformedCoords(1,:))
            transformedCoords(:,t) = transformedCoords(:,t) / ...
                transformedCoords(3,t);
        end
        % Count the number of inliers, inliers being defined as the number
        % of transformed points from image1 that lie within a radius of
        % 10 pixels of their pair in image2.
        for p = 1:length(transformedCoords)
            
        end
    end
end