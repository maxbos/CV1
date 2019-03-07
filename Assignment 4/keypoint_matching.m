function [matches,scores] = keypoint_matching(img1,img2)
%keypoint_matching
% Finds matching keypoints between 2 images
Ia = single(imread(img1));
Ib = single(imread(img2));
[fa, da] = vl_sift(Ia) ;
[fb, db] = vl_sift(Ib) ;
[matches, scores] = vl_ubcmatch(da, db);
end

