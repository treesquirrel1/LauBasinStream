
filename = '';
%%
R = 6371;
flag = 1;

%load(filename)

x = argo.XX;
y = argo.YY;
u = argo.MeanU;
v = argo.MeanV;


[ux, uy, vx, vy, newx, newy] = StressTensor(u, v, x, y, R);
Map = EigenSolveIt(ux, uy, vx, vy, flag);