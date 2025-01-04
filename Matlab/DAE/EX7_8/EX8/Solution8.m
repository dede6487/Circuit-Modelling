function [y] = Solution8(t, eps)

    y = (exp(-t)*(-exp(t)*(4 + eps) + exp(((1/2) *(3 - 1/sqrt(eps/(4 + eps))) *t)) *(4 + eps - sqrt(eps) *sqrt(4 + eps)) + exp(1/2 *(3 + 1/sqrt(eps/(4 + eps)))* t)* (4 + eps + sqrt(eps)* sqrt(4 + eps))))/(4 + eps);

end

