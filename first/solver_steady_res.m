function [R] = solver_steady_res(Tf, f, dx, dy, q)
    [nx, ny] = size(Tf);
    nx = nx + 1;
    ny = ny + 2;
    [A, b] = calc_Ab(nx, ny, dx, dy, f, q);
    Tf = reshape(Tf, (nx-1)*(ny-2), 1);
    R = A*Tf - b;
end