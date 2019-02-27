function [Gx, Gy, im_magnitude, im_direction] = compute_gradient(image)
    Gx_filter = [1 0 -1; 2 0 -2; 1 0 -1];
    Gx = conv2(Gx_filter, image);
    Gy_filter = [1 2 1; 0 0 0; -1 -2 -1];
    Gy = conv2(Gy_filter, image);
    im_magnitude = uint8((Gx.^2 + Gy.^2).^(1/2));
    im_direction = atan2(Gy,Gx);
end

