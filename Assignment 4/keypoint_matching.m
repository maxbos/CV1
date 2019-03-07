function [keypoints, matches,scores] = keypoint_matching(img1,img2)
%keypoint_matching
% Finds matching keypoints between 2 images
Ia = imread(img1);
Ib = imread(img2);
[fa, da] = vl_sift(single(Ia));
[fb, db] = vl_sift(single(Ib));
keypoints = fa(1:2, :);
[matches, scores] = vl_ubcmatch(da, db, 0);
end

