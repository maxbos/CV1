function [output_image] = rgb2normedrgb(input_image)
% converts an RGB image into normalized rgb
r = input_image(:,:,1)/ (input_image(:,:,1) + input_image(:,:,2) + input_image(:,:,3));
g = input_image(:,:,2)/ (input_image(:,:,1) + input_image(:,:,2) + input_image(:,:,3));
b = input_image(:,:,3)/ (input_image(:,:,1) + input_image(:,:,2) + input_image(:,:,3));

output_image = cat(3, r, g, b);
end

