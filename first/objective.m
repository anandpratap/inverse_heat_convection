function [J] = objective(T, Tref, f, fref, q, dy)
    Tn = full_temperature(T, q, dy, f);
    Tnref = full_temperature(Tref, q, dy, fref);
    J = sum(sum((Tn(2,:) - Tnref(2,:)).^2));
end