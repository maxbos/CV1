stitched = stitch('left.jpg', 'right.jpg');
figure;
imshow(uint8(stitched));
title('Images transformed and stitched');