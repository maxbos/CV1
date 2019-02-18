function [output_image] = rgb2opponent(input_image)
% converts an RGB image into opponent color space

O1 = (input_image(:,:,1) - input_image(:,:,2))/sqrt(2);
O2 = (input_image(:,:,1) + input_image(:,:,2) - 2*input_image(:,:,3)/sqrt(6));
O3 = (input_image(:,:,1) + input_image(:,:,2) - input_image(:,:,3)/sqrt(3));

output_image = cat(3, O1, O2, O3);
end

