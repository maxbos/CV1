%% Image Alignment
clear all
% 1. Get keypoint matchings between the two boat images.
[fa, fb, kp_matches, kp_scores] = keypoint_matching('boat1.pgm', 'boat2.pgm');
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

% Plot the matches
plot_matches('boat1.pgm', 'boat2.pgm', [xa;ya], [xb;yb]);

% 3. Create a function that performs the RANSAC algorithm as explained
% above. The function should return the best transformation found. For
% visualization, show the transformations from image1 to image2 and from
% image2 to image1.
best_transformation = RANSAC(kp_matches, fa, fb, 100, 10);
