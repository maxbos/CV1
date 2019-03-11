%% Coordinates In Image Check
% Checks if point (x,y) falls inside image domain.
function boolean = inImage(s, x, y)
    yMax = s(1);
    xMax = s(2);
    boolean = (x <= xMax) && (y <= yMax) && (x >= 1) && (y >= 1);
end