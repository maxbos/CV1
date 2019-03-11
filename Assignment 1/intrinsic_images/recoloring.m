shad=imread('ball_shading.png');
orig=imread('ball.png');
alb = imread('ball_albedo.png');
trueColour=unique(alb);

shape=size(alb);
len=shape(1);
width=shape(2);
green=alb;
green(:,:,1)=zeros(len,width);
greenMultp=(255/141)*(zeros(len,width)+1);
green=double(green);
green(:,:,2)=greenMultp.*green(:,:,2);
green(:,:,3)=zeros(len,width);

shadDoub=double(shad);
shadDoub=shadDoub./255;

reconGreen=green.*shadDoub;
reconGreen=uint8(reconGreen);

subplot(1,2,1);
imshow(orig);
title('original')  

subplot(1,2,2);
imshow(reconGreen);
title('recolored')  



