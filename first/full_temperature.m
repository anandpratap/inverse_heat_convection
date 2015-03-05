function [T] = full_temperature(Ti, q, dy, Tb)
    [nx, ny] = size(Ti);
    nx = nx + 1;
    ny = ny + 2;
    T = zeros(nx, ny);
    T(2:nx, 2:ny-1) = Ti(1:nx-1,1:ny-2);
    T(1,:) = Tb(:);
    T(2:nx,1) = T(2:nx,2) - q*dy;
    T(2:nx,ny) = T(2:nx,ny-1) - q*dy;
end