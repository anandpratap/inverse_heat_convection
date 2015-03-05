function [Tf, A, b] = solver_steady(nx, ny, f, dx, dy, q)
    % AT = b
    [A, b] = calc_Ab(nx, ny, dx, dy, f, q);
    Tn = A \ b;
    Tf = reshape(Tn, nx-1, ny-2);
end