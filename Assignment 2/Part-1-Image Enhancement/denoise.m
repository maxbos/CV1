function [ imOut ] = denoise( image, kernel_type, varargin)

I = imread(image);
vec = cell2mat(varargin);

switch kernel_type
    case 'box'
        boxsize = vec(1);
        imOut = imboxfilt(I, boxsize);
    case 'median'
        boxsize = vec(1);
        imOut = medfilt2(I, [boxsize boxsize]);
    case 'gaussian'
        sigma = vec(1);
        kernel_size = vec(2);
        imOut = imfilter(I, gauss2D(sigma, kernel_size));
        
end
end
