clear
clc
close all

%In this script the Grey World algorithm is applied using addition and
%scaling to obtain the desired average of 128 on every channel.

%because it is unclear what method is desired for the assignment, both are
%given (addition, scaling). If only one method is graded, please ignore the
%addition algorithm.

%read image to process
I = imread('awb.jpg');

%grey world assumes that RGB values are linear, .jpg is saved in
%gamma-corrected sRGB space (according to matlab docs). rgb2lin() corrects this. 
I_lin = rgb2lin(I);

%get sizes for further computations
size = size(I_lin);
layer_size = [size(1)*size(2), 1];

%save rgb values in separate vectors
r_old = (reshape(I_lin(:,:,1), layer_size));
g_old = (reshape(I_lin(:,:,2), layer_size));
b_old = (reshape(I_lin(:,:,3), layer_size));

%take averages of r, g and b values
r_avg = mean(r_old);
g_avg = mean(g_old);
b_avg = mean(b_old);

avg = mean([r_avg g_avg b_avg]);

%calculate difference between current mean and assumed mean of 128/channel
r_dif = 128.0 - r_avg;
g_dif = 128.0 - g_avg;
b_dif = 128.0 - b_avg;

%calculate ratio to multiply with to opbtain assumed mean of 128/channel
r_ratio = 128/r_avg
g_ratio = 128/g_avg
b_ratio = 128/b_avg

%add  difference to original values to obtain desired mean
r_new_addition = double(r_old) + (r_dif*(ones(layer_size)));
g_new_addition = double(g_old) + (g_dif*(ones(layer_size)));
b_new_addition = double(b_old) + (b_dif*(ones(layer_size)));

%multiply old values with calculated ratios to obtain desired mean
r_new_scaled = double(r_old) * r_ratio;
g_new_scaled = double(g_old) * g_ratio;
b_new_scaled = double(b_old) * b_ratio;


%reshape rgb vectors back to original shape and data type
r_add = uint8(reshape(r_new_addition, [320 ,256]));
g_add = uint8(reshape(g_new_addition, [320 ,256]));
b_add = uint8(reshape(b_new_addition, [320 ,256]));

r_scaled = uint8(reshape(r_new_scaled, [320 ,256]));
g_scaled = uint8(reshape(g_new_scaled, [320 ,256]));
b_scaled = uint8(reshape(b_new_scaled, [320 ,256]));

%concatenate arrays to retrieve original form 
grey_world_add = cat(3, r_add, g_add, b_add);
grey_world_scaled = cat(3, r_scaled, g_scaled, b_scaled);

%plot the original image and processed images
figure;
subplot(3,1,1),imshow(I);
subplot(3,1,1),annotation('textbox',[0.1 0.5 0.3 0.3], 'String', 'Original Image', 'FitBoxToText','on')
subplot(3,1,2),imshow(grey_world_add);
subplot(3,1,2),annotation('textbox',[0.1 0.3 0.3 0.3], 'String', 'Grey World Addition-Processed Image', 'FitBoxToText','on')
subplot(3,1,3),imshow(grey_world_scaled);
subplot(3,1,3),annotation('textbox',[0.1 0.0 0.3 0.3], 'String', 'Grey World Scaling-Processed Image', 'FitBoxToText','on')
