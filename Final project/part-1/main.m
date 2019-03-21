% TO DO: Plot histograms of different photos
% compare cluster sizes of 400, 1000 and 4000
% Opponent & rgb sift
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
totalNumberImgsVocabulary = 10*5;
[vocabularyX, vocabularyY, ...
    restIndices] = trainSplitForVocabulary(train, totalNumberImgsVocabulary);
% Extract their SIFT descriptors from the images for building the
% visual vocabulary.
features = extractFeatures(vocabularyX, mode);
sizeF = size(features);
newS = sizeF(1)*sizeF(3);
resh = double(reshape(features, [newS, sizeF(2)]));
profile report

%% Calculate cluster centroids
% Building visual vocabulary.
% Perform KMeans to find clusters of feature descriptors, to get the
% cluster centers as visual word descriptors.
profile clear
profile on
clusterNumber = 1000;
[idx, C] = kmeans(resh, clusterNumber);

profile report

%% Calculate cluster centroids using VL
profile clear
profile on
clusterNumber = 400;
[C, ~] = vl_kmeans(resh', clusterNumber);

% Encoding visual features and representing images by frequencies.
% encodedImgs = encodeFeatures(features, C);
% size(encodedImgs)

%% Train the SVM Classifiers
SVMModels = trainSVMs(C, train, restIndices, mode);

%% Classification phase
test = open('stl10_matlab/test.mat');
batchSize = 50*5;
[testImgs, classifications] = classifyBatch(test, SVMModels, batchSize, mode, C);

%% Results
classifications.airplane
% classifications.car

% Plot the top 5
classifications.airplane
% Sort the `score` array, to get the top 5.
airplaneScores = table2array(classifications.airplane(:, {'Score'}));
[~, topI] = maxk(airplaneScores, 5);
top5 = testImgs(topI, :, :, :);
size(top5)
figure;
for i = 1:5
    subplot(1, 5, i);
    img = squeeze(top5(i, :, :, :));
    size(img)
    imshow(img);
end
% Plot the bottom 5