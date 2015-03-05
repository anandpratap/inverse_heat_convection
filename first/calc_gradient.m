function [grad] = calc_gradient(A, T, Tref, f, fref, q, dx, dy)
    dRdT = A;
    dJdT = admDiffFD(@objective, 1, T, Tref, f, fref, q, dy, admOptions('i', 1, 'd', 1));
    psi = dRdT' \ (-dJdT)';
    dRdf = admDiffFD(@solver_steady_res, 1, T, f, dx, dy, q, admOptions('i', 2, 'd', 1));
    delJdf = admDiffFD(@objective, 1, T, Tref, f, fref, q, dy, admOptions('i', 3, 'd', 1));
    grad = psi'*dRdf + delJdf; 
end