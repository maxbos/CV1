function descr = extractFeatures(X, mode)
% extractFeatures
% Extract the features.
    nImages = size(X, 1);
    
    if (strcmp(mode(2), 'dense'))
        step = 20;
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
        descr = zeros(nImages, 128, 200);
        maxsz = 0;
        if (strcmp(mode(1), 'gray'))
            for i=1:nImages
                image = squeeze(X(i,:,:,:));
                [~, da] = vl_sift(single(rgb2gray(image)));
                szda = size(da);
                descr(i, 1:szda(1), 1:szda(2)) = da;
            end
        end
        if (strcmp(mode(1), 'rgb'))
            for i=1:nImages
                image = squeeze(X(i,:,:,:));
                for j=(1:3)
                    [~, da] = vl_sift(single(image(:,:,j)));
                    szda = size(da);
                    descr(i, 1:szda(1), 1:szda(2)) = da;
                end
            end
            
        end
        if (strcmp(mode(1), 'opponent'))
            %initialize opponent img
            O = zeros(96,96,3);
            for i=1:nImages
                image = squeeze(X(i,:,:,:));
                %Get opponent values
                O(:,:,1) = (image(:,:,1)-image(:,:,2))./sqrt(2);
                O(:,:,2) = (image(:,:,1)+image(:,:,2)-2*image(:,:,3))./sqrt(6);
                O(:,:,3) = (image(:,:,1)+image(:,:,2)+image(:,:,3))./sqrt(3);
                for j=(1:3)
                    [~, da] = vl_sift(single(O(:,:,j)));
                    szda = size(da);
                    descr(i, 1:szda(1), 1:szda(2)) = da;
                end
            end
        end
    
    end

