% function [stitched] = stitch(img1,img2)
% 
% close all
% clear 
% 
% % read images
% if (isinteger(img1)) 
%     left = img1;
%     right = img2;
% else
%     left = imread(img1);
%     right = imread(img2);
% end

left = rgb2gray(imread('left.jpg'));
right = rgb2gray(imread('right.jpg'));

% 1. Get keypoint matchings between the images to be stitched
[fa, fb, kp_matches, kp_scores] = keypoint_matching(right, left);
% 2. Take a random subset (with set size set to 10) of all matching points
sample_indices = randsample(size(kp_matches,2), 10);

% Get the coordinate pairs
xa = fa(1,kp_matches(1,:));
xb = fb(1,kp_matches(2,:));
ya = fa(2,kp_matches(1,:));
yb = fb(2,kp_matches(2,:));

% Pick the randomly selected coordinate pairs
xa = xa(sample_indices);
xb = xb(sample_indices);
ya = ya(sample_indices);
yb = yb(sample_indices);

% get transformation parameters
transformationParams = RANSAC(kp_matches, fa, fb, 100, 10);

% apply transformation
tform = affine2d(transformationParams');
T = imwarp(right, tform);


% Pad transformed image to create canvas to superimpose other image on
[m n] = size(T);
p = 900;
q = 900;
T_pad = padarray(T, [floor((p-m)/2) floor((q-n)/2)], 'replicate','post');
T_pad = padarray(T_pad, [ceil((p-m)/2) ceil((q-n)/2)], 'replicate','pre');

% 1. Get full keypoint matchings between the two images.
[fa, fb, kp_matches, kp_scores] = keypoint_matching(T, left);


% Get full coordinate pairs
xa = fa(1,kp_matches(1,:));
xb = fb(1,kp_matches(2,:));
ya = fa(2,kp_matches(1,:));
yb = fb(2,kp_matches(2,:));

% sort coordinate differences
sortedx = sort(xb-xa)
sortedy = sort(yb-ya)

% get median of coordinate differences to avoid values being influenced by 
% non-matchable keypoints
medx = round_even(median(sortedx))
medy = round_even(median(sortedy))

Tsize = size(T_pad)
leftsize = size(left)

% Superimpose image on padded image
T_pad( Tsize(1)/2 - (round_even(leftsize(1)))/2 - (medy)/2 ... 
+ (0:leftsize(1)-1), ... 
Tsize(2)/2-(round_even(leftsize(2)))/2 - (medx) ... 
+(0:leftsize(2)-1)) = left;

% To do: cut black borders

figure;
imshow(T_pad)




function input = round_even(input)
% round to nearest odd integer.
i = mod(input,2)>=1;
input = floor(input);
input(i) = input(i)+1;
end