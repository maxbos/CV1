% Load image
im = imread('pingpong/0000.jpeg');
% Find and plot corners
[H, r, c] = harris_corner_detector(im);
