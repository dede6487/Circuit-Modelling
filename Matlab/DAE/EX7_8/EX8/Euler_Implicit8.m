function [u] = Euler_Implicit8(eps, h, tspan, u0)
    A = [1 1; 1/eps 0];

    t = zeros(1,tspan/h + 1);
    for i = 0:(tspan/h)
        t(i+1) = i*h;
    end
    u = zeros(2, tspan/h +1);
    u(1,1) = u0(1);
    u(2,1) = u0(2);
    
    for i = 1:(tspan/h)
        u(:, i+1) = inv((h*A-eye(2)))*(-u(:, i)-h*[0; 1/eps]);
    end
end
