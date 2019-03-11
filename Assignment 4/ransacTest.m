%% RANSAC
function matrix = ransac(matches, F1, F2, minData, iterationTimes, ...
                         error, inliersTreshold)
                     
    % get the coordinates of the matching keypoints from the first image
    coords = [F1(1, matches(1, :)); 
              F1(2, matches(1, :)); 
              ones(1, length(F1(1, matches(1, :))))];
    % get the coordinates of the matching keypoints from the second image      
    result = [F2(1, matches(2, :)); 
              F2(2, matches(2, :)); 
              ones(1, length(F2(1, matches(2, :))))];  
    dataset = matches; 
    tresh = 0;
    
    for i = 1:iterationTimes
        % Random selection from the dataset
        index = randi(length(dataset(1,:)), [1 minData]);
        selection = dataset(:,index);
        xy = [F1(1, selection(1,:));
              F1(2, selection(1,:))];   
        uv = [F2(1, selection(2,:));
              F2(2, selection(2,:))];
        model = createProjectionMatrix(xy', uv');
        transformedCoords = model * coords;
        
        for t = 1:length(transformedCoords(1,:))
            transformedCoords(:,t) = transformedCoords(:,t) / ...
                transformedCoords(3,t);
        end  
        
        % Calculate the euclidian distance from the model
        % to the correct location
        euc = sqrt((transformedCoords(1, :) - result(1, :)).^ 2 + ...
            (transformedCoords(1, :) - result(1, :)) .^2);
        indexes = find(euc < error);
        if length(indexes) / length(matches(1, :)) > inliersTreshold 
            tresh = 1;
            if tresh == 1 && length(indexes) > length(dataset)
                dataset = matches(:,indexes);
            end
            if tresh == 0
                dataset = matches(:,indexes);
            end    
        end  
    end
    
    matrix = model;
end