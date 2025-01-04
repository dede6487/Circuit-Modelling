function [out] = Euler_Explicit8(eps, h, tspan, u0)
    A = [1 1; 1/eps 0];

    t = zeros(1,tspan/h + 1);
    for i = 0:(tspan/h)
        t(i+1) = i*h;
    end
    u = zeros(2, tspan/h +1);
    u(1,1) = u0(1);
    u(2,1) = u0(2);
    
    for i = 1:(tspan/h)
        u(:, i+1) = u(:, i) + h * (A*u(:,i) + [0; 1/eps]);
    end

    out = u(1,:);
end

