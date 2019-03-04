sphere1 = rgb2gray(imread("sphere1.ppm"));
sphere2 = rgb2gray(imread("sphere2.ppm"));
synth1 = imread("synth1.pgm");
synth2 = imread("synth2.pgm");

% cut images in windows of 15x15, saved in cells
sphere1cut = divide(sphere1, 15);
sphere2cut = divide(sphere2, 15);
synth1cut = divide(synth1, 15);
synth2cut = divide(synth2, 15);

% define optical flow matrices
u_sphere = zeros(13,13);
v_sphere = zeros(13,13);
u_synth = zeros(8,8);
v_synth = zeros(8,8);

% set xy grid to plot flow vectors, based on window and image size
x_sphere = 8:15:200;
y_sphere = 8:15:200;
x_synth = 8:15:127;
y_synth = 8:15:127;

% calculate flow vectors for every window
% sphere
for i = 1:13
    for j = 1:13
        window = cell2mat(sphere1cut(i,j));
        window2 = cell2mat(sphere2cut(i,j));
        V = computev(window, window2);
        u_sphere(i,j) = V(1);
        v_sphere(i,j) = V(2);
    end
end

% synth
for i = 1:8
    for j = 1:8
        window = cell2mat(synth1cut(i,j));
        window2 = cell2mat(synth2cut(i,j));
        V = computev(window, window2);
        u_synth(i,j) = V(1);
        v_synth(i,j) = V(2);
    end
end

% plot flow vectors on image
% sphere
figure
imshow(sphere1)
hold on
quiver(x_sphere,y_sphere,u_sphere,v_sphere)
hold off

% synth
figure
imshow(synth1)
hold on
quiver(x_synth,y_synth,u_synth,v_synth)
hold off

function [v] = computev(img1, img2)
A = computeA(img1);
b = computeb(img1, img2);
v = (A.'*A)\A.'*double(b); % = inv(A.'*A)*A.'*double(b)
end

function [A] = computeA(img)
[Ix, Iy] = imgradientxy(img);
A = [reshape(Ix, [], 1) reshape(Iy, [], 1)]
end

function [b] = computeb(img1, img2)
b = reshape((img1 - img2),[], 1)
end

function [divided] = divide(img, window_size)
img_size = size(img);
window_grid = floor(img_size./window_size);
divided = cell(window_grid) ;

for i = 1:window_grid(1)
    for j = 1:window_grid(2)
        divided(i,j) = {img((i-1)*window_size+1:(i-1)*window_size+window_size,(j-1)*window_size+1:(j-1)*window_size+window_size)};
    end
end
end


