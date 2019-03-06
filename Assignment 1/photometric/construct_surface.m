function [ height_map ] = construct_surface( p, q, path_type )
    %CONSTRUCT_SURFACE construct the surface function represented as height_map
    %   p : measures value of df / dx
    %   q : measures value of df / dy
    %   path_type: type of path to construct height_map, either 'column',
    %   'row', or 'average'
    %   height_map: the reconstructed surface

    if nargin == 2
        path_type = 'column';
    end

    [h, w] = size(p);
    height_map = zeros(h, w);

    function [out_height_map] = path_column(in_height_map)
        out_height_map = in_height_map;
        % top left corner of height_map is zero
        % for each pixel in the left column of height_map
        %   height_value = previous_height_value + corresponding_q_value
        for i = 2:h
            height_value = out_height_map(i-1, 1) + q(i, 1);
            out_height_map(i, 1) = height_value;
        end
        
        % for each row
        %   for each element of the row except for leftmost
        %       height_value = previous_height_value + corresponding_p_value
        for i = 1:h
            for j = 2:w
                height_value = out_height_map(i, j-1) + p(i, j);
                out_height_map(i, j) = height_value;
            end
        end
    end

    function out_height_map = path_row(in_height_map)
        out_height_map = in_height_map;
        % top left corner of height_map is zero
        % for each pixel in the top row of height_map
        %   height_value = previous_height_value + corresponding_p_value
        for j = 2:w
            height_value = out_height_map(j-1, 1) + p(1, j);
            out_height_map(1, j) = height_value;
        end
 
        % for each column
        %   for each element of the column except for topmost
        %       height_value = previous_height_value + corresponding_q_value
        for j = 1:w
            for i = 2:h
                height_value = out_height_map(i-1, j) + q(i, j);
                out_height_map(i, j) = height_value;
            end
        end
    end

    switch path_type
        case 'column'
            height_map = path_column(height_map);

        case 'row'
            height_map = path_row(height_map);

        case 'average'
            height_map_column = path_column(height_map);
            height_map_row = path_row(height_map);
            height_map = height_map_column .* 0.5 + height_map_row .* 0.5;
    end


end

