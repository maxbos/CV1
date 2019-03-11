% Using your implemented function denoise, try denoising im- age1 saltpepper.jpg and image1 gaussian.jpg by applying the following filters:
% (a) Box filtering of size: 3x3, 5x5, and 7x7.
% (b) Median filtering with size: 3x3, 5x5 and 7x7.
% Show the denoised images in your report.
% 2. Using your implemented function myPSNR, compute the PSNR for every denoised image (12 in total). What is the effect of the filter size on the PSNR? Report the results in a table and discuss.


myPSNR( 'image1.jpg', 'image1_saltpepper.jpg')

% box3s = (denoise( 'image1_saltpepper.jpg', 'box', 3));
% box5s = (denoise( 'image1_saltpepper.jpg', 'box', 5));
% box7s = (denoise( 'image1_saltpepper.jpg', 'box', 7));
% 
% box3g = (denoise( 'image1_gaussian.jpg', 'box', 3));
% box5g = (denoise( 'image1_gaussian.jpg', 'box', 5));
% box7g = (denoise( 'image1_gaussian.jpg', 'box', 1));
% 
% med3s = (denoise( 'image1_saltpepper.jpg', 'median', 3));
% med5s = (denoise( 'image1_saltpepper.jpg', 'median', 5));
% med7s = (denoise( 'image1_saltpepper.jpg', 'median', 7));
% 
% med3g = (denoise( 'image1_gaussian.jpg', 'median', 3));
% med5g = (denoise( 'image1_gaussian.jpg', 'median', 5));
% med7g = (denoise( 'image1_gaussian.jpg', 'median', 7));
% 
% 
% figure;
% subplot(1,3,1),imshow(box3g);
% subplot(1,3,2),imshow(box5g);
% subplot(1,3,3),imshow(box7g);
% 
% myPSNR('image1.jpg', box7g)

a = denoise( 'image1_gaussian.jpg', 'gaussian', 10, 5);
figure;
imshow(a)
myPSNR('image1.jpg', a);
% imshow(box5s)
% imshow(box7s)
% imshow(box3g)
% imshow(box5g)
% imshow(box7g)
% imshow(med3s)
% imshow(med5s)
% imshow(med7s)
% imshow(med3g)
% imshow(med5g)
% imshow(med7g)