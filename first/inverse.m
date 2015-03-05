clear all;ADiMat_startup;

% initialize geometry stuff
nx = 20;
ny = 20;

Lx = 2.0;
Ly = 1.0;

xx = linspace(0.0, Lx, nx);
yy = linspace(0.0, Ly, ny);
dx = xx(2) - xx(1);
dy = yy(2) - yy(1);
[x, y] = meshgrid(xx, yy);
x = x';
y = y';

% set reference inlet condition
% 1 - Quadratic
% 2 - Square wave
% 3 - Sinosoidal + zero
fref = initialize(yy, 2);

% set heat flux
q = - 0.5;
% calculate reference condition
[Tref, ~, ~] = solver_steady(nx, ny, fref, dx, dy, q);

% set maxiter
maxiter = 200;
tol = 1e-6;

% optimizer
% gn
opts.type = 'gn';
opts.lam = 1e-3;
opts.ny = ny;

% sd
% opts.type = 'sd';
% opts.step = 1e-2;

iter = 1;

% initial f
fi = ones(size(fref));


f = fi;

while (1)
    % calc solver
    [T, A, b] = solver_steady(nx, ny, f, dx, dy, q);
    
    % calc adjoint and objective function
    dJdf = calc_gradient(A, T, Tref, f, fref, q, dx, dy);
    obj = objective(T, Tref, f, fref, q, dy);
    
    % step
    df = opt_step(dJdf, obj, opts);
    
    
    fprintf('iter: %i obj: %10.2e, normgrad: %10.2e, stepnorm: %10.2e\n', iter, obj, norm(dJdf), norm(df));
    
    % update f
    f = f + df;
    
    
    if(obj < tol || iter > maxiter)
        break;
    end
    
    iter = iter + 1;
end


% plotting stuff
figure(1)
subplot(211);
plot(yy, fref, 'x', yy, fi, yy, f)
title('Inlet Conditions')
legend('reference', 'initial', 'final');
xlabel('y');
subplot(212)
semilogy(yy, abs(fref-f));
xlabel('y');
legend('abs(reference - final)')
figure(2)
title('Solution')
subplot(311)
contourf(x, y, full_temperature(Tref, q, dy, fref), 30);
title('Reference')
colorbar();
xlabel('x');
ylabel('y');

subplot(312)
contourf(x, y, full_temperature(T, q, dy, f), 30);
title('Final')
colorbar();
xlabel('x');
ylabel('y');

subplot(313)
contourf(x, y, log10(abs(full_temperature(Tref, q, dy, fref) - full_temperature(T, q, dy, f))), 30);
title('log10(error)')
colorbar();
xlabel('x');
ylabel('y');

figure(3)
Tfull = full_temperature(Tref, q, dy, fref);
plot(yy, Tfull(1,:), yy, Tfull(int16(nx/4),:),yy, Tfull(int16(nx/2),:),yy, Tfull(int16(3*nx/4),:) );

figure(4)
plot(xx, Tfull(:,int16(ny/2)));


