
M = [1 0;
     1 1];

A = [1 0;
     1 2];

f = @(t) [t; t];

y0 = [1,1];

h = 1/10;

tspan = [0, 10];

test = startingValuesbdf(y0, h, f, M, A);