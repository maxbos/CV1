function tracking_final(frameFolder)
    files = dir(fullfile(frameFolder, '*.jpeg'));
    nfiles = length(files);
    
    window_size = 16;
    
    % Calculate the corners on the first image.
    og_im_path = fullfile(frameFolder, files(1).name);
    im = imread(og_im_path);
    [~, y_harris, x_harris] = harris_corner_detector(im, false);
    %C = corner(rgb2gray(im), 'Harris', 100);
    %y_harris = C(:,2);
    %x_harris = C(:,1);
    ncornerpoints = length(y_harris);
    
    og_im_size = size(im);
    
    video = VideoWriter('yourvideo.avi'); %create the video object
    open(video); %open the file for writing
    
    for file = 2:nfiles
        % Calculate the optical flow between this image and the original
        % image from which the corners were detected.
        prev_im_path = fullfile(frameFolder, files(file-1).name);
        curr_im_path = fullfile(frameFolder, files(file).name);
        [x, y, u, v] = lucas_kanade(prev_im_path, curr_im_path, window_size);
        % Loop through each corner point and update its position.
        for corner_idx = 1:ncornerpoints
            m = y_harris(corner_idx);
            n = x_harris(corner_idx);
            [patch_x, patch_y] = get_patch_index(n, m, u);
            y_harris(corner_idx) = max(1, min(uint8(m + v(patch_y, patch_x)*window_size), og_im_size(1)));
            x_harris(corner_idx) = max(1, min(uint8(n + u(patch_y, patch_x)*window_size), og_im_size(2)));
        end
        write_video(file, imread(curr_im_path), x_harris, y_harris,u,v,x,y);
    end
    
    close(video); %close the file
    
    function [patch_x, patch_y] = get_patch_index(x, y, u)
        [patches_h, patches_w] = size(u);
        patch_x = max(1, min(ceil(x/window_size), patches_w));
        patch_y = max(1, min(ceil(y/window_size), patches_h));
    end
    
    function write_video(i, im, c, r, u, v,x,y)
        % n = index of the column
        % m = index of the row
        f = figure('visible','off');
        imshow(im);
        hold on;
%         quiver(x,y,u,v, 'color', [1 0 0])
        scatter(c, r);
        hold off;
        writeVideo(video,getframe(f)); %write the image to file
    end
end