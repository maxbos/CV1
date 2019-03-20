function models = trainSVMs(C, dataset, indices, mode)
% trainSVMs
    nSamplesPerClass = 50;
    models = struct;
    fields = fieldnames(indices);
    % Create an SVM Classifier for each class.
    for i = 1:numel(fields)
        samples = zeros(250, 1);
        % Get 50 positive examples.
        samples(1:50) = datasample(indices.(fields{i}), nSamplesPerClass, ...
            'Replace', false);
        % Get 200 negative examples, by getting 50 examples from each
        % class that is not the current positive class.
        for j = 1:numel(fields)
            if i == j
                continue;
            end
            negativeSamples = datasample(indices.(fields{j}), ...
                nSamplesPerClass, 'Replace', false);
            samples(51:250) = negativeSamples;
        end
        % Retrieve all positive and negative samples.
        X = dataset.X(samples, :);
        % Reshape to RGB images of size 96x96.
        X = reshape(X, size(X, 1), 96, 96, 3);
        y = dataset.y(samples);
        % Get label for current positive class.
        classLabels = strfind(dataset.class_names, fields{i});
        classLabel = find(not(cellfun('isempty', classLabels)));
        % Create an array containing logical 1 (true) where the `classLabel`
        % is found in y.
        y = ismember(y, classLabel);
        % Extract the features from the images.
        features = extractFeatures(X, mode);
        % Encode the features as normalized histograms.
        X = encodeFeatures(features, C);
        % Train the SVM model.
        models.(fields{i}) = fitcsvm(X, y);
    end
end