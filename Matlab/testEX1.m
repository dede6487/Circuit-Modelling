tspan = [0;10];
h = 0.01;

%example 1

%system matrices
A1 = [0 0 0;
      0 1 0;
      0 0 0];

B1 = [1 1 0;
      1 1 -1;
      0 -1 0];

f1 = @(t) [0 0 sin(pi*t)]';

%consistent initial values (as calculated)

y0 = [0 0 0]';

%exact solution u1 = u2 = -vsrc

y = @(t) [-subsref(f1(t), struct('type', '()', 'subs', {{3}}));
          -subsref(f1(t), struct('type', '()', 'subs', {{3}}));
          0]; %first and second component returns third component of f1
y_exact = zeros(length(y0), length(x));
y_exact(:,1) = y0;

for i=2:length(x)
    y_exact(:,i) = y(i*h);
end

%BDF1

y1_BDF1 = BDFk(A1, B1, f1, y0, tspan, h, 1)

%BDF2

y1_BDF2 = BDFk(A1, B1, f1, y0, tspan, h, 2)

%BDF3

y1_BDF3 = BDFk(A1, B1, f1, y0, tspan, h, 3)

%Trapezoidal

y1_Trapezoidal = trapezoidal(A1, B1, f1, y0, tspan, h)


x = 0:h:tspan(2);
graph = 2;
figure
title('comparison of the solutions of the different methods')

hold on
plot(x, y_exact(graph,:), 'DisplayName', 'exact solution');
%plot(x, y1_BDF1(graph,:), 'DisplayName', 'BDF1');
%plot(x, y1_BDF2(graph,:), 'DisplayName', 'BDF2');
%plot(x, y1_BDF3(graph,:), 'DisplayName', 'BDF3');
%plot(x, y1_Trapezoidal(graph,:), 'DisplayName', 'Trapezoidal');
hold off

legend