function [x0, y0] = driverx0y0(flag, x1, y1, x2, y2, m, N)
%% x0y0
% From the flag and input data arrays are made for starting positions for
% use with driver.m.  
% Input:
%   flag = 1, 2, 3: straight line, sloped line, unrolled matrix
%   x1,y1 = starting pair of positions
%   x2,y2 = ending pair of positions
%   m = degree spacing between points in the array
%   N = number of points between start and end for sloping line
% Output:
%   x0,y0 = starting array for streamline calculations
% Written by: Elizabeth Simons
% Date: 06/21/2016


if flag == 1
    if isequal(y1,y2) == 1
        if x1>x2 == 1
            x0 = x2:m:x1;
        else
            x0 = x1:m:x2;
        end
        y0 = y1*ones(size(x0));
    elseif isequal(x1,x2) == 1
        if y1>y2 == 1
            y0 = y2:m:y1;
        else
            y0 = y1:m:y2;
        end
        x0 = x1*ones(size(y0));
    else
        disp('Error in function: driverx0y0')
        disp('Check your flag or your pairs, this is not a straight line...')
        return
    end
    
elseif flag == 2
    [x0,y0] = LineFind(x1,y1,x2,y2,N);
    
elseif flag == 3
    if x1>x2 == 1
        x = x2:m:x1;
    else
        x = x1:m:x2;
    end
    if y1>y2 == 1
        y = y2:m:y1;
    else
        y = y1:m:y2;
    end
    [yy,xx] = meshgrid(y, x);
    x0 = reshape(xx, [], 1);
    y0 = reshape(yy, [], 1);
end
    
    