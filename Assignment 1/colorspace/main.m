% test your code by using this simple script

clear
clc
close all

I = imread('peppers.png');

O = ConvertColorSpace(I,'opponent');
 
% close all
N = ConvertColorSpace(I,'rgb');

% close all
H = ConvertColorSpace(I,'hsv');

% close all
Y = ConvertColorSpace(I,'ycbcr');

% close all
G = ConvertColorSpace(I,'gray');

% visualize(G)
% visualize(H)
% visualize(I)
% visualize(N)
% visualize(O)
% visualize(Y)