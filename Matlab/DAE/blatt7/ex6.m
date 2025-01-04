T = 10;

h = 1/2;

t = 0:h:T;

% first example

E1 = [1 0 0;
      0 1 0;
      0 0 0];

A1 = [1 1 -1;
      -1 0 0;
      1 0 0];

f1 = @(t) [0 0 -sin(pi*t)]';

y_e1 = impEuler(T, h, E1, A1, 3, f1);

y_imtr1 = implicitTrapez(T, h, E1, A1, 3, f1);

y_bdf21 = bdf2(T, h, E1, A1, 3, f1);

figure(1);clf;
plot(t, y_e1, 'DisplayName', "Euler")

figure(2);clf;
plot(t, y_imtr1, 'DisplayName', "Trapez")

figure(3);clf;
plot(t, y_bdf21, 'DisplayName', "Trapez")

%second example

E2 = [1 -1 0 0;
      -1 1 0 0;
      0 0 1 0;
      0 0 0 0];

A2 = [0 0 0 -1;
      0 1 1 0;
      0 -1 1 0;
      1 0 0 0];

f2 = @(t) [0 0 0 -sin(pi*t)]';

y_e2 = impEuler(T, h, E2, A2, 4, f2);

y_imtr2 = implicitTrapez(T, h, E2, A2, 4, f2);

y_bdf22 = bdf2(T, h, E2, A2, 4, f2);

figure(4);clf;
plot(t, y_e2, 'DisplayName', "Euler")

figure(5);clf;
plot(t, y_imtr2, 'DisplayName', "Trapez")

figure(6);clf;
plot(t, y_bdf22, 'DisplayName', "Trapez")