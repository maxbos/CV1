function save_imdb()
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
imdb=getIMDB();
modelType='lenet';
expDir=fullfile('data', ...
  sprintf('cnn_assignment-%s', modelType)) ;
imdbPath=fullfile(expDir, 'imdb-stl.mat');
mkdir(expDir) ;
save(imdbPath, '-struct', 'imdb')

end

