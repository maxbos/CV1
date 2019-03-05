function video = tracking(frameFolder)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
    % obtain many images in a fixed view under different illumination
    files=dir(fullfile(frameFolder,'*.jpeg'));
    im=fullfile(frameFolder,files(1).name());
    im=imread(im);
    [h,r,c]=harris_corner_detector(im,false);

    cNew=c;

    rNew=r;

    video = VideoWriter('yourvideo.avi'); %create the video object
    open(video); %open the file for writing
    
    write_video(1, im, cNew, rNew);

    for i=1:3
        im1=fullfile(frameFolder,files(i).name());
        im2=fullfile(frameFolder,files(i+1).name());
%         [x,y,u,v] = lucas_kanade(im1,im2, 15);
        

        for i_r = 1:length(r)
            for j_c = 1:length(c)
                % i1 is the vertical x-index of the region in which cNew for this
                % point can be found
                [v1,i1] = min(abs(x-cNew(j_c)));
                % i2 is the horizontal y-index of the region in which rNew
                % for this point can be found
                [v2,i2] = min(abs(y-rNew(i_r)));
                cNew(j_c)=cNew(j_c)+v(i2,i1);
                rNew(i_r)=rNew(i_r)+u(i2,i1);
            end
        end
        write_video(i+1, im2, cNew, rNew);

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

