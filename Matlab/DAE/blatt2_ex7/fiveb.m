function [out] = fiveb(y_n, f, h, t_n)
%output: y_n+1
%input y_n, f, h
options = optimset('Display','off');

fun = @(g) [(y_n + h*( 5/12 * f(t_n + 1/3 * h, g(1)) + 3/4 * f(t_n + h, g(2)))) - g(1); (y_n + h*( -1/12 * f(t_n + 1/3 * h, g(1)) + 1/4 * f(t_n + h, g(2)))) - g(2)];

sol = fsolve(fun, [0; 0], options);

out = y_n + h*(3/4 * f(t_n + 1/3 * h, sol(1)) + 1/4 * f(t_n+h, sol(2)));
end