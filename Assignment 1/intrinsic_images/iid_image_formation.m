shad=imread('ball_shading.png');
orig=imread('ball.png');
alb = imread('ball_albedo.png');
size(alb)
size(shad)
shadDoub=double(shad);
shadDoub=shadDoub./255;
albDoub=double(alb);
recon=albDoub.*shadDoub;

recon=uint8(recon);
subplot(2,2,1);
imshow(orig);
title('original'); 
subplot(2,2,2);
imshow(recon);
title('reconstructed'); 

subplot(2,2,3);
imshow(alb);
title('albedo');

subplot(2,2,4);
imshow(shad);
title('shade');
