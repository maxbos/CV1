function [encoding] = encodeFeatures(features, C)
%encodeFeatures
    nImages = size(features, 1);
    nDescriptors = size(features, 3);
    nClusters = size(C, 1);
    sizeC = size(C);
    encoding = zeros(nImages, nClusters);
    
    for image=1:nImages
        % Pre-allocate an array with size (nClusters, 1).
        imEnc = zeros(size(C(:,1)));
        % For each descriptor, calculate the 
        for descriptor = 1:nDescriptors
            % Get one complete descriptor from the tensor.
            singleDescriptor = double(features(image, :, descriptor));
            minDist = Inf(1);
            minK = 0;
            % For each cluster centroid, calculate the distance from
            % the singleDescriptor to that centroid.
            for cluster = 1:sizeC(1)
                dist = abs(norm(C(cluster,:) - singleDescriptor));
                if dist < minDist
                    minDist = dist;
                    minK = cluster;
                end
            end
            % Increment the number of descriptors that matches the
            % currently found visual word.
            imEnc(minK) = imEnc(minK)+1;
        end
        % Normalize the histogram.
        imEnc = normalize(imEnc,'norm',1);
        % Add the histogram for this image to the encodings.
        encoding(image, :) = imEnc';
    end
end