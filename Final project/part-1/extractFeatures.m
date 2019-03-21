function desc = extractFeatures(X, mode)
% extractFeatures
    nImages = size(X, 1);
    % For a subset of size `nImages` of the qualified images,
    % extract the features.
    desc = [];
    for i=1:nImages
        image = squeeze(X(i,:,:,:));
        if mode == 'densesampling'
            % TODO: Perform smoothing?
// %             [fa, da] = vl_dsift(single(rgb2gray(image)));
            [fa, da] = vl_phow(single(image));
            // binSize = 10;
            // magnif = 3;
            // I = single(rgb2gray(image));
            // Is = vl_imsmooth(I, sqrt((binSize/magnif)^2 - .25));
            // [fa, da] = vl_dsift(Is, 'size', binSize, 'step', 10);
            // desc = [desc; da];
        end
    end
    
    sizeF = size(desc);
    desc = reshape(desc,[nImages,128,sizeF(2)]);

end

