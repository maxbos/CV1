function [transformation] = RANSAC(matches)
%
%
    N_repeats = 100;
    P_matches = 10;
    
    for n = 1:N_repeats
        matches_subset = datasample(matches, P_matches);
        for match = 1:P_matches
            og_p = match(1);
            nw_p = match(2);
            A = [og_p(1), og_p(2), 0 0, 1, 0;
                 0, 0 og_p(1), og_p(2), 0, 1];
            b = [nw_p(1); nw_p(2)];
            x = pinv(A)*b;
        end
    end
end