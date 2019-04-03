function saveTopBottomResults(classifications, testImgs, folderName)
    fields = fieldnames(classifications);
    for i = 1:numel(fields)
        data = classifications.(fields{i});
        % Sort the `score` array, to get the top 5.
        scores = table2array(data(:, {'DecisionValues'}));
        [~, topI] = maxk(scores, 5);
        top5 = testImgs(topI, :, :, :);
        [~, bottomI] = mink(scores, 5);
        bottom5 = testImgs(bottomI, :, :, :);
        
        mkdir(folderName);
        
        for j = 1:5
            img = squeeze(top5(j, :, :, :));
            imwrite(img, folderName + "/" + fields{i} + "_top" + j + ".png");
        end

        for j = 1:5
            img = squeeze(bottom5(j, :, :, :));
            imwrite(img, folderName + "/" + fields{i} + "_bottom" + j + ".png");
        end
    end
end