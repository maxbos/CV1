% TO DO: Plot histograms of different photos
% compare cluster sizes of 400, 1000 and 4000
% Evaluation plots 

%% Training phase
% Feature extraction and description
clear
close all

profile clear
profile on

mode = 'gray'; % this can take the values 'gray', 'rgb' and 'opponent'
train = open('stl10_matlab/train.mat');
% Get a part of the train images for training the vocabulary cluster
% centroids.
totalNumberImgsVocabulary = 100*5;
[vocabularyX, vocabularyY, ...
    restIndices] = trainSplitForVocabulary(train, totalNumberImgsVocabulary);
% Extract their SIFT descriptors from the images for building the
% visual vocabulary.
features = extractFeatures(vocabularyX, mode);
sizeF = size(features);
newS = sizeF(1)*sizeF(3);
resh = double(reshape(features, [newS, sizeF(2)]));
profile report

<<<<<<< HEAD
%%
=======
%% Calculate cluster centroids
>>>>>>> 119f5c5ef5c7477cc18e8dbda58dba765aab0ba0
% Building visual vocabulary.
% Perform KMeans to find clusters of feature descriptors, to get the
% cluster centers as visual word descriptors.
profile clear
profile on
clusterNumber = 400;
[idx, C] = kmeans(resh, clusterNumber);

<<<<<<< HEAD
%% Encoding visual features and representing images by frequencies.
encodedImgs = encodeFeatures(features, C);
size(encodedImgs)
=======
profile report

%% Calculate cluster centroids using VL
% profile clear
% profile on
% clusterNumber = 400;
% [C, ~] = vl_kmeans(resh', clusterNumber);

%% Sanity Check
test = open('stl10_matlab/test.mat');
% Get the first image.
testX = test.X(800, :);
testX = reshape(testX, 1, 96, 96, 3);
figure;
imshow(squeeze(testX));
size(testX)
features = extractFeatures(testX, mode);
encoded = encodeFeatures(features, C);
figure;
plot(encoded)
>>>>>>> 119f5c5ef5c7477cc18e8dbda58dba765aab0ba0

%% Train the SVM Classifiers
SVMModels = trainSVMs(C, train, restIndices, mode);

%% Classification phase
test = open('stl10_matlab/test.mat');
batchSize = 50*5;
[testImgs, classifications] = classifyBatch(test, SVMModels, batchSize, mode, C);

%% Results
plotTop5(classifications.airplane, testImgs);