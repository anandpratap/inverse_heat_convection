function [f] = initialize(y, type)
    ny = length(y);
    f = zeros(ny,1);
    if (type == 1)
        % quadratic
        f = (-4.0*y.^2 + 4.0.*y)';
    elseif(type == 2)
        % square
        for j=1:ny
           if(y(j) > 0.25 && y(j) < 0.75)
               f(j) = 1.0;
           end
        end
    elseif(type == 3)
        for j=1:ny
            if(y(j) > 0.25 && y(j) < 0.75)
               f(j) = sin(y(j)*pi/45.0);
            end
        end
    else
        error('Inlet condition not implemented')
    end
   
    
end