%% Image Alignment

% 1. Get keypoint matchings between the two boat images.
[fa, fb, kp_matches, kp_scores] = keypoint_matching('boat1.pgm', 'boat2.pgm');
% 2. Take a random subset (with set size set to 10) of all matching
% points, and plot on the image. Connect matching pairs with lines.
sample_indices = randsample(size(matches,2), 10);

xa = fa(1,matches(1,:));
xb = fb(1,matches(2,:));
ya = fa(2,matches(1,:));
yb = fb(2,matches(2,:));

im1 = imread('boat1.pgm');
im2 = imread('boat2.pgm');
im = cat(2, im1, im2);
imshow(im);
hold on
for i=1:size(sample_indices)
    index = sample_indices(i);
    x1 = xa(index);
    y1 = ya(index);
    plot(x1, y1, 'r*');
    x2 = xb(index) + size(im1,2);
    y2 = yb(index);
    plot(x2, y2, 'b*');
    x = [x1, x2];
    y = [y1, y2];
    plot(x, y, 'LineWidth', 2);
end
hold off

% 3. Create a function that performs the RANSAC algorithm as explained
% above. The function should return the best transformation found. For
% visualization, show the transformations from image1 to image2 and from
% image2 to image1.
%best_transformation = RANSAC(kp_matches);
