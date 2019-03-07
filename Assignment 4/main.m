%% Image Alignment

% 1. Get keypoint matchings between the two boat images.
keypoint_matchings = keypoint_matchin('boat1.pgm', 'boat2.pgm');

% 2. Take a random subset (with set size set to 10) of all matching
% points, and plot on the image. Connect matching pairs with lines.
% You can assign a random color to each line to make them easier to
% distinguish.

