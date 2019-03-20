function desc = extractFeatures(X, mode)
% extractFeatures
    nImages = size(X, 1)
    % For a subset of size `nImages` of the qualified images,
    % extract the features.
    desc = [];
    for i=1:nImages
        image = squeeze(X(i,:,:,:));
        if mode == 'densesampling'
            % TODO: Perform smoothing?
            [fa, da] = vl_dsift(single(rgb2gray(image)));
%             [fa, da] = vl_phow(single(image)); Is deze functie cool?
%             in werkgroep vragen
            desc = [desc; da];
        end
    end
    
    sizeF = size(desc);
    desc = reshape(desc,[nImages,128,sizeF(2)]);

end

