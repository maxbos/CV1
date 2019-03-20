function [encoding] = encodeFeatures(features,C)
%encodeFeatures
    sizeFeat = size(features);
    sizeC = size(C);
    encoding = zeros(sizeFeat(1), size(C(:,1)));
    for image=1:sizeFeat(1)
        imEnc = ones(size(C(:,1)));
        for feature = 1:sizeFeat(3)
            singleFeat = double(features(image,:,feature));
            minDist = Inf(1);
            minK = 0;
            for cluster = 1:sizeC(1)
                dist = abs(norm(C(cluster,:) - singleFeat));
                if dist < minDist
                    minDist = dist;
                    minK = cluster;
                end
            end
            imEnc(minK) = imEnc(minK)+1;
        end
        imEnc = normalize(imEnc,'norm',1);
%         encoding = [encoding; imEnc'];
        encoding(image, :) = imEnc';
    end
end