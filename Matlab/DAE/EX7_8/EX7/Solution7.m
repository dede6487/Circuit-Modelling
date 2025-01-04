function [y,z] = Solution7(t, y0, z0, eps)

    y = y0*(exp(t/(eps+t))+1)/2 + z0*eps*(exp(t/(eps+t))-1)/(eps+1);
    z = y0*(exp(t/(eps+t))-1)/(2*eps) + z0*(exp(((eps+1)*t)/t)+eps)/(eps+1);

end

