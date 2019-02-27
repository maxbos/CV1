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

%% 4.3.1 First-order derivative filters
% Using your implemented function compute gradient on image2.jpg, display
% the following figures: 1. The gradient of the image in the x-direction. 
% 2. The gradient of the image in the y-direction. 3. The gradient 
% magnitude of each pixel. 4. The gradient direction of each pixel.
clear all;
og_im = imread('images/image2.jpg');

[Gx, Gy, im_magnitude, im_direction] = compute_gradient(og_im);

imwrite(og_im, '4.3.1-og_im.png');
imwrite(Gx, '4.3.1-Gx.png');
imwrite(Gy, '4.3.1-Gy.png');
imwrite(im_magnitude, '4.3.1-im_magnitude.png');
imwrite(im_direction, '4.3.1-im_direction.png');

figure(1);
subplot(2,3,1); imshow(og_im); title('original');
subplot(2,3,2); imshow(Gx); title('Gradient in x-direction');
subplot(2,3,3); imshow(Gy); title('Gradient in y-direction');
subplot(2,3,4); imshow(im_magnitude); title('Gradient magnitude of each pixel');
subplot(2,3,5); imshow(im_direction); title('Gradient direction of each pixel');

%%
% Testing, TODO: check if these differences are correct
og_im = imread('images/image2.jpg');

[Gx, Gy, im_magnitude, im_direction] = compute_gradient(og_im);
[Gmag, Gdir] = imgradient(og_im);
subplot(2,2,1); imshow(im_magnitude);
subplot(2,2,2); imshow(Gmag);
subplot(2,2,3); imshow(im_direction);
subplot(2,2,4); imshow(Gdir);


%% 4.3.2
clear all;
og_im = im2double(imread('images/image2.jpg'));

% Compute LoG using three different methods
method_1 = compute_LoG(og_im, 1);
method_2 = compute_LoG(og_im, 2);
method_3 = compute_LoG(og_im, 3);

% Normalize output to the range [0,1]
method_1 = mat2gray(method_1);
method_2 = mat2gray(method_2);
method_3 = mat2gray(method_3);

% Save images
imwrite(og_im, '4.3.2-og_im.png');
imwrite(method_1, '4.3.2-method_1.png');
imwrite(method_2, '4.3.2-method_2.png');
imwrite(method_3, '4.3.2-method_3.png');

figure(1);
subplot(2,2,1); imshow(og_im); title('Original image');
subplot(2,2,2); imshow(method_1); title('Method 1');
subplot(2,2,3); imshow(method_2); title('Method 2');
subplot(2,2,4); imshow(method_3); title('Method 3');
