
function [x,y,u,v] = lucas_kanade(img1, img2, window_size)
% lucas kanade optical flow estimation
%   input 2 images and window size, return xy coordinates of window centers
%   and corresponding optical flow vectors

if (sum(size(size(imread(img1)))) > 3) % weird way to check if RGB
    
%     read images into matrices
    imgmat = rgb2gray(imread(img1))
    imgmat2 = rgb2gray(imread(img2));
else
    imgmat = imread(img1);
    imgmat2 = imread(img2);
end

% cut images in windows of window_size, save them in cells
img_size = size(imgmat);
img1cut = divide(imgmat, window_size);
img2cut = divide(imgmat2, window_size);

% define optical flow matrices
windowsN = floor(img_size/window_size)
u = zeros(windowsN)
v = zeros(windowsN)

% set xy grid to plot flow vectors, based on window and image size
x = ceil(window_size/2):window_size:img_size(1)-1;
y = ceil(window_size/2):window_size:img_size(2)-1;

% calculate flow vectors for every window
for i = 1:windowsN(1)
    for j = 1:windowsN(2)
        window = cell2mat(img1cut(i,j));
        window2 = cell2mat(img2cut(i,j));
        V = computev(window, window2);
        u(i,j) = V(1);
        v(i,j) = V(2);
    end
end

end

function [v] = computev(img1, img2)
A = computeA(img1);
b = computeb(img1, img2);
v = (A.'*A)\A.'*double(b); % = inv(A.'*A)*A.'*double(b)
end

function [A] = computeA(img)
[Ix, Iy] = imgradientxy(img);
A = [reshape(Ix, [], 1) reshape(Iy, [], 1)];
end

function [b] = computeb(img1, img2)
b = reshape((img1 - img2),[], 1);
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


