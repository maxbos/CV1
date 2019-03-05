function [H,r,c] = harris_corner_detector(img, visFlag)
%Harris Corner Detector
%   Finds corners in images, returns the H matrix and
%   the coordinates of the corners
if nargin == 1
    visFlag = true;
end

% Convert image to gray and double values
img = im2double(rgb2gray(img));

% Create Gaussian filter and do elementwise
% multiplication to increase effectiveness
G = fspecial('gaussian', 7, 0.7).*6;
% Get gradients of Gaussian in x and y direction
[Gx, Gy] = gradient(G);

% Convolve image with Gaussian derivatives
Ix = conv2(Gx, img);
Iy = conv2(Gy, img);

% Square previous result and convolve with Gaussian
% to find A, B and C
A = conv2(G, Ix.^2);
B = conv2(G, Ix.*Iy);
C = conv2(G, Iy.^2);

% Calculate H matrix
H = (A.*C)-(B.^2)-0.04*(A+C).^2;

% Keep values above threshold
J = imhmax(H, 0.3);
% Find coordinates of local maxima
maxima = imregionalmax(J);
[r,c] = find(maxima);

% Plot results
if visFlag
    figure('Position', [200 200 900 600]);
    subplot(1,3,1); 
    imshow(Ix);
    title('First order Gaussian derivative in x-direction');
    subplot(1,3,2); 
    imshow(Iy);
    title('First order Gaussian derivative in y-direction');
    subplot(1,3,3);
    imshow(img);
    title('Detected corners');
    hold on
    plot(c,r,'r.');
    hold off
end