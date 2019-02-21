%% 3.1.2 2D Gaussian filter
% Testing the difference between the 2D gaussian filter and a 1D gaussian
% filter in the x- and y-direction.
clear all;
og_im = imread('images/image1.jpg');

filter_1d = gauss1D(2, 5);
filter_2d = gauss2D(2, 5);
result_1d_filter = uint8(conv2(filter_1d, filter_1d, og_im));
result_2d_filter = uint8(conv2(filter_2d, og_im));

imwrite(og_im, '3.1.2-og_im.png');
imwrite(result_1d_filter, '3.1.2-1Df_im.png');
imwrite(result_2d_filter, '3.1.2-2Df_im.png');

% figure(1);
% subplot(1,3,1); imshow(og_im); title('original');
% subplot(1,3,2); imshow(result_1d_filter); title('applying 1D filter');
% subplot(1,3,3); imshow(result_2d_filter); title('applying 2D filter');

figure(2);
diff = result_2d_filter - result_1d_filter;
plot(diff);
title('difference between 1D and 2D filter conv. result');
saveas(gcf, '3.1.2-difference.png');
