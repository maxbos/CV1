function [classifications] = classifyBatch(dataset, models, batchSize, mode, C)
% Classify a specified number of images (batchSize) from the dataset with
% supplied models and visual words (C) and visual word sampling method (mode) 
classifications = struct;

% Get data in compatable format
[testX, testY, ~ ] = trainSplitForVocabulary(dataset, batchSize);

% Get features
testFeatures = extractFeatures(testX, mode);

% Translate features to nearest available visual word
testX = encodeFeatures(testFeatures, C);

fields = fieldnames(models);

%  TO DO: softcode
% classLabels = [1, 2, 9, 7, 3];

% Iterate through binary SVM models classifying batch
% and output score tables in classifications structure
for i = 1:numel(fields)
    % Get label for current positive class.
    classLabels = strfind(dataset.class_names, fields{i});
    classLabel = find(not(cellfun('isempty', classLabels)));
    
    [label, score] = predict(models.(fields{i}), testX);
    classifications.(fields{i}) = table((classLabel == testY), ... 
        label,score(:,2),'VariableNames', {'TrueLabel', ...
        'PredictedLabel', 'Score'});
end