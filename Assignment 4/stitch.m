function [stitched] = stitch(img1,img2)
    left = rgb2gray(imread(img1));
    right = rgb2gray(imread(img2));
    s1=size(left)
    s2=size(right)
    % Get keypoint matchings between the images to be stitched
    [fa, fb, kp_matches, kp_scores] = keypoint_matching(right, left);
    % Sort the matches
    [kp_scores_sorted, order] = sort(kp_scores);
    kp_matches_sorted = kp_matches(:,order);

    % Get the first 20 coordinate pairs
    xa = fa(1,kp_matches_sorted(1,1:20));
    xb = fb(1,kp_matches_sorted(2,1:20));
    ya = fa(2,kp_matches_sorted(1,1:20));
    yb = fb(2,kp_matches_sorted(2,1:20));

    % get transformation parameters
    transformationParams = RANSAC(kp_matches, fa, fb, 100, 10);

    % apply transformation
    tform = affine2d(transformationParams');
    T = imwarp(right, tform);
    
    
    % Get full keypoint matchings between the two images.
    [fa, fb, kp_matches, kp_scores] = keypoint_matching(T, left);
    % Sort the matches
    [kp_scores_sorted, order] = sort(kp_scores);
    kp_matches_sorted = kp_matches(:,order);
    
    % Get the first 20 coordinate pairs
    xa = fa(1,kp_matches_sorted(1,1:20))
    xb = fb(1,kp_matches_sorted(2,1:20))
    ya = fa(2,kp_matches_sorted(1,1:20));
    yb = fb(2,kp_matches_sorted(2,1:20));
    
    % sort coordinate differences
    sortedx = sort(xb-xa);
    sortedy = sort(yb-ya);

    % get median of coordinate differences to avoid values being influenced by 
    % non-matchable keypoints
    medx = round_even(median(sortedx));
    medy = round_even(median(sortedy));
    % Pad transformed image to create canvas to superimpose other image on
    [m n] = size(T)
    [a b]=size(left)
    newSize=[round(m+abs(medy)) round(medx+n)];
    T_pad=ones(newSize);
    [l b]=size(T);
    T_pad(end-l+1:end, end-b+1:end)=T;    
    
    % Superimpose image on padded image
    [l b]=size(left);
    x=[1:b];
    y=[1:l];
    T_pad(y,x) = left;
    stitched = T_pad;

    function input = round_even(input)
        % round to nearest odd integer.
        i = mod(input,2)>=1;
        input = floor(input);
        input(i) = input(i)+1;
    end

end
