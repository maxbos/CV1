function acc = calcAcc(classifications, targetLabels)
    fields = fieldnames(classifications);
    nSamples = length(table2array(classifications.(fields{1})));
    good = 0;
    
    for i = 1:nSamples
        highestDecisionVal = -Inf;
        predictedClass = '';
        for j = 1:numel(fields)
            data = classifications.(fields{j});
            decisionValue = data(i, {'DecisionValues'});
            decisionValue = double(table2array(decisionValue));
            if decisionValue > highestDecisionVal
                highestDecisionVal = decisionValue;
                predictedClass = j;
            end
        end
        
        if predictedClass == targetLabels(i)
            good = good + 1;
        end
    end
    acc = double(good)/nSamples;
end