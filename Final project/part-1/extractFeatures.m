function desc = extractFeatures(X, mode)
% extractFeatures
    nImages = size(X, 1);
    % For a subset of size `nImages` of the qualified images,
    % extract the features.
    desc = [];
    for i=1:nImages
        image = squeeze(X(i,:,:,:));

        % TODO: Perform smoothing?
%             [fa, da] = vl_dsift(single(rgb2gray(image)));
        if (strcmp(mode, 'gray'))
            [fa, da] = vl_phow(single(image), 'Color', mode);
            desc = [desc; da];
        end
        
        if (strcmp(mode, 'rgb'))
            [fa, da] = vl_phow(single(image), 'Color', mode);
            desc = [desc; da];
        end
        
        if (strcmp(mode, 'opponent'))
            [fa, da] = vl_phow(single(image), 'Color', mode);
            desc = [desc; da];
        end
        

    end
    
    sizeF = size(desc);
    desc = reshape(desc,[nImages,128,sizeF(2)]);

end

