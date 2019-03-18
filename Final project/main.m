%% Training phase
% Feature extraction and description
mode = 'densesampling'; % this can take the values 'keypoints' and 
                        % 'densesampling'
train = open('stl10_matlab/train.mat');                   
features = extractFeatures(train, mode);
sizeF=size(features);
newS=sizeF(1)*sizeF(3);
resh=reshape(features,[newS,sizeF(2)]);
size(resh)
% Building visual vocabulary
[idx,C] = kmeans(double(resh),20);
% Encoding visual features
%%
encodedIm=encodeImage(features,C);
encodedIm
% Representing images by frequencies

% Classification

%% Testing phase
% Evaluation
test = open('stl10_matlab/test.mat');
features = extractFeatures(test, mode);