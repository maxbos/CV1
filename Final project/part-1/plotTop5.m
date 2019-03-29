function plotTop5(data, testImgs)
    % Sort the `score` array, to get the top 5.
    airplaneScores = table2array(data(:, {'DecisionValues'}));
    [~, topI] = maxk(airplaneScores, 5);
    top5 = testImgs(topI, :, :, :);
    [~, bottomI] = mink(airplaneScores, 5);
    bottom5 = testImgs(bottomI, :, :, :);
    
    figure;
    for i = 1:5
        subplot(1, 5, i);
        img = squeeze(top5(i, :, :, :));
        imshow(img);
    end
    
    figure;
    for i = 1:5
        subplot(1, 5, i);
        img = squeeze(bottom5(i, :, :, :));
        imshow(img);
    end
    
end