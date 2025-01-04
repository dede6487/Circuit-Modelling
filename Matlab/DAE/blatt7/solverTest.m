T = 10;

h = 1/10;

tspan = 1:h:T;

%first example

E1 = [1 0 0;
      0 1 0;
      0 0 0];

ode1fun = @(t,y) [0 - y(1) - y(2) + y(3);
                  0 + y(1);
                  -sin(pi*t) - y(1)];

y01 = [0; 0; 0];

options = odeset('Mass',E1,'RelTol',1e-4,'AbsTol',[1e-6 1e-10 1e-6]);

[t1,y1] = ode15s(ode1fun, tspan, y01 ,options);

%second example

E2 = [1 -1 0 0;
      -1 1 0 0;
      0 0 1 0;
      0 0 0 0];

ode2fun = @(t,y) [0 - y(4);
                  0 - y(2) - y(3);
                  0 +  y(2);
                  -sin(pi*t) + y(1)];

y02 = [0; 0; 0; 0];

options = odeset('Mass',E2,'RelTol',1e-4,'AbsTol',[1e-6 1e-10 1e-6]);

[t2,y2] = ode15s(ode2fun, tspan, y02 ,options);