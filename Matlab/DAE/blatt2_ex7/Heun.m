function [y] = Heun(y_n, f, h, t_n)
%output: y_n+1
%input y_n, f, h
y = y_n + h/2 * (f(t_n, y_n) + f(t_n+h, y_n+h*f(t_n,y_n)));
end

