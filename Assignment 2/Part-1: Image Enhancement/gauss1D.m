function G = gauss1D( sigma , kernel_size )
    G = zeros(1, kernel_size);
    if mod(kernel_size, 2) == 0
        error('kernel_size must be odd, otherwise the filter will not have a center to convolve on')
    end
    
    function g = gaussian(x)
        g = 1/(sigma*(2*pi)^(1/2)) * exp(-((x)^2)/(2*sigma^2));
    end

    bound = floor(kernel_size/2);
    idx = 1;
    
    for x = -bound:bound
        G(1, idx) = gaussian(x);
        idx = idx + 1;
    end
    
    G = normalize(G,'norm',1);
end
