function [x,y] = LineFind(x1, y1, x2, y2, N)
%% LineFind
% Find the linear points between two locations or (x,y) groupings.  Use the
% simple line formula: y = mx + b --> y(i) = m*(x(2) - x(1)) + y(1)
% Input:
%   N = Set the number of points wanted. Note that more points = smoother 
%   line, but more computing time.  Usually N = 100 is high enough
%   resolution to cover most things (bathymetry data)
%   (x1,y1) = first lon, lat pair to pull the line from
%   (x2,y2) = second lon,lat pair to pull the line to
% Output:
%   x = array of longitudinal/zonal positions between the points specified
%   by x1,x2 including x1, x2
%   y = array of latitudinal/meridional positions between the points
%   specified by y1, y2 including y1, y2.
% Written by: Elizabeth Simons
% Date: 06/21/2016
%%
% N = 100;
%% Input the (x,y) grouping
% x1 = 188.0;
% y1 = -14.5;

% x2 = 180;
% y2 = -36.5;

%% Find the slope
m = (y2-y1)/(x2-x1);
%% Get the points in between
j = (x2-x1)/N; %Increments to get the wanted number of points
x = x1:j:x2;
y = m.*x +y1;
yb = y(1) - y1;
y = y - yb;
if y(1) == y1
    disp('Good')
else
    disp('y = mx + believe it dont work!')
end