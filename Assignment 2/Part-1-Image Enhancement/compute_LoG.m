function imOut = compute_LoG(image, LOG_type)

switch LOG_type
    case 1
        %method 1
        h1 = fspecial('gaussian', 5, 0.5);
        h2 = fspecial('laplacian');
        image = conv2(image, h1);
        imOut = conv2(image, h2);
    case 2
        %method 2
        h = fspecial('log', 5, 0.5);
        imOut = conv2(image, h);
    case 3
        %method 3
        h1 = fspecial('gaussian', 5, 0.5);
        im1 = conv2(image, h1);
        h2 = fspecial('gaussian', 5, 0.8);
        im2 = conv2(image, h2);
        imOut = im2 - im1;
end
end

