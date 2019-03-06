function [albedo, normals, height_map] = run_photometric(image_dir, channel)
    warning('off')
    [image_stack, scriptV] = load_syn_images(image_dir, channel);
    [albedo, normals] = estimate_alb_nrm(image_stack, scriptV, true);
    warning('on')
    [p, q, SE] = check_integrability(normals);
%     threshold = 0.005;
%     SE(SE <= threshold) = NaN;
%     fprintf('Number of outliers: %d\n\n', sum(sum(SE > threshold)));
    % Compute the surface height
    height_map = construct_surface( p, q, 'average' );
end