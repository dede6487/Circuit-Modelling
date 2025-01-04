function [y] = implicitTrapez(T, h, E, A, size, f)

n = T/h;

y = zeros(size,n+1);

options = optimoptions('fsolve','Display','none');

x0 = zeros(size,1);

for i=2:n
    fun = @(x) E*x - y(:,i-1) - 1/2*h*(A*y(:,i-1)+f((i-2)*h)+A*x+f((i-1))*h);
    y(:,i) = fsolve(fun, x0,options);
end

end

