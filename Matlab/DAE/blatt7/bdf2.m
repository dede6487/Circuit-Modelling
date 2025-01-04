function [y] = bdf2(T, h, E, A, size, f)

n = T/h;

y = zeros(size,n+1);

options = optimoptions('fsolve','Display','none');

x0 = zeros(size,1);

%initial value using impl euler

fun = @(x) E*x - E*y(:,1) - h*(A*x+f((1)*h));
y(:,2) = fsolve(fun, x0,options);


for i=3:n
    fun = @(x) E*x - 1/3*(4*y(:,i-2)-y(:,i-1)+2*h*f((i-1)*h));
    y(:,i) = fsolve(fun, x0,options);
end

end

