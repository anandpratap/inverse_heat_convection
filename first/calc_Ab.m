function [A, b] = calc_Ab(nx, ny, dx, dy, f, q)
    n = (nx-1)*(ny-2);
    A = zeros(n, n);
    b = zeros(n, 1);
    for i=2:nx
        for j=2:ny-1
            i_idx =(j-2)*(nx-1) + i-1;
            y = (j-1)*dy;
            u = y*(1-y)*6.0;
            if(i == 2)
                
                if(j == 2)
                    A(i_idx, i_idx) = -(2/3.0/dy/dy + u/4.0/dx);
                    A(i_idx, i_idx+(nx-1)) = 2.0/3.0/dy/dy;
                    b(i_idx) = 2.0/3.0*q/dy - u*f(j)/4.0/dx;
                elseif(j == ny-1)
                    A(i_idx, i_idx) = -(2.0/3.0/dy/dy + u/4.0/dx);
                    A(i_idx, i_idx-(nx-1)) = 2.0/3.0/dy/dy;
                    b(i_idx) = 2.0/3.0*q/dy - u*f(j)/4.0/dx;
                else
                    A(i_idx, i_idx) = -(2.0/dy/dy + u/4.0/dx);
                    A(i_idx, i_idx-(nx-1)) = 1/dy/dy;
                    A(i_idx, i_idx+(nx-1)) = 1/dy/dy;
                    b(i_idx) = -u*f(j)/4.0/dx;
                end
                
            else
                
                if(j == 2)
                    A(i_idx, i_idx) = -(2/3.0/dy/dy + u/4.0/dx);
                    A(i_idx, i_idx+(nx-1)) = 2.0/3.0/dy/dy;
                    A(i_idx, i_idx-1) = u/4.0/dx;
                    b(i_idx) = 2.0/3.0*q/dy;
                elseif(j == ny-1)
                    A(i_idx, i_idx) = -(2.0/3.0/dy/dy + u/4.0/dx);
                    A(i_idx, i_idx-(nx-1)) = 2.0/3.0/dy/dy;
                    A(i_idx, i_idx-1) = u/4.0/dx;
                    b(i_idx) = 2.0/3.0*q/dy;
                else
                    A(i_idx, i_idx) = -(2.0/dy/dy + u/4.0/dx);
                    A(i_idx, i_idx-(nx-1)) = 1/dy/dy;
                    A(i_idx, i_idx+(nx-1)) = 1/dy/dy;
                    A(i_idx, i_idx-1) = u/4.0/dx;
                end
                
            end
            
        end
    end
    
end