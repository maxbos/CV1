%% Image Alignment -> Calculate keypoint matching and plotting matches
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

%% Image Alignment -> Calculate transformation parameters using RANSAC
% 3. Create a function that performs the RANSAC algorithm as explained
% above. The function should return the best transformation found. For
% visualization, show the transformations from image1 to image2 and from
% image2 to image1.

% Transform from boat1 to boat2.
transformationParams = RANSAC(kp_matches, fa, fb, 100, 10);

originalImg = imread('boat1.pgm');

% Transform using nearest-neighbor interpolation.
transformedImg = transformNearestNeighborInterpolation(originalImg, transformationParams);
dispRansacResults(originalImg, transformedImg, ...
    'Transform using nearest-neighbor interpolation');

% Also, transform using MATLAB built-in `imwarp`, and compare the results
% with own nearest-neigbor interpolation.
tform = affine2d(transformationParams');
matlabTransformedImg = imwarp(originalImg, tform);
dispRansacResults(originalImg, matlabTransformedImg, ...
    'Transform using imwarp');

mkdir 'ransac';
imwrite(transformedImg, 'ransac/boat1Trans.png');
imwrite(matlabTransformedImg, 'ransac/boat1TransMatlab.png');

% Transform from boat2 to boat1.
transformationParams = inv(transformationParams);

originalImg = imread('boat2.pgm');

% Transform using nearest-neighbor interpolation.
transformedImg = transformNearestNeighborInterpolation(originalImg, transformationParams);
dispRansacResults(originalImg, transformedImg, ...
    'Transform using nearest-neighbor interpolation');

% Also, transform using MATLAB built-in `imwarp`, and compare the results
% with own nearest-neigbor interpolation.
tform = affine2d(transformationParams');
matlabTransformedImg = imwarp(originalImg, tform);
dispRansacResults(originalImg, matlabTransformedImg, ...
    'Transform using imwarp');

imwrite(transformedImg, 'ransac/boat2Trans.png');
imwrite(matlabTransformedImg, 'ransac/boat2TransMatlab.png');

%% Image alignment -> How many iterations are needed on average?
% Make sure to run the first section of this main file first
nIters = 10000;
iters = zeros(nIters,1);
for i=1:nIters
    [params, bestIter] = RANSAC(kp_matches, fa, fb, 100, 10);
    iters(i) = bestIter;
end
disp(['Average number of iterations necessary to find the best params: ', num2str(mean(iters))])