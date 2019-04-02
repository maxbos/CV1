function descr = extractFeatures(X, mode)
% extractFeatures
% Extract the features.
    nImages = size(X, 1);
    
    if (strcmp(mode(2), 'dense'))
        step = 10;
        binSizes = [4 7 10];

        % Extract the features for the first image.
        firstImage = squeeze(X(1,:,:,:));
        [~, da] = vl_phow(single(firstImage), 'Color', mode(1), 'Sizes', binSizes, 'Step', step);

        % Pre-allocate the features tensor.
        descr = zeros(nImages, size(da, 1), size(da, 2));
        descr(1, :, :) = da;

        for i=2:nImages
            image = squeeze(X(i,:,:,:));
            [~, da] = vl_phow(single(image), 'Color', mode(1), 'Sizes', binSizes, 'Step', step);
            descr(i, :, :) = da;
        end
    else
        if (strcmp(mode(1), 'gray'))
            % Extract the features for the first image.
            descr = [];
            
            firstImage = squeeze(X(1,:,:,:));
            [~, da] = vl_sift(single(rgb2gray(firstImage)));

            descr = [descr da];
            for i=2:nImages
                image = squeeze(X(i,:,:,:));
                [~, da] = vl_phow(single(image));
                descr = [descr da];
            end
            
        end
    end
    
end

