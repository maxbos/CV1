function [H,r,c] = harris_corner_detector(img, visFlag)
%Harris Corner Detector
%   Finds corners in images, returns the H matrix and
%   the coordinates of the corners
if nargin == 1
    visFlag = true;
end

img = im2double(rgb2gray(img));
% Ix = imgaussfilt(img, 10, 'FilterSize', [1,9]);
% Iy = imgaussfilt(img, 10, 'FilterSize', [9,1]);

G=fspecial('gauss',[9, 9], 2);
[Gx,Gy] = gradient(G);  
Ix = imfilter(img, Gx);
Iy = imfilter(img, Gy);

A = imgaussfilt(Ix.^2);
B = imgaussfilt(Ix.*Iy);
C = imgaussfilt(Iy.^2);
H = (A.*C-B.^2)-0.04*(A+C).^2;

maxima = islocalmax(H, 'ProminenceWindow', 5, 'MinProminence', 0.015);
[r,c] = find(maxima);

if visFlag
    figure(1);
    subplot(1,3,1); imshow(Ix);
    subplot(1,3,2); imshow(Iy);
    subplot(1,3,3);
    imshow(img);
    hold on
    plot(r,c,'r*');
    hold off
end
