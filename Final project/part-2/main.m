%% main function 


%% fine-tune cnn

[net, info, expdir] = finetune_cnn();

%% extract features and train svm

% TODO: Replace the name with the name of your fine-tuned model
nets.fine_tuned = load(fullfile(expdir, 'net-epoch-20.mat')); nets.fine_tuned = nets.fine_tuned.net;
nets.pre_trained = load(fullfile('data', 'pre_trained_model')); nets.pre_trained = nets.pre_trained.net; 
data = load(fullfile(expdir, 'imdb-stl.mat'));


%%
[featuresPre,featuresFin,labels]=train_svm(nets, data);


%%
classes = {'airplanes', 'birds', 'cars','horses', 'ships'};
length=size(labels);
length=length(1);
newLabels=[];
;for i= 1:length
    labNo=labels(i);
    newLabels=[newLabels; classes(labNo)];
end
    
%%
no_dims = 2;
initial_dims = 64;
perplexity = 30;
mappedXPre = tsne(full(featuresPre), [], no_dims, initial_dims, perplexity);
mappedXFin = tsne(full(featuresFin), [], no_dims, initial_dims, perplexity);
%%
subplot(2,1,1);
gscatter(mappedXPre(:,1), mappedXPre(:,2), newLabels);
title('Pretrained featues')

subplot(2,1,2);
gscatter(mappedXFin(:,1), mappedXFin(:,2), newLabels);
title('Fine tuned featues')

