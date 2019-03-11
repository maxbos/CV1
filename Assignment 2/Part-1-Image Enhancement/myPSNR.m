function [ PSNR ] = myPSNR( orig_image, approx_image )

O = imread(orig_image);
% A = imread(approx_image);
A = imread(approx_image);

imsize = size(O)

MSE = 1/(imsize(1)*imsize(2)) * sum(sum((O - A).^2))

PSNR = 10*log10(double(max(max(O)))/sqrt(MSE))

end


% myPSNR