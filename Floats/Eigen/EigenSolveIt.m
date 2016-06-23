function [Map] = EigenSolveIt(ux, uy, vx, vy, flag)

[nx, ny] = size(ux);
D = zeros(nx,ny);
T = zeros(nx, ny);

%% Calculate the determinate and the trace of A
% D = ux*vy - uy*vx
% T = ux + vy
for j = 1:ny
    for i = 1:nx
        D(i,j) = ux(i,j)*vy(i,j) - uy(i,j)*vx(i,j);
        T(i,j) = ux(i,j) + vy(i,j);
    end
end
clear i j
%% EigenValue information
Map = zeros(nx,ny);
if flag == 1  % Looking for convergence/divergence in spirals or nodes
    for j = 1:ny
        for i = 1:nx
            if D(i,j)>0
                if T(i,j)>0
                    Map(i,j) = -1;
                elseif T(i,j)<0
                    Map(i,j) = 1;
                else
                    Map(i,j) = 0;
                end
            end
        end
    end
   
elseif flag == 2 % Looking for saddlepoints
    for j = 1:ny
        for i = 1:nx
            if D(i,j)<0
                if T(i,j)<0
                    Map(i,j) = 1;
                elseif T(i,j)>0
                    Map(i,j) = -1;
                else
                    Map(i,j) = 0;
                end
            end
        end
    end
end




