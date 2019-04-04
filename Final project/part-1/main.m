% TO DO: Plot histograms of different photos
% compare cluster sizes of 400, 1000 and 4000
% Evaluation plots 

clear
close all

mode = ["opponent", "keypoints"]; % this can take the values 'gray', 'rgb' or 
                                % 'opponent' and 'dense' or 'keypoints'
train = open('stl10_matlab/train.mat');
% Get a part of the train images for training the vocabulary cluster centroids.
% Can have a maximum value of 1250, which is half of the total trainingset
% size.
totalNumberImgsVocabulary = 10;
[vocabularyX, vocabularyY, restIndices] = trainSplitForVocabulary(train, totalNumberImgsVocabulary);
% Extract their SIFT descriptors from the images for building the visual vocabulary.
features = extractFeatures(vocabularyX, mode);
% Reshape the descriptors for each image into a 2D-matrix of shape
% (nDescriptors, nFeatures).
nDescriptors = size(features, 1) * size(features, 3);
nFeatures = size(features, 2);
descriptors = double(reshape(permute(features, [3 1 2]), [nDescriptors, nFeatures]));
descriptors = descriptors(any(descriptors,2),:); %remove full zero descriptors

%% Calculate cluster centroids
% Building visual vocabulary.
% Perform KMeans to find clusters of feature descriptors, to get the
% cluster centers as visual word descriptors.
clusterNumber = 20;
[idx, C] = kmeans(descriptors, clusterNumber);

%% Sanity Check
test = open('stl10_matlab/test.mat');
% Get the first image.
testX = test.X(110, :);
testX = reshape(testX, 1, 96, 96, 3);
figure;
imshow(squeeze(testX));
size(testX)
featuresTest = extractFeatures(testX, mode);
% featuresTest = squeeze(featuresTest);
featuresTest = featuresTest(:,:,any(featuresTest,2)); %remove full zero descriptors
size(featuresTest)
encoded = encodeFeatures(featuresTest, C);
figure;
plot(encoded)

%% Train the SVM Classifiers
SVModels = trainSVMs(C, train, restIndices, mode);

% Classification phase
test = open('stl10_matlab/test.mat');
batchSize = 800*5;
[testImgs, classifications, positiveCount] = classifyBatch(test, SVModels, batchSize, mode, C);

%% Results
plotTop5(classifications.ship, testImgs);

% Mean Average Precision
calcMAP(classifications, positiveCount)

%% Cluster size: 400
demo(["gray", "dense"], 1000, 400, 800*5)
demo(["rgb", "dense"], 1000, 400, 800*5)
demo(["opponent", "dense"], 1000, 400, 800*5)

%% Cluster size: 1000
demo(["gray", "dense"], 1000, 1000, 800*5)
demo(["rgb", "dense"], 1000, 1000, 800*5)
demo(["opponent", "dense"], 1000, 1000, 800*5)

%% Cluster size: 4000
demo(["gray", "dense"], 1000, 4000, 800*5)
demo(["rgb", "dense"], 1000, 4000, 800*5)
demo(["opponent", "dense"], 1000, 4000, 800*5)

%% Cluster size: 400
demo(["gray", "keypoints"], 1000, 400, 800*5)
demo(["rgb", "keypoints"], 1000, 400, 800*5)
demo(["opponent", "keypoints"], 1000, 400, 800*5)

% Cluster size: 1000
demo(["gray", "keypoints"], 1000, 1000, 800*5)
demo(["rgb", "keypoints"], 1000, 1000, 800*5)
demo(["opponent", "keypoints"], 1000, 1000, 800*5)

% Cluster size: 4000
demo(["gray", "keypoints"], 1000, 4000, 800*5)
demo(["rgb", "keypoints"], 1000, 4000, 800*5)
demo(["opponent", "keypoints"], 1000, 4000, 800*5)
