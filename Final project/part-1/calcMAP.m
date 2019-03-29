function mAP = calcMAP(classifications, positiveCount)

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

% Calculate mAP

    sum = 0.0;
    precision = 0.0;
    for j = 1:length(scores)
        if (scores(j,1,i) == 1)
            sum = sum + 1;
            precision = precision + (sum / double(j));
        end

    end
    mAP.(fields{i}) = precision / positiveCount(i);
end