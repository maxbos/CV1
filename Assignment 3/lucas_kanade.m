function [] = lucas_kanade(im1, im2)
% 1.  Divide input images on non-overlapping regions, each region being 15 × 15.
% 2.  For each region compute A, AT and b. Then, estimate optical flow as
% given in Equation 20.
% 3.  When you have estimation for optical flow (Vx, Vy) of each region, you 
% should display the results. There is a MATLAB function quiver which 
% plots a set of two-dimensional vectors as arrows on the screen. Try to 
% figure out how to use this to plot your optical flow results.

% Create a vector containing all indices for the regions, e.g.
% (1,1),(1,15),(1,30),(15)
(height, width) = size(im1);

for i = 1:15:height
    for j = 1:15:width
        % Create the A matrix for this region.
        A = ;
        % Create the b vector for this region.
        b = ;
        v = inv(A.T.*A).*A.T*b;
    end
end
