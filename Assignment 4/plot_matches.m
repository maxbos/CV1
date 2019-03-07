function plot_matches(img1, img2, points1, points2)
% plot_matches
%   Plot matches between img1, img2 based on the x,y
%   locations in each image
im1 = imread(img1);
im2 = imread(img2);
% Concatenate images
im = cat(2, im1, im2);
imshow(im);
hold on
for i=1:size(points1,2)
    % Plot points on first image
    x1 = points1(1,i);
    y1 = points1(2,i);
    plot(x1, y1, 'r*');
    % Plot points on second image
    x2 = points2(1,i) + size(im1,2);
    y2 = points2(2,i);
    plot(x2, y2, 'b*');
    % Plot line between points
    x = [x1, x2];
    y = [y1, y2];
    plot(x, y, 'LineWidth', 2);
end
hold off
end

