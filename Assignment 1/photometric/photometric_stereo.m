close all
clear all
clc
 
disp('Part 1: Photometric Stereo')
        
% obtain many images in a fixed view under different illumination
disp('Loading images...')
image_dir = './photometrics_images/SphereGray5/';   % TODO: get the path of the script
%image_ext = '*.png';

[image_stack, scriptV] = load_syn_images(image_dir);
[h, w, n] = size(image_stack);
fprintf('Finish loading %d images.\n\n', n);

% compute the surface gradient from the stack of imgs and light source mat
disp('Computing surface albedo and normal map...')
% The estimate_alb_nrm function triggers some Matlab warnings, so we turn
% them of temporarirly
warning('off')
[albedo, normals] = estimate_alb_nrm(image_stack, scriptV, false);
warning('on')
disp('Done')

%% integrability check: is (dp / dy  -  dq / dx) ^ 2 small everywhere?
disp('Integrability checking')
[p, q, SE] = check_integrability(normals);

threshold = 0.005;
SE(SE <= threshold) = NaN; % for good visualization
fprintf('Number of outliers: %d\n\n', sum(sum(SE > threshold)));

%% compute the surface height
height_map = construct_surface( p, q, 'average' );

%% Display
show_results(albedo, normals, SE);
show_model(albedo, height_map);

%% Shape by comparison difference experiments
col_hm = construct_surface( p, q, 'column' );
row_hm = construct_surface( p, q, 'row' );
avg_hm = construct_surface( p, q, 'average' );
inspect_height_map(col_hm, 'column-major');
inspect_height_map(row_hm, 'row-major');
inspect_height_map(avg_hm, 'average');

%% MonkeyGray
[image_stack, scriptV] = load_syn_images('./photometrics_images/MonkeyGray/');
[h, w, n] = size(image_stack);
fprintf('Finish loading %d images.\n\n', n);
disp('Computing surface albedo and normal map...')
[albedo, normals] = estimate_alb_nrm(image_stack, scriptV);

%% integrability check: is (dp / dy  -  dq / dx) ^ 2 small everywhere?
disp('Integrability checking')
[p, q, SE] = check_integrability(normals);

threshold = 0.005;
SE(SE <= threshold) = NaN; % for good visualization
fprintf('Number of outliers: %d\n\n', sum(sum(SE > threshold)));

%% compute the surface height
height_map = construct_surface( p, q );

show_results(albedo, normals, SE);
show_model(albedo, height_map);  

%% Part 1.4.2
close all
clear all
clc
disp('Part 1.4.2 - 3 channel albedo')
disp('Loading images...')
image_dir = './photometrics_images/SphereColor/';

% We need to load the image stack for each of the 3 channels
warning('off')
[image_stack, scriptV] = load_syn_images(image_dir, 1);
[alb_1, nrm_1] = estimate_alb_nrm(image_stack, scriptV, false);
[image_stack, scriptV] = load_syn_images(image_dir, 2);
[alb_2, nrm_2] = estimate_alb_nrm(image_stack, scriptV, false);
[image_stack, scriptV] = load_syn_images(image_dir, 3);
[alb_3, nrm_3] = estimate_alb_nrm(image_stack, scriptV, false);
warning('on')

albedo = cat(3, alb_1, alb_2, alb_3);

%%
% Integrability check: is (dp / dy  -  dq / dx) ^ 2 small everywhere?
disp('Integrability checking')
[p_1, q_1, SE_1] = check_integrability(nrm_1);
hm_1 = construct_surface( p_1, q_1, 'average' );
[p_2, q_2, SE_2] = check_integrability(nrm_2);
hm_2 = construct_surface( p_2, q_2, 'average' );
[p_3, q_3, SE_3] = check_integrability(nrm_3);
hm_3 = construct_surface( p_3, q_3, 'average' );
% p = calc_avg(p_1, p_2, p_3);
% q = calc_avg(q_1, q_2, q_3);
% SE = calc_avg(SE_1, SE_2, SE_3);
height_map = calc_avg(hm_1, hm_2, hm_3);

normals = calc_avg(nrm_1, nrm_2, nrm_3);
% [p,q,SE] = check_integrability(nrm_3);

threshold = 0.005;
SE(SE <= threshold) = NaN;
fprintf('Number of outliers: %d\n\n', sum(sum(SE > threshold)));
% Compute the surface height
% height_map = construct_surface( p, q, 'column' );
% Show the results

show_results(albedo, normals, SE);
show_model(albedo, height_map);

inspect_height_map(height_map, 'average');

%% Face
[image_stack, scriptV] = load_face_images('./photometrics_images/', '02');
[h, w, n] = size(image_stack);
fprintf('Finish loading %d images.\n\n', n);
disp('Computing surface albedo and normal map...')
[albedo, normals] = estimate_alb_nrm(image_stack, scriptV, false);

%% integrability check: is (dp / dy  -  dq / dx) ^ 2 small everywhere?
disp('Integrability checking')
[p, q, SE] = check_integrability(normals);

threshold = 0.005;
SE(SE <= threshold) = NaN; % for good visualization
fprintf('Number of outliers: %d\n\n', sum(sum(SE > threshold)));

%% compute the surface height
height_map = construct_surface( p, q, 'average' );

% show_results(albedo, normals, SE);
show_model(albedo, height_map);