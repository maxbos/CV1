function [encoding] = encodeImage(features,C)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
shape=size(features);
encoding=[];
sizeFeat=size(features);
sizeC=size(C);
for image=1:sizeFeat(1)
    imEnc=ones(size(C(:,1)));
    for feature=1:sizeFeat(3)
        singleFeat=double(features(image,:,feature));
        %size(singleFeat)
        %singleFeat=reshape(singleFeat,[1,2]);
        size(singleFeat);
        minDist=Inf(1);
        minK=0;
        for cluster=1:sizeC(1)
            dist = abs(norm(C(cluster,:) - singleFeat));
            if dist<minDist
                minDist=dist;
                minK=cluster;
            end
        end
    imEnc(minK)=imEnc(minK)+1;

    end
    encoding=[encoding;imEnc'];
        
    
end

end


