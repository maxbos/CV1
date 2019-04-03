function [testImgs, classifications, positiveCount] = classifyBatch(dataset, models, batchSize, mode, C)
% Classify a specified number of images (batchSize) from the dataset with
% supplied models and visual words (C) and visual word sampling method (mode) 
    classifications = struct;

    % Get data in compatible format
    [testImgs, testY, ~ ] = trainSplitForVocabulary(dataset, batchSize);
    
    % Get features
    testFeatures = extractFeatures(testImgs, mode);

    % Translate features to nearest available visual word
     % remove full zero features and encoding afterwards
    szft = size(testFeatures);
    szC = size(C);
    encodedList = zeros(szft(1),szC(1));
    for j=1:szft(1)    
        ftcut = (testFeatures(j,:,:));
        ftcut = ftcut(:,:,any(ftcut,2));
        encoded = encodeFeatures(ftcut, C);
        encodedList(j,:) = encoded;
    end
    testX = encodedList;
    fields = fieldnames(models);
    
    positiveCount = [];
    % Iterate through binary SVM models classifying batch
    % and output score tables in classifications structure
    for i = 1:numel(fields)
        % Get label for current positive class.
         classLabels = strfind(dataset.class_names, fields{i});
          classLabel = find(not(cellfun('isempty', classLabels)));
        disp(['Predicting for ' fields{i}]);
        [predictedLabel, ~, decisionValues] = ...
            predict(double(testY), sparse(double(testX)), ...
            models.(fields{i}));
        classifications.(fields{i}) = table((classLabel == testY), ... 
            predictedLabel, decisionValues, 'VariableNames', {'TrueLabel', ...
            'PredictedLabel', 'DecisionValues'});
        positiveCount = [positiveCount sum(classLabel == testY)];
    end
    
end