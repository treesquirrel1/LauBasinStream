function [ux, uy, vx, vy, newx, newy] = StressTensor(u, v, x, y, R)
%% StressTensor
%Centered difference

% Input:
%   u,v = matrices of zonal and meridional velocities in m/s
%   x,y = meshgrid data of zonal and meridional locations
%   R = radius of the earth in km. gets converted to m in the code to keep
%   the units happy in the tensor calculation
% Output:
%   ux, vx = derivative of u/v wrt x
%   uy, vy = derivative of u/v wrt y
%
% Written by: E. Simons
% Date: 06/22/2016
%% Set counters and pre-allocate matrix arrays
[nx, ny] = size(u);
ux = zeros(nx-2, ny-2);
uy = zeros(nx-2, ny-2);
vx = zeros(nx-2, ny-2);
vy = zeros(nx-2, ny-2);
% Change R from km to m
R = R*10^3;
% Calclate dy ahead of the loop since it is just a constant
dy = (pi/180)*0.5*R; %0.5 comes from the 0.25 deg spacing x 2 since using centered difference
for j = 2:ny-1
    for i = 2:nx-1
        % Find the 'center' reference lat.  Update with meridional movement
        yc = y(1,j);
        % Get dx from the reference lat and constant dy
        dx = dy*cos(yc);
        % find ux uy vx vy
        ux(i-1,j-1) = (u(i+1, j) - u(i-1, j))/dx;
        uy(i-1,j-1) = (u(i, j+1) - u(i, j-1))/dy;
        vx(i-1,j-1) = (v(i+1, j) - v(i-1, j))/dx;
        vy(i-1,j-1) = (v(i, j+1) - v(i, j-1))/dy;
    end
end
% Make a new mesh that has the correct positions and dimensions of uxuyvxvy
newx = x(2:end-1, 2:end-1);
newy = y(2:end-1, 2:end-1);
        