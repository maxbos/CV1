function [classifications, map] = demo(...
    mode, totalNumberImgsVocabulary, clusterNumber, batchSize)
% totalNumberImgsVocabulary: Can have a maximum value of 1250, which is
%       half of the total trainingset
%       size.
% mode: this can take the values 'gray', 'rgb' or
%       'opponent' and 'dense' or 'keypoints'

    disp("--- START DEMO RUN FOR " + mode(1) + "-" + mode(2) + " MODE ---");
    disp("N. images for getting visual words: " + totalNumberImgsVocabulary);
    disp("Cluster size: " + clusterNumber);
    disp("Test size: " + batchSize);

    %% Training phase
    % Feature extraction and description
    train = open('stl10_matlab/train.mat');
    % Get a part of the train images for training the vocabulary cluster centroids.
    [vocabularyX, ~, restIndices] = trainSplitForVocabulary(train, totalNumberImgsVocabulary);
    % Extract their SIFT descriptors from the images for building the visual vocabulary.
    features = extractFeatures(vocabularyX, mode);
    % Reshape the descriptors for each image into a 2D-matrix of shape
    % (nDescriptors, nFeatures).
    nDescriptors = size(features, 1) * size(features, 3);
    nFeatures = size(features, 2);
    descriptors = double(reshape(permute(features, [3 1 2]), [nDescriptors, nFeatures]));

    %% Calculate cluster centroids
    % Building visual vocabulary.
    % Perform KMeans to find clusters of feature descriptors, to get the
    % cluster centers as visual word descriptors.
    [~, C] = kmeans(descriptors, clusterNumber);

    %% Sanity Check
%     test = open('stl10_matlab/test.mat');
%     % Get the first image.
%     testX = test.X(8, :);
%     testX = reshape(testX, 1, 96, 96, 3);
%     figure;
%     imshow(squeeze(testX));
%     size(testX)
%     featuresTest = extractFeatures(testX, mode);
%     size(featuresTest)
%     encoded = encodeFeatures(featuresTest, C);
%     figure;
%     plot(encoded)

    %% Train the SVM Classifiers
    SVModels = trainSVMs(C, train, restIndices, mode);

    % Classification phase
    test = open('stl10_matlab/test.mat');
    [testImgs, classifications, positiveCount] = classifyBatch(test, SVModels, batchSize, mode, C);

    %% Results
    plotTop5(classifications.ship, testImgs);

    % Mean Average Precision
    calcMAP(classifications, positiveCount)

end