function [x0KM, y0KM, xKM, yKM, dx, dy] = deg2curve(xx, yy, x, y, x0, y0, R)
%% About deg2curve:
% deg2curve is a function called by driver.m.  The purpose of this function
% is to convert signed degree latitude and longitude into km locations from
% an origin dictated by the start points x0,y0.  Curvature of the earth is
% taken into consideration during the conversion and therefore the radius R
% should be fed in.
% Input:
%   xx, yy = mesh corresponding to the region (lat/lon) of interest
%   x, y = xx, yy with singlton dimensions removed. this is done in the
%   main driver program.
%   x0,y0 = array (nx1), of starting lon/lats
%   R = radius of the earth in KM 
% Output:
%   x0KM, y0KM = starting points on the KM grid
%   xKM, yKM = x grid and y grid for use in streamline calculation
% Written by: Joe Schoonover
% Date:
% Modified: 06/22/2016 E. Simons
  % Set the size of the KM grid based off of the size of the original mesh
  nX = size(xx,1);
  nY = size(xx,2);
  xKM = zeros( nX, 1 );
  yKM = zeros( nY, 1 );
  
  % Convert the distance difference in lon/lat degrees to scalar quantity  
  dLon = pi*(x(2) - x(1))/180.0;
  dLat = pi*(y(2) - y(1))/180.0;
  % Calculate the km distance difference using earth curvature and scalar
  % above. dx requires a reference latitude.
  dx = R*cos( yy(1,1)*pi/180.0 )*dLon;
  dy = R*dLat;
  % Fill in the xKm/yKM grids
  for i = 2:nX
     xKM(i) = xKM(i-1) + dx;
  end
  
  for i = 2:nY
     yKM(i) = yKM(i-1) + dy;
  end
  
  % Find the starting points on the KM-grid
  x0KM = zeros(size(x0));
  y0KM = zeros(size(y0));
  % Fill in the KM starting points using the original deg signed starting
  % points
  for i = 1:length(x0)
     x0KM(i) = interp1( x, xKM, x0(i) );
     y0KM(i) = interp1( y, yKM, y0(i) );
  end
  