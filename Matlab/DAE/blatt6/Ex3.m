M = [1 0;
     1 1];

A = [1 0;
     1 2];

f = @(t) [t; t];

y = @(t) [2*exp(t) - t - 1; exp(2*t)];

h = 1/10;

tspan = [0, 10];

k = 6;

y_start = zeros(2, k);

for i=1:k
    y_start(:, i) = y(i*h + tspan(1));
end

y_start

sol = bdfk(M, A, f, y_start, tspan, h, 1);

sol


