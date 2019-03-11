function dispRansacResults(originalImg, transformedImg, titleText)
    figure;
    suptitle(titleText);
    subplot(1, 2, 1); imshow(originalImg);
    subplot(1, 2, 2); imshow(transformedImg);
end
