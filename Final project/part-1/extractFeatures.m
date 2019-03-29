function descr = extractFeatures(X, mode)
% extractFeatures
% Extract the features.
    nImages = size(X, 1);
    step = 10;
    binSizes = [4 7 10];
    
    % Extract the features for the first image.
    firstImage = squeeze(X(1,:,:,:));
    [~, da] = vl_phow(single(firstImage), 'Color', mode, 'Sizes', binSizes, 'Step', step);
    
    % Pre-allocate the features tensor.
    descr = zeros(nImages, size(da, 1), size(da, 2));
    descr(1, :, :) = da;
    
    for i=2:nImages
        image = squeeze(X(i,:,:,:));
        [~, da] = vl_phow(single(image), 'Color', mode, 'Sizes', binSizes, 'Step', step);
        descr(i, :, :) = da;
    end
end

