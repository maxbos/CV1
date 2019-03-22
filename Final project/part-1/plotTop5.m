function plotTop5(data, testImgs)
    % Sort the `score` array, to get the top 5.
    airplaneScores = table2array(data(:, {'Score'}));
    [~, topI] = maxk(airplaneScores, 5);
    top5 = testImgs(topI, :, :, :);
    figure;
    for i = 1:5
        subplot(1, 5, i);
        img = squeeze(top5(i, :, :, :));
        imshow(img);
    end
end