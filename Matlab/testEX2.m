tspan = [0;8*pi];
h = 0.1;

%example 1

%system matrices
A1 = [1 0
      0 1];

B1 = [0 -1;
      1 0];

f1 = @(t) [0 0]';

%consistent initial values (arbitrary since ODE)

y0 = [1 0]';

%BDF1

y1_BDF1 = BDFk(A1, B1, f1, y0, tspan, h, 1)

%BDF2

y1_BDF2 = BDFk(A1, B1, f1, y0, tspan, h, 2)

%BDF3

y1_BDF3 = BDFk(A1, B1, f1, y0, tspan, h, 3)

%Trapezoidal

y1_Trapezoidal = trapezoidal(A1, B1, f1, y0, tspan, h)


x = 0:h:tspan(2);
graph = 1;
figure
title('comparison of the solutions of the different methods')

hold on
plot(x, y1_BDF1(graph,:), 'DisplayName', 'BDF1');
plot(x, y1_BDF2(graph,:), 'DisplayName', 'BDF2');
%plot(x, y1_BDF3(graph,:), 'DisplayName', 'BDF3');
%plot(x, y1_Trapezoidal(graph,:), 'DisplayName', 'Trapezoidal');
hold off

legend