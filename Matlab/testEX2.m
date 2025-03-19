clear; close all;

tspan = [0;8*pi];
hspan = [1,0.1,0.01];

%initialize error output

err_ex2 = zeros(3,9);

err_ex2(:,1) = hspan';

for n = 1:3
    h = hspan(n);
    fprintf('the step size is %d \n',h)
    
    x = 0:h:tspan(2);
    
    %example 2
    
    %system matrices
    A1 = [1 0
          0 1];
    
    B1 = [0 1
          -1 0];
    
    f1 = @(t) [0 0]';
    
    %consistent initial values (arbitrary since ODE)
    
    y0 = [1 0]';
    
    %exact solution for y0 = [1 0]', C=L=1
    %y = [u1 iL]
    
    %                - solves problem? why though?
    y = @(t) [cos(t) sin(t)]';
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
    
    max_err_BDF1 = [max(abs(diff_BDF1(1,:))) max(abs(diff_BDF1(2,:)))];
    max_err_BDF2 = [max(abs(diff_BDF2(1,:))) max(abs(diff_BDF2(2,:)))];
    max_err_BDF3 = [max(abs(diff_BDF3(1,:))) max(abs(diff_BDF3(2,:)))];
    max_err_Trapezoidal = [max(abs(diff_Trapezoidal(1,:))) max(abs(diff_Trapezoidal(2,:)))];
    
    fprintf('The BDF1 method has a maximum error of \nin u1: %e \n', max(abs(diff_BDF1(1,:)),[],"all"))
    fprintf('in iL: %e \n', max(abs(diff_BDF1(2,:)),[],"all"))
    
    fprintf('The BDF2 method has a maximum error of \nin u1: %e \n', max(abs(diff_BDF2(1,:)),[],"all"))
    fprintf('in iL: %e \n', max(abs(diff_BDF2(2,:)),[],"all"))
    
    fprintf('The BDF3 method has a maximum error of \nin u1: %e \n', max(abs(diff_BDF3(1,:)),[],"all"))
    fprintf('in iL: %e \n', max(abs(diff_BDF3(2,:)),[],"all"))
    
    fprintf('The Trapezoidal method has a maximum error of \nin u1: %e \n', max(abs(diff_Trapezoidal(1,:)),[],"all"))
    fprintf('in iL: %e \n', max(abs(diff_Trapezoidal(2,:)),[],"all"))
    
    %save error in matrix
    err_ex2(n,2:end) = [max_err_BDF1 max_err_BDF2 max_err_BDF3 max_err_Trapezoidal];
       
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

end

%output error
out = array2table(err_ex2);
out.Properties.VariableNames(1:9) = {'h','oneu','onei','twou','twoi','threeu','threei','trapu','trapil'};
writetable(out,'err_ex2.csv');

%exact solution graph
% figure
% 
% hold on
% plot(x, y_exact(1,:), 'DisplayName', 'u1');
% 
% plot(x, y_exact(2,:), 'DisplayName', 'iL');
% hold off
% 
% legend
% 
% export_fig exact_solution_ex2.png;

