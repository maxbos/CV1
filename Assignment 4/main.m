%% Image Alignment

% 1. Get keypoint matchings between the two boat images.
% 2. Take a random subset (with set size set to 10) of all matching
% points, and plot on the image. Connect matching pairs with lines.
% You can assign a random color to each line to make them easier to
% distinguish.
[kp, kp_matches, kp_scores] = keypoint_matching('boat1.pgm', 'boat2.pgm')

% 3. Create a function that performs the RANSAC algorithm as explained
% above. The function should return the best transformation found. For
% visualization, show the transformations from image1 to image2 and from
% image2 to image1.
best_transformation = RANSAC(kp, kp_matches);
