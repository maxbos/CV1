%% Load image 1
im = imread('person_toy/00000001.jpg');
% Find and plot corners
[H, r, c] = harris_corner_detector(im);

%% Load image 2
im = imread('pingpong/0000.jpeg');
% Find and plot corners
[H, r, c] = harris_corner_detector(im);

%% Rotated image (45deg)
im = imread('person_toy/00000001.jpg');
im = imrotate(im, 45);
% Find and plot corners
[H, r, c] = harris_corner_detector(im);

%% Rotated image (90deg)
im = imread('person_toy/00000001.jpg');
im = imrotate(im, 90);
% Find and plot corners
[H, r, c] = harris_corner_detector(im);