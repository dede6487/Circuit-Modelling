tspan = [0;2*pi];
h = 0.1/2;

x = 0:h:tspan(2);

%test code with simple example

%u = -u'
%u = exp(-x)

%system matrices
A1 = [1];

B1 = [1];

f1 = @(t) [0]';

%consistent initial values (arbitrary since ODE)

y0 = [1]';

%exact solution for y0 = [1 0]', C=L=1
%y = [u1 iL]

y = @(t) [exp(-t)]';
y_exact = zeros(length(y0), length(x));
y_exact(:,1) = y0;

for i=2:length(x)
    y_exact(:,i) = y((i-1)*h);
end

%BDF1

y1_BDF1 = BDFk(A1, B1, f1, y0, tspan, h, 1);

%BDF2

y1_BDF2 = BDFk(A1, B1, f1, y0, tspan, h, 2, y);

%BDF3

y1_BDF3 = BDFk(A1, B1, f1, y0, tspan, h, 3, y);

%Trapezoidal

y1_Trapezoidal = trapezoidal(A1, B1, f1, y0, tspan, h);

%error calculation

diff_BDF1 = y1_BDF1-y_exact;
diff_BDF2 = y1_BDF2-y_exact;
diff_BDF3 = y1_BDF3-y_exact;
diff_Trapezoidal = y1_Trapezoidal-y_exact;

fprintf('The BDF1 method has a maximum error of in u1: %e \n', max(abs(diff_BDF1(1,:)),[],"all"))

fprintf('The BDF2 method has a maximum error of in u1: %e \n', max(abs(diff_BDF2(1,:)),[],"all"))

fprintf('The BDF3 method has a maximum error of in u1: %e \n', max(abs(diff_BDF3(1,:)),[],"all"))

fprintf('The Trapezoidal method has a maximum error of in u1: %e \n', max(abs(diff_Trapezoidal(1,:)),[],"all"))

%illustration of one of the components at a time, i.e. graph =1,2 for u1,
%iL

graph = 1;
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