%% Training phase
% Feature extraction and description
clear
close all

mode = 'densesampling'; % this can take the values 'keypoints' and 
                        % 'densesampling'
train = open('stl10_matlab/train.mat');
% Get a part of the train images for training the vocabulary cluster
% centroids.
totalNumberImgsVocabulary = 50;
[vocabularyX, vocabularyY, ...
    restIndices] = trainSplitForVocabulary(train, totalNumberImgsVocabulary);
% Extract their SIFT descriptors from the images for building the
% visual vocabulary.
features = extractFeatures(vocabularyX, mode);
sizeF = size(features);
newS = sizeF(1)*sizeF(3);
resh = reshape(features, [newS, sizeF(2)]);
size(resh)

% Building visual vocabulary.
% Perform KMeans to find clusters of feature descriptors, to get the
% cluster centers as visual word descriptors.
clusterNumber = 400;
[idx, C] = kmeans(double(resh), clusterNumber);

% Encoding visual features and representing images by frequencies.
% encodedImgs = encodeFeatures(features, C);
% size(encodedImgs)

%% Train the SVM Classifiers
SVMModels = trainSVMs(C, train, restIndices, mode);

%% Classification phase

test = open('stl10_matlab/test.mat');
batchSize = 100;
classifications = classifyBatch(test, SVMModels, batchSize, mode, C);

%% Results
classifications.airplane
classifications.car