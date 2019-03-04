synth1 = imread("synth1.pgm");
synth2 = imread("synth2.pgm");
sphere1 = imread("sphere1.ppm");
sphere2 = imread("sphere2.ppm");


divide(synth1,15)

[a,b] =(imgradientxy(synth1))


function [divided] = divide(img, region_size);
img_size = size(img)
region_grid = floor(img_size./region_size)
divided = cell(region_grid) 

for i = 1:region_grid(1)
    for j = 1:region_grid(2)
        divided(i,j) = {img((i-1)*region_size+1:(i-1)*region_size+region_size,(j-1)*region_size+1:(j-1)*region_size+region_size)}
    end
end
end


