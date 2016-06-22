%% driver.m
%
% This matlab script manages the calls to the path integrator in order to calculate particle trajectories
% associated with the velocity field stored in "argo.mat" .
%
% An approximate cartesian grid is built using the central latitude to approximate the spacing
% in the zonal direction.
%
% At the top you can specify a
%
%   x1,x2,y1,y2 : an array of starting longitudes and latitudes (respectively)
%   ds          : the increment in the arclength used to calculate the particle path - smaller increments
%                 result in more data for a streamline (in km)
%   L           : the length of the streamlines (in km)
%   flag        : currently (06/21/2016) 1-3, array builders for x0, y0 based off of
%                 x1,x2,y1,y2
%   m           : degree spacing between points in the arrays
%   N           : number of points between start and end for sloping lines
%
%   Function calls:
%         ParticlePath_WRK3.m  (Joe Schoonover)
%         curve2deg.m          (E. Simons)
%         LineFind.m           (E. Simons)
%         driverx0y0.m         (E. Simons)
%         deg2curve.m          (Joe Schoonover, E. Simons)
%   Written by: Joseph Schoonover
%   Date:
%   Modified: 06/20/2016 - E. Simons
%   Modified: 06/21/2016 - E. Simons
%   Modified: 06/22/2016 - E. Simons
%% Setting initial bounds
  % Set the file name for access
  filename = 'argo.mat';
  % Set constants
  R = 6371.0;   % Radius of the earth (in km)
  ds = 10.0;    % Arc length increment
  L = 1000.0;   % Streamline length
  
  % Set flag
  flag = 1;     % Flag for x,y arrays for streamline calcs
                % See next partition for information on each flag
  
  % Set intial bounds
  x1 = 188;
  y1 = -20;
  x2 = 182;
  y2 = -10;
  m = 0.25;
  N = 100;      % Set spacing for arrays when flag = 2
%% Create the arrays for x0 and y0
% Uses function driverx0y0.m for x0,y0 for 3 different cases
% Flag 1:  Straight line north-south at 188 long stretching from 10N to
% 10S --> y0 = -10:spacing:10; x0 = 188*ones(size(y0));
% Flag 2:  Sloped line between two coordinate sets --> Use LineFind.m to
% get array for x0, y0.
% Flag 3:  Boxed area/ region of interest, something more substantial
% than just 1 line --> x = 175:1:190; y = -37:1:-12; 
% [yy, xx] = meshgrid(y,x); xxuse = reshape(xx,1,[]); yyuse = reshape(yy,
% [], 1) ****The (-,[],1) designation give an array by row, switch if array
% by column is needed.
  
  [x0,y0] = driverx0y0(flag, x1, y1, x2, y2, m, N);
  

%% Load the averaged data and parse out the individual structure points

load(filename) 

u = argo.MeanU;
v = argo.MeanV;
xx = argo.XX;
yy = argo.YY;

x = squeeze(xx(:,1));
y = squeeze(yy(1,:));

%% Convert from deg to KM and find the starting points
[x0KM, y0KM, xKM, yKM, dx, dy] = deg2curve(xx, yy, x, y, x0, y0, R);
   
%% Streamline 
% Loop over the starting points and perform the streamline integration.
  for i = 1:length(x0)
                                        %starting X, starting Y, x Grid, y Grid, zonal velocity, meridional velocity
     streamline(i) = ParticlePath_WRK3( x0KM(i), y0KM(i), xKM, yKM, u, v, ds, L, dx, dy );
  end
  clear i
%% Change back into lat/lon designations
for i = 1:length(x0)
    sline = curve2deg(x0(i), y0(i),streamline(i).x, streamline(i).y, yy(1,1));
    streamline(i).lon = sline.long;
    streamline(i).lat = sline.lat;
    clear sline
end
clear i
clear y0KM x0KM yKM xKM y x u v L ds nX nY dLat dLon dx dy fspec R
pack 
%% Plot figure using km distance in x & y

   figure; hold on
   
   for i = 1:length(x0)
      plot(streamline(i).x, streamline(i).y, 'LineWidth',2)
      xlabel('x (km)','FontSize',16, 'Fontweight','Bold')
      ylabel('y (km)','FontSize',16, 'Fontweight','Bold')
      set(gca, 'FontSize', 16, 'Fontweight', 'Bold')
   end
