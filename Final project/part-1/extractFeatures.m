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
        descr = [];
        if (strcmp(mode(1), 'gray'))
            for i=1:nImages
                image = squeeze(X(i,:,:,:));
                [~, da] = vl_sift(single(rgb2gray(image)));
                descr = [descr da];
            end
        end
        if (strcmp(mode(1), 'rgb'))
            for i=1:nImages
                image = squeeze(X(i,:,:,:));
                for j=(1:3)
                    image(:,:,j)
                    [~, da] = vl_sift(single(image(:,:,j)));
                    descr = [descr da];
                end
            end
            
        end
        if (strcmp(mode(1), 'opponnent'))
            %initialize opponent img
            O = zeros(96,96,3);
            for i=1:nImages
                image = squeeze(X(i,:,:,:));
                %Get opponent values
                O(:,:,1) = (image(:,:,1)-image(:,:,2))./sqrt(2);
                O(:,:,2) = (image(:,:,1)+image(:,:,2)-2*image(:,:,3))./sqrt(6);
                O(:,:,3) = (image(:,:,1)+image(:,:,2)+image(:,:,3))./sqrt(3);
                for j=1:3
                    O(:,:,j)
                    [~, da] = vl_sift(single(O(:,:,j)));
                    descr = [descr da];
                end
            end
        end
    
    end


