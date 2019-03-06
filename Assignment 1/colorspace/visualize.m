function visualize(input_image)

imsize = size(input_image);

%output r,g,b image and r,g,b separately 
if (size(imsize) == [1 3])

    figure;
    subplot(4,1,1),imshow(input_image);

    subplot(4,1,2),imshow(input_image(:,:,1));

    subplot(4,1,3),imshow(input_image(:,:,2));

    subplot(4,1,4),imshow(input_image(:,:,3));

%different routine for grays
else
    
    figure;
    imshow(input_image);
    
end
    
end

