%% -------------------------------------------------------------------------

function imdb = getIMDB()
% -------------------------------------------------------------------------
% Preapre the imdb structure, returns image data with mean image subtracted
classes = {'airplanes', 'birds', 'ships', 'horses', 'cars'};
splits = {'train', 'test'};
data=[];
labels=[];
sets=[];
noSplits=size(splits)
for no = 1:noSplits(1)
    spl=char(splits(no));
    dataFirst= open(strcat('data/',spl,'.mat'));
    length=size(dataFirst.X);
    length=length(1);
    X=dataFirst.X;
    X=reshape(X,length,96,96,3);
    resImages=[]
    i=0;
    for noIm = 1:length
        
        imag=X(noIm,:,:,:);
        size(squeeze(imag));
        i=i+1
        newIm=imresize(squeeze(imag),[32 32]);
        newIm=reshape(newIm,1,32,32,3);
        resImages=[resImages;newIm];
    end
    size(X);
    Y=dataFirst.y;
    data=[data;resImages];
    size(data)
    labels=[labels;Y];
    
    if strcmp(spl,'train')
        arr=ones(length,1);
    else
        arr=ones(length,1)*2;
    end
 
    sets=[sets;arr];
    
end
length=size(data);
data=reshape(data,32,32,3,length(1));


%% TODO: Implement your loop here, to create the data structure described in the assignment


%% Use train.mat and test.mat we provided from STL-10 to fill in necessary data members for training below
%% You will need to, in a loop function,  1) read the image, 2) resize the image to (32,32,3), 3) read the label of that image

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