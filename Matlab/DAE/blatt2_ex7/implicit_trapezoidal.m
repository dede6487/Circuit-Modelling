function [out] = implicit_trapezoidal(y_n, f, h, t_n)
%output: y_n+1
%input y_n, f, h
options = optimset('Display','off');

fun = @(y) (y_n + h/2 * (f(t_n, y_n) + f(t_n + h, y)) - y);
out = fsolve(fun, 0, options);
end

