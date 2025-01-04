function [y] = impEuler(T, h, E, A, size, f)
    
n = T/h;

y = zeros(size,n+1);

x0 = zeros(size,1);

options = optimoptions('fsolve','Display','none');

for i=2:n
    fun = @(x) E*x - E*y(:,i-1) - h*(A*x+f((i-2)*h));
    y(:,i) = fsolve(fun, x0,options);
end

end

