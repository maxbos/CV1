function [net, info, expdir] = finetune_cnn(varargin)

%% Define options
run(fullfile(fileparts(mfilename('fullpath')), ...
     '..', '..', '..', 'matconvnet-1.0-beta23', 'matlab', 'vl_setupnn.m'));

opts.modelType = 'lenet' ;
[opts, varargin] = vl_argparse(opts, varargin) ;

opts.expDir = fullfile('data', ...
  sprintf('cnn_assignment-%s', opts.modelType)) ;
[opts, varargin] = vl_argparse(opts, varargin) ;

opts.dataDir = './data/' ;
opts.imdbPath = fullfile(opts.expDir, 'imdb-stl.mat');
opts.whitenData = true ;
opts.contrastNormalization = true ;
opts.networkType = 'simplenn' ;
opts.train = struct() ;
opts = vl_argparse(opts, varargin) ;
if ~isfield(opts.train, 'gpus'), opts.train.gpus = []; end;

opts.train.gpus = [];



%% update model

net = update_model();

if exist(opts.imdbPath, 'file')
  imdb = load(opts.imdbPath) ;
else
  imdb = getIMDB() ;
  mkdir(opts.expDir) ;
  save(opts.imdbPath, '-struct', 'imdb') ;
end

%%
net.meta.classes.name = imdb.meta.classes(:)' ;

% -------------------------------------------------------------------------
%                                                                     Train
% -------------------------------------------------------------------------

trainfn = @cnn_train ;
[net, info] = trainfn(net, imdb, getBatch(opts), ...
  'expDir', opts.expDir, ...
  net.meta.trainOpts, ...
  opts.train, ...
  'val', find(imdb.images.set == 2)) ;

expdir = opts.expDir;
end
% -------------------------------------------------------------------------
function fn = getBatch(opts)
% -------------------------------------------------------------------------
switch lower(opts.networkType)
  case 'simplenn'
    fn = @(x,y) getSimpleNNBatch(x,y) ;
  case 'dagnn'
    bopts = struct('numGpus', numel(opts.train.gpus)) ;
    fn = @(x,y) getDagNNBatch(bopts,x,y) ;
end

end

function [images, labels] = getSimpleNNBatch(imdb, batch)
% -------------------------------------------------------------------------
images = single(imdb.images.data(:,:,:,batch)) ;
labels = single(imdb.images.labels(1,batch)) ;
if rand > 0.5, images=fliplr(images) ; end

end

%% -------------------------------------------------------------------------

function imdb = getIMDB()
% -------------------------------------------------------------------------
% Prepare the imdb structure, returns image data with mean image subtracted
classes = {'airplanes', 'birds', 'ships', 'horses', 'cars'};
classLabels = [1,          2,      9,      7,       3];
splits = {'train', 'test'};
data=[];
labels=[];
sets=[];
for no = 1:size(splits,2)
    split=char(splits(no));
    dataset= open(strcat('data/',split,'.mat'));
    [~, idx] = ismember(dataset.y, classLabels);
    dataset.X = dataset.X(find(idx), :);
    dataset.y = dataset.y(find(idx), :);
    length=size(dataset.X, 1);
    X=reshape(dataset.X,length,96,96,3);
    resImages=[];
    i=0;
    for noIm = 1:length
        imag=X(noIm,:,:,:);
        i=i+1
        newIm=imresize(squeeze(imag),[32 32]);
        resImages=cat(4,resImages,newIm);
    end
    Y=dataset.y;
    Y(Y == 7) = 4;
    Y(Y == 9) = 5;
    data=cat(4,data,resImages);
    labels=[labels;Y];
    
    if strcmp(split,'train')
        arr=ones(length,1);
    else
        arr=ones(length,1)*2;
    end
 
    sets=[sets;arr];
    
end
length=size(data);
labels=labels.';
sets=sets.';
%%
% subtract mean
dataMean = mean(data(:, :, :, sets == 1), 4);
data = bsxfun(@minus, double(data), double(dataMean));

imdb.images.data = data ;
imdb.images.labels = single(labels) ;
imdb.images.set = sets;
imdb.meta.sets = {'train', 'val'} ;
imdb.meta.classes = classes;

perm = randperm(numel(imdb.images.labels));
imdb.images.data = imdb.images.data(:,:,:, perm);
imdb.images.labels = imdb.images.labels(perm);
imdb.images.set = imdb.images.set(perm);
end


