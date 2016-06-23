function [Map, newx, newy] = EigenFlow(u, v, x, y, flag)
%%
R = 6371;
%flag = 1;
%x = argo.XX;
%y = argo.YY;
%u = argo.MeanU;
%v = argo.MeanV;


[ux, uy, vx, vy, newx, newy] = StressTensor(u, v, x, y, R);
Map = EigenSolveIt(ux, uy, vx, vy, flag);