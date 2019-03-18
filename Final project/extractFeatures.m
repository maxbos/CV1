function [desc] = extractFeatures(dataset,mode)
%extractFeatures
% Extracts features from a given dataset
%              'airplane', 'bird', 'ship', 'horse', 'car'];
classlabels = [1,           2,      9,      7,       3];
if size(dataset.X) == [5000,27648]
    % train
    X = reshape(dataset.X,5000,96,96,3);
else
    % test
    X = reshape(dataset.X,8000,96,96,3);
end

class_indices = ismember(dataset.y, classlabels);
X = X(class_indices,:,:,:);

% Test with first 50 images
nImages = 50;

desc = [];
for i=1:nImages;
   image = squeeze(X(i,:,:,:));
   if mode == 'densesampling'
       [fa, da] = vl_dsift(single(rgb2gray(image)));
       desc=[desc;da];
      
   else
       % TODO
        [fa, da] = vl_sift(single(rgb2gray(image)));
        desc=[desc;da];
   end
   
end
sizeF=size(desc);
desc=reshape(desc,[nImages,128,sizeF(2)]);

end

