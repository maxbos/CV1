%% sphere
[x,y,u,v] = lucas_kanade("sphere1.ppm", "sphere2.ppm", 15);
figure(1);
sphere1 = imread("sphere1.ppm");
imshow(sphere1)
hold on
quiver(x,y,u,v, 'color', [1 0 0])
hold off

mkdir 'lucas_kanade';
saveas(gcf, 'lucas_kanade/sphere.png');

%% synth
[x,y,u,v] = lucas_kanade("synth1.pgm", "synth2.pgm", 15);
figure(2);
synth1 = imread("synth1.pgm");
imshow(synth1)
hold on
quiver(x,y,u,v, 'color', [1 0 0])
hold off

mkdir 'lucas_kanade';
saveas(gcf, 'lucas_kanade/synth.png');

%% 
[x,y,u,v] = lucas_kanade('pingpong./0000.jpeg', 'pingpong/0001.jpeg', 16);
figure(1);
sphere1 = imread('pingpong/0000.jpeg');
subplot(1,2,1);
imshow(sphere1);
hold on
quiver(x,y,u,v, 'color', [1 0 0])
hold off
subplot(1,2,2);
imshow(imread('pingpong0001.jpeg'));
hold on
quiver(x,y,u,v, 'color', [1 0 0])
hold off


% if the quiver plots come out overlapping, rerun the script. if it keeps
% failing, comment out one of the two blocks