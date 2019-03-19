function [X, y, restIndices] = trainSplitForVocabulary(dataset, totalNumberImgs)
    indices = classIndices(dataset);
    restIndices = indices;
    trainIndices = [];
    % Create a random distribution of number of train images per class
    % that sums to the given `totalNumberImgs`.
    n = numel(fieldnames(indices));
    % TODO: Randomly enerate an array summing to `totalNumberImgs`, with
    % each cell a minimum value of 1.
%     distr = diff([1,randperm(totalNumberImgs+n-1,n-1),totalNumberImgs+n])-1;
    distr = [10, 10, 10, 10, 10];
    % Iterate through `indices` struct.
    fields = fieldnames(indices);
    for i = 1:numel(fields)
        % Get a subset of the indices for each class, of the length
        % specified in `distr` for that class.
        [subset, I] = datasample(indices.(fields{i}), distr(i), ...
            'Replace', false);
        trainIndices = [trainIndices; subset];
        % Remove these indices from the `restIndices`, which will be used
        % in training the classifier.
        restIndices.(fields{i})(I) = [];
    end
    % Get all samples for the visual vocabulary.
    X = dataset.X(trainIndices, :);
    y = dataset.y(trainIndices);
    % Reshape to RGB images of size 96x96.
    X = reshape(X, length(trainIndices), 96, 96, 3);
end