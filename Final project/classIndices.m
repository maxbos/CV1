function indices = classIndices(dataset)
    indices = struct;
    % Extracts features from a given dataset
    %              'airplane', 'bird', 'ship', 'horse', 'car'];
    classlabels = [1,           2,      9,      7,       3];
    [~, locationClasslabels] = ismember(dataset.y, classlabels);
    indices.airplane = find(locationClasslabels == 1);
    indices.bird = find(locationClasslabels == 2);
    indices.ship = find(locationClasslabels == 3);
    indices.horse = find(locationClasslabels == 4);
    indices.car = find(locationClasslabels == 5);
end
