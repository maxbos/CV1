function mAP = calcMAP(classifications)

positives = 50;
fields = fieldnames(classifications);
scores = [];
mAP = struct;


% Sort classifications on descending score
for i = 1:numel(fields)
    ClassificationArr = table2array(classifications.(fields{i}));
    sz = size(ClassificationArr);
    ClassificationArr = reshape(ClassificationArr, sz(1), []);    
    ClassificationArr = sortrows(ClassificationArr,3, 'descend');
    scores = cat(3, scores, ClassificationArr);
end

% Calculate mAP
for i = 1:numel(fields)
    sum = 0;
    precision = 0;
    for j = 1:length(scores)
        if (scores(j,1,i) == scores(j,2,i))
            sum = sum + scores(j,1,i);
            precision = precision + (sum / j);
        end

    end
    mAP.(fields{i}) = precision / positives;
end