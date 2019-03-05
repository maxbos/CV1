%% sphere
[x,y,u,v] = lucas_kanade("sphere1.ppm", "sphere2.ppm", 15);
figure(1);
sphere1 = imread("sphere1.ppm");
imshow(sphere1)
hold on
quiver(x,y,u,v, 'color', [1 0 0])
hold off

% figure(2);
% sphere1 = imread("sphere1.ppm");
% imshow(sphere1)
% hold on
% quiver(x,y,u,v, 'color', [1 0 0])
% hold off


%% synth
[x,y,u,v] = lucas_kanade("synth1.pgm", "synth2.pgm", 15);
figure(2);
synth1 = imread("synth1.pgm");
imshow(synth1)
hold on
quiver(y,x,u,v, 'color', [1 0 0])
hold off

figure(3);
synth1 = imread("synth1.pgm");
imshow(synth1)
hold on
quiver(x,y,u,v, 'color', [1 0 0])
hold off


%% lucas kanade
[x,y,u,v] = lucas_kanade("0000.jpeg", "0001.jpeg", 16);
figure(1);
sphere1 = imread("0000.jpeg");
subplot(1,2,1);
imshow(sphere1);
hold on
quiver(x,y,u,v, 'color', [1 0 0])
hold off
subplot(1,2,2);
imshow(imread("0001.jpeg"));
hold on
quiver(x,y,u,v, 'color', [1 0 0])
hold off


% if the quiver plots come out overlapping, rerun the script. if it keeps
% failing, comment out one of the two blocks