function indices = classIndices(dataset)
    indices = struct;
    % Extracts features from a given dataset
    %              'airplane', 'bird', 'ship', 'horse', 'car'];
    classLabels = [1,           2,      9,      7,       3];
    [~, locationClasslabels] = ismember(dataset.y, classLabels);
    for i = 1:numel(classLabels)
        classLabel = classLabels(i);
        className = char(dataset.class_names(classLabel));
        indices.(className) = find(locationClasslabels == i);
    end
end
