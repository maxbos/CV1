function desc = extractFeatures(X, mode)
% extractFeatures
    nImages = size(X, 1);
    % For a subset of size `nImages` of the qualified images,
    % extract the features.
    desc = [];
    step = 10;
    binSizes = [4 7 10];
    
    for i=1:nImages
        image = squeeze(X(i,:,:,:));
        [fa, da] = vl_phow(single(image), 'Color', mode, 'Sizes', binSizes, 'Step', step);
        desc = [desc; da];
    end
    
    sizeF = size(desc);
    if strcmp(mode, 'gray')
        desc = reshape(desc,[nImages,128,sizeF(2)]);
    else 
        desc = reshape(desc,[nImages,128*3,sizeF(2)]);
    end

end

