function s = curve2deg(long, lat, x, y, yy11)
%% About this function: s = curve2deg(long, lat, x, y, yy11)
% curve2deg is meant to reverse the coordinate from distance in km to
% distance in degrees.  This fuction is used with the main program
% 'driver.m', which is a streamfunction solver written by Joe Schoonover.
% Inputs:
%   long = single point longitude that was used as a starting point in the
%   streamfunction solver.
%   lat = single point latitude that was used as a starting point in the
%   streamfunction solver.
%   x = the x direction distances in km output by ParticlePath
%   y = the y direction distances in km output by ParticlePath
%   yy11 = reference latitude for calculation curvature due to sphere.
%   Generally taken to be the first entry in the original mesh. ***Note:
%   Must be the same as what is used in the main function 'driver.m'
% Outputs:
%   s = streamline structure that contains s.long and s.lat which are the
%   associated longitude and latitude for one streamline.
% Written by: Elizabeth Simons
% Date: 06/20/2016


% Radius of the earth
R = 6371.0; %km

% Pre-allocate the space for s.lat, s.long
s.long = zeros(size(x));
s.lat = zeros(size(y));

%Set the starting points from the original array
s.long(1) = long;
s.lat(1) = lat;

%Find the dx, dy from the distance data
for i = 2:length(x)
    dx(i-1) = x(i) - x(i-1);
    dy(i-1) = y(i) - y(i-1);
end

%Get dlon, dlat
bot = R*cos(yy11*(pi/180));
dlon = dx./bot;
dlat = dy./R;

% Now get the lat/lon positions
for i = 2:length(dlon)+1
    s.long(i) = s.long(i-1) + (180/pi)*dlon(i-1);
    s.lat(i) = s.lat(i-1) + (180/pi)*dlat(i-1);
end






