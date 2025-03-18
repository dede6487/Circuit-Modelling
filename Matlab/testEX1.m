tspan = [0;10];
h = 0.01;

x = 0:h:tspan(2);

%example 1

%system matrices
A1 = [0 0 0;
      0 1 0;
      0 0 0];

B1 = [1 -1 -1;
      -1 1 0;
      -1 0 0];

f1 = @(t) [0 0 -sin(pi*t)]';

%consistent initial values (as calculated)

y0 = [0 0 0]'; % consistent initial values

c1 = pi/(1+pi*pi);
u2 = @(t) (c1*exp(-t) + (sin(pi * t)/(1+ pi*pi)) - ((pi*cos(pi * t))/(1+pi*pi)));

%exact solution u2 = vsrc, u1 = -u2
% y = [u1, u2, iV]

y = @(t) [sin(pi*t);
          u2(t);
          sin(pi*t) - u2(t)];
y_exact = zeros(length(y0), length(x));
y_exact(:,1) = y0;

for i=2:length(x)
    y_exact(:,i) = y((i-1)*h);
end

%BDF1

y1_BDF1 = BDFk(A1, B1, f1, y0, tspan, h, 1);

%BDF2

y1_BDF2 = BDFk(A1, B1, f1, y0, tspan, h, 2);

%BDF3

y1_BDF3 = BDFk(A1, B1, f1, y0, tspan, h, 3);

%Trapezoidal

y1_Trapezoidal = trapezoidal(A1, B1, f1, y0, tspan, h);

%error calculation

diff_BDF1 = y1_BDF1-y_exact;
diff_BDF2 = y1_BDF2-y_exact;
diff_BDF3 = y1_BDF3-y_exact;
diff_Trapezoidal = y1_Trapezoidal-y_exact;

fprintf('The BDF1 method has a maximum error of \n in u1: %e \n', max(abs(diff_BDF1(1,:)),[],"all"))
fprintf('in u2: %e \n', max(abs(diff_BDF1(2,:)),[],"all"))
fprintf('in iV: %.15e \n', max(abs(diff_BDF1(3,:)),[],"all"))

fprintf('The BDF2 method has a maximum error of \n in u1: %e \n', max(abs(diff_BDF2(1,:)),[],"all"))
fprintf('in u2: %e \n', max(abs(diff_BDF2(2,:)),[],"all"))
fprintf('in iV: %.15e \n', max(abs(diff_BDF2(3,:)),[],"all"))

fprintf('The BDF3 method has a maximum error of \n in u1: %e \n', max(abs(diff_BDF3(1,:)),[],"all"))
fprintf('in u2: %e \n', max(abs(diff_BDF3(2,:)),[],"all"))
fprintf('in iV: %.15e \n', max(abs(diff_BDF3(3,:)),[],"all"))

fprintf('The Trapezoidal method has a maximum error of \n in u1: %e \n', max(abs(diff_Trapezoidal(1,:)),[],"all"))
fprintf('in u2: %e \n', max(abs(diff_Trapezoidal(2,:)),[],"all"))
fprintf('in iV: %.15e \n', max(abs(diff_Trapezoidal(3,:)),[],"all"))

%illustration of one of the components at a time, i.e. graph =1,2,3 for u1,
%u2, iV

graph = 3;
figure
title('comparison of the solutions of the different methods')

hold on
plot(x, y_exact(graph,:), 'DisplayName', 'exact solution');
plot(x, y1_BDF1(graph,:), 'DisplayName', 'BDF1');
plot(x, y1_BDF2(graph,:), 'DisplayName', 'BDF2');
plot(x, y1_BDF3(graph,:), 'DisplayName', 'BDF3');
plot(x, y1_Trapezoidal(graph,:), 'DisplayName', 'Trapezoidal');
hold off

legend