clear all; clc;
ADiMat_startup;
nx = 101;
ny = 11;

Lx = 1.0;
Ly = 1.0;

xx = linspace(0.0, Lx, nx);
yy = linspace(0.0, Ly, ny);

dx = xx(2) - xx(1);
dy = yy(2) - yy(1);

[x, y] = meshgrid(xx, yy);

f = (-4.0*yy.^2 + 4.0.*yy)';
q = -0.5;
[T, A, b] = solver_steady(nx, ny, f, dx, dy, q);

dRdf = admDiffFD(@solver_steady_res, 1, T, f, dx, dy, q, admOptions('i', 2, 'd', 1));
dRdT = A'; %admDiffFD(@solver_steady_res, 1, T, f, dx, dy, q, admOptions('i', 1, 'd', 1));
% 
dJdT = admDiffFD(@objective, 1, T, zeros(size(T)), f, f, q, dy, admOptions('i', 1, 'd', 1));
delJdf = admDiffFD(@objective, 1, T, zeros(size(T)), f, f, q, dy, admOptions('i', 3, 'd', 1));
% 
obj = objective(T, zeros(size(T)), f, f, q, dy);
% 
psi = dRdT' \ (-dJdT)';
dJdf = psi'*dRdf + delJdf;


fprintf('obj: %4.16f, normgrad: %4.16f\n', obj, norm(dJdf));
Tfull = full_temperature(T, q, dy, f);
t1 = Tfull(2,1:ny);
figure(1)
plot(yy, Tfull(1,:), yy, Tfull(int16(nx/4),:),yy, Tfull(int16(nx/2),:),yy, Tfull(int16(3*nx/4),:) );

figure(3)
plot(xx, Tfull(:,int16(ny/2)));

figure(2)
size(f), size(T)
contourf(x, y, full_temperature(T, q, dy, f)', 30);
colorbar();

