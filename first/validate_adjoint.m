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

Tref = zeros(size(T));
fref = f;

obj_base = objective(T, zeros(size(T)), f, f, q, dy);
   
df = 1e-8;
fdd = zeros(ny,1);

for i=1:ny
    % increment
    f(i) = f(i) + df;

    [T, A, b] = solver_steady(nx, ny, f, dx, dy, q);
    % calc adjoint
    dJdf = calc_gradient(A, T, Tref, f, fref, q, dx, dy);
    obj = objective(T, Tref, f, fref, q, dy);
    fd = (obj - obj_base)/df;
    fd_error = abs((fd - dJdf(i)));
    fprintf('i = %i error: %e \n', i, fd_error);
    fdd(i) = fd;
    % reset
    f(i) = f(i) - df;
end
