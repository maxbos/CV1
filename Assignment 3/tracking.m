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

 

for i=1:length(files)-1
    im1=fullfile(frameFolder,files(i).name());
    im2=fullfile(frameFolder,files(i+1).name());
    [y,x,u,v] = lucas_kanade(im1,im2, 15);
    
    for i_r = 1:length(r)
        for j_c = 1:length(c)
            [v1,i1] = min(abs(x-cNew(j_c)));
            [v2,i2] = min(abs(y-rNew(i_r)));
            cNew(j_c)=cNew(j_c)+u(i2,i1);
            rNew(i_r)=rNew(i_r)+v(i2,i1);
        end
    end
    figure(i);
    imshow(im2);
    %plot(cNew,rNew);
%     fig=gcf;
    hold on;
    plot(cNew,rNew,'r.');
    hold off;
  %read the next image
   writeVideo(video,getframe(gcf)); %write the image to file

end
close(video); %close the file

