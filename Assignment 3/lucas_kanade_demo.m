% sphere
[x,y,u,v] = lucas_kanade("sphere1.ppm", "sphere2.ppm", 15);
figure(1);
sphere1 = imread("sphere1.ppm");
imshow(sphere1)
hold on
quiver(x,y,u,v, 'color', [1 0 0])


% synth
[x,y,u,v] = lucas_kanade("synth1.pgm", "synth2.pgm", 15);
figure(2);
synth1 = imread("synth1.pgm");
imshow(synth1)
hold on
quiver(x,y,u,v, 'color', [1 0 0])


% if the quiver plots come out overlapping, rerun the script. if it keeps
% failing, comment out one of the two blocks