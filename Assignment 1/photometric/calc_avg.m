function [avg] = calc_avg(one, two, three)
    one(isnan(one)) = 0;
    two(isnan(two)) = 0;
    three(isnan(three)) = 0;
    avg = (one + two + three) ./ 3;
end