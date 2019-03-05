function tracking_test(frameFolder)
    files = dir(fullfile(frameFolder, '*.jpeg'));
    nfiles = length(files);
    
    opticFlow = opticalFlowLK('NoiseThreshold', 0.009);
    % Estimate the corners for the first image.
    im1 = imread(fullfile(frameFolder, files(1).name));
    im2 = imread(fullfile(frameFolder, files(2).name));
    im1Gray = rgb2gray(im1);
    C = corner(rgb2gray(im2), 'Harris', 50);
    % Estimate the optical flow for the first image.
    flow = estimateFlow(opticFlow, im1Gray);
    
    video = VideoWriter('yourvideo.avi'); %create the video object
    open(video); %open the file for writing
    
    write_video(1, im1Gray, C(:,1), C(:,2));
    
    % Start with calculating the flow from the second image, since
    % it has already been initialized with the first image.
    for img = 2:5
        frameRGB = imread(fullfile(frameFolder, files(img).name));
        frameGray = rgb2gray(frameRGB);
        flow = estimateFlow(opticFlow, frameGray);
        for idx = 1:length(C)
            xy = C(idx,:);
            disp("new image")
            x = uint8(xy(1))
            y = uint8(xy(2))
            idx
            C(idx, 1)
            C(idx, 2)
%             flow.Vx(y, x)
%             flow.Vy(y, x)
            % Update the x position.
            C(idx, 1) = (C(idx, 1) + flow.Orientation(y, x));
            C(idx, 2) = (C(idx, 2) + flow.Magnitude(y, x));
            C(idx, 1)
            C(idx, 2)
        end
        write_video(img, frameRGB, C(:,1), C(:,2));
%          size(flow.Vx)
%          size([flow.Vx' flow.Vy'])
%          C = C + [flow.Vx' flow.Vy'];
%          figure(img);
%          imshow(frameRGB);
%          hold on
%          plot(C(:,1),C(:,2),'r.');
%          plot(flow,'DecimationFactor',[5 5],'ScaleFactor',10);
%          hold off
%         figure(img);
%         imshow(frameRGB);
%         hold on;
%         plot(C(:,1), C(:,2), 'r.');
%         hold off;
    end
    close(video); %close the file
    
    function write_video(i,im, c, r)
        figure(i);
        imshow(im);
        hold on;
        plot(c,r,'r.');
        hold off;
      %read the next image
       writeVideo(video,getframe(gcf)); %write the image to file
    end
end