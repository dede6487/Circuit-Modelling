tspan = [0;10]; %change that
h = 0.5;

%example 1

%system matrices
A1 = [0 0 0;
      0 1 0;
      0 0 0];

B1 = [1 1 0;
      1 1 -1;
      0 -1 0];

f1 = @(t) [0 0 1]';

%consistent initial values (need to calculate them, below are not checked)

y0 = [0 0 1]';

%BDF1

y1_BDF1 = BDFk(A1, B1, f1, y0, tspan, h, 1);

%BDF2

y1_BDF2 = BDFk(A1, B1, f1, y0, tspan, h, 2);

%BDF3

y1_BDF3 = BDFk(A1, B1, f1, y0, tspan, h, 3);