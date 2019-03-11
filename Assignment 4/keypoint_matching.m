function [fa, fb, matches,scores] = keypoint_matching(img1,img2)
%keypoint_matching
% Finds matching keypoints between 2 images
if (isinteger(img1)) 
    Ia = img1;
    Ib = img2;
else
    Ia = imread(img1);
    Ib = imread(img2);
end
[fa, da] = vl_sift(single(Ia));
[fb, db] = vl_sift(single(Ib));
[matches, scores] = vl_ubcmatch(da, db);
end

