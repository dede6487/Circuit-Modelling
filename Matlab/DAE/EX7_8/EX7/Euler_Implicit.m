function [u] = Euler_Implicit(f, h, tspan, u0)
    t = zeros(1,tspan/h + 1);
    for i = 0:(tspan/h)
        t(i+1) = i*h;
    end
    u = zeros(2, tspan/h +1);
    u(1,1) = u0(1);
    u(2,1) = u0(2);
    
    for i = 1:(tspan/h)
        u(:, i+1) = -inv((h * f - eye(2)))*u(:, i);
    end
end
