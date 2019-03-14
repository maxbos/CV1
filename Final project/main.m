%% Training phase
% Feature extraction and description
mode = 'densesampling'; % this can take the values 'keypoints' and 
                        % 'densesampling'
train = open('stl10_matlab/train.mat');                   
features = extractFeatures(train, mode);

% Building visual vocabulary

% Encoding visual features

% Representing images by frequencies

% Classification

%% Testing phase
% Evaluation
test = open('stl10_matlab/test.mat');
features = extractFeatures(test, mode);