% TO DO: Plot histograms of different photos
% compare cluster sizes of 400, 1000 and 4000
% Evaluation plots 

clear
close all

%% Cluster size: 400
demo(["gray", "dense"], 1000, 400, 800*5)
demo(["rgb", "dense"], 1000, 400, 800*5)
demo(["opponent", "dense"], 1000, 400, 800*5)

%% Cluster size: 1000
demo(["gray", "dense"], 1000, 1000, 800*5)
demo(["rgb", "dense"], 1000, 1000, 800*5)
demo(["opponent", "dense"], 1000, 1000, 800*5)

%% Cluster size: 4000
demo(["gray", "dense"], 1000, 4000, 800*5)
demo(["rgb", "dense"], 1000, 4000, 800*5)
demo(["opponent", "dense"], 1000, 4000, 800*5)
