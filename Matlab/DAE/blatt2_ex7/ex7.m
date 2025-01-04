iter = 100;
t_0 = 0;
T = 5;

h = 5/iter;

t = 0:h:T;

y1_Heun = zeros(iter+1, 1);
y1_it = zeros(iter+1, 1);
y1_fiveb = zeros(iter+1,1);

y1_exact = [exactY1(t)]';

y2_Heun = zeros(iter+1, 1);
y2_Heun(1) = 1;
y2_it = zeros(iter+1, 1);
y2_it(1) = 1;
y2_fiveb = zeros(iter+1,1);
y2_fiveb(1) = 1;

y2_exact = [exactY2(t)]';

for i= 1:iter
    t_n = h*i;

    y1_Heun(i+1) = Heun(y1_Heun(i),@f1, h, t_n);
    y1_it(i+1) = implicit_trapezoidal(y1_it(i), @f1, h, t_n);
    y1_fiveb(i+1) = fiveb(y1_fiveb(i), @f1, h, t_n);

    y2_Heun(i+1) = Heun(y2_Heun(i),@f2, h, t_n);
    y2_it(i+1) = implicit_trapezoidal(y2_it(i), @f2, h, t_n);
    y2_fiveb(i+1) = fiveb(y2_fiveb(i), @f2, h, t_n);
end

figure(1);clf;

plot(t, y1_Heun, 'DisplayName', "y1 Heun")
hold on
plot(t, y1_it, 'DisplayName', "y1 it")
hold on
plot(t, y1_fiveb, 'DisplayName', "y1 fiveb")
hold on
plot(t, y1_exact, 'DisplayName', "exact solution")
hold off
legend show

max_error_Heun = max(abs(y1_Heun - y1_exact), [], "all")
max_error_it = max(abs(y1_it - y1_exact), [], "all")
max_error_fiveb = max(abs(y1_fiveb - y1_exact), [], "all")

figure(2);clf;

plot(t, y2_Heun, 'DisplayName', "y2 Heun")
hold on
plot(t, y2_it, 'DisplayName', "y2 it")
hold on
plot(t, y2_fiveb, 'DisplayName', "y2 fiveb")
hold on
plot(t, y2_exact, 'DisplayName', "exact solution")
hold off
legend show

max_error_Heun = max(abs(y2_Heun - y2_exact), [], "all")
max_error_it = max(abs(y2_it - y2_exact), [], "all")
max_error_fiveb = max(abs(y2_fiveb - y2_exact), [], "all")

