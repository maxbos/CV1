function [acc, prec] = calcAccuracy(data)
    actuals = table2array(data(:, {'TrueLabel'}));
    predicted = table2array(data(:, {'PredictedLabel'}));
    shouldbe = 0;
    good = 0;
    tp = 0;
    fp = 0;
    
    for i = 1:length(actuals)
        if (actuals(i) == predicted(i))
            good = good + 1;
        end
        if predicted(i) && (actuals(i) == predicted(i))
            good = good + 1;
            tp = tp + 1;
        end
        if predicted(i)
            fp = fp +1;
        end
        if actuals(i)
            shouldbe = shouldbe + 1;
        end
    end

    acc = double(good)/length(actuals);
    prec = tp/(tp+fp);
end