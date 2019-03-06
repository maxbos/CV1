function [output_image] = rgb2grays(input_image)

colours=getColorChannels(input_image);

% converts an RGB into grayscale by using 4 different methods

% ligtness method
lightness=(max(colours, [], 3)+min(colours, [], 3))/2;
% average method
 average=mean(colours,3);
% luminosity method
luminosity=0.21*colours(:,:,1) + 0.72*colours(:,:,1) + 0.07*colours(:,:,1);
% built-in MATLAB function 
matGray=rgb2gray(input_image);

output_image =[lightness,average;luminosity,matGray];
end

