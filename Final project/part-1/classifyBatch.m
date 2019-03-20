function [classifications] = classifyBatch(dataset, models, batchSize, mode, C)
% Classify a specified number of images (batchSize) from the dataset with
% supplied models and visual words (C) and visual word sampling method (mode) 
classifications = struct;

% Get data in compatible format
[testX, testY, ~ ] = trainSplitForVocabulary(dataset, batchSize);

% Get features
testFeatures = extractFeatures(testX, mode);

% Translate features to nearest available visual word
testX = encodeFeatures(testFeatures, C);

fields = fieldnames(models);

%  TO DO: softcode
classLabels = [1, 2, 9, 7, 3];

% Iterate through binary SVM models classifying batch
% and output score tables in classifications structure
for i = 1:numel(fields)
    [label, score] = predict(models.(fields{i}), testX);
    classifications.(fields{i}) = table((classLabels(i) == testY), ... 
        label,score(:,2),'VariableNames', {'TrueLabel', ...
        'PredictedLabel', 'Score'});
end