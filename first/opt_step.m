function [df] = opt_step(dJdf, obj, opts)
    if(strcmp(opts.type,'gn'))
        G = dJdf'*dJdf + opts.lam*eye(opts.ny);
        RHS = -dJdf'*obj;
        df = G \ RHS;
    elseif(strcmp(opts.type,'sd'))
        df = -opts.step*dJdf';
    else
        error('Optimizer not implemented')
    end
end