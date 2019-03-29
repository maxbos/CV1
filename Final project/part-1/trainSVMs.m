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
        lastIndex = 50;
        for j = 1:numel(fields)
            if i == j
                continue;
            end
            negativeSamples = datasample(indices.(fields{j}), ...
                nSamplesPerClass, 'Replace', false);
            samples(lastIndex+1:lastIndex+50) = negativeSamples;
            lastIndex = lastIndex + 50;
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
        
        % Solver type 3 (L2-regularized L1-loss support vector classification (dual))
        % and type 5 (L1-regularized L2-loss support vector classification)
        % Seem to yield the best resultsin in smaller cluster numbers (400)
        
        models.(fields{i}) = train(double(y), sparse(double(X)), '-c 1 -w1 4 -w-1 1 -s 3');
    end
end