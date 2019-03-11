% Returns a value closest to a specified range if specified
% current value falls outside the range.
function nearest = valueInRange(minVal, maxVal, value)
    nearest = min(max(value, minVal), maxVal);
end