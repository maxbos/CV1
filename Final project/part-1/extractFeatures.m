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
<<<<<<< HEAD
        if mode == 'densesampling'
            % TODO: Perform smoothing?
            [fa, da] = vl_dsift(single(rgb2gray(image)),'size',10,'step',10);
%             [fa, da] = vl_phow(single(image)); Is deze functie cool?
%             in werkgroep vragen
            desc = [desc; da];
        end
=======

        [fa, da] = vl_phow(single(image), 'Color', mode, 'Sizes', binSizes, 'Step', step);
        desc = [desc; da];
>>>>>>> 119f5c5ef5c7477cc18e8dbda58dba765aab0ba0
    end
    
    sizeF = size(desc);
    if strcmp(mode, 'gray')
        desc = reshape(desc,[nImages,128,sizeF(2)]);
    else 
        desc = reshape(desc,[nImages,128*3,sizeF(2)]);
    end

end

