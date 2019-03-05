% sphere
[x,y,u,v] = lucas_kanade("sphere1.ppm", "sphere2.ppm", 15)
figure
imshow(sphere1)
hold on
quiver(x,y,u,v)
hold off

% synth
[x,y,u,v] = lucas_kanade("synth1.pgm", "synth2.pgm", 15)
figure
imshow(synth1)
hold on
quiver(x,y,u,v)
hold off