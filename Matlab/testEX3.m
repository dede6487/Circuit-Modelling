clear; close all;

tspan = [0;pi];
hspan = [0.1,0.05,0.05/2];

%initialize error output

err_ex3 = zeros(3,9);

err_ex3(:,1) = hspan';

for n = 1:3
    h = hspan(n);
    fprintf('the step size is %d \n',h)
    
    x = 0:h:tspan(2);
    
    %example 3
    
    %system matrices
    A1 = [1 0;
          0 0];
    
    B1 = [1 -1;
          1 0];
    
    f1 = @(t) [0 -sin(pi*t)]';
    
    %consistent initial values (as calculated)
    
    y0 = [0 -pi]';
    
    %exact solution u1 = -vsrc, iV = u1 + u1'
    % y = [u1, iV]
    
    y = @(t) [-sin(pi*t); 
              -sin(pi*t)-pi*cos(pi*t)]; 
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
    
    fprintf('The BDF1 method has a maximum error of in u1: %e \n', max(abs(diff_BDF1(1,:)),[],"all"))
    fprintf('in iV: %e \n', max(abs(diff_BDF1(2,:)),[],"all"))
    
    fprintf('The BDF2 method has a maximum error of in u1: %e \n', max(abs(diff_BDF2(1,:)),[],"all"))
    fprintf('in iV: %e \n', max(abs(diff_BDF2(2,:)),[],"all"))
    
    fprintf('The BDF3 method has a maximum error of in u1: %e \n', max(abs(diff_BDF3(1,:)),[],"all"))
    fprintf('in iV: %e \n', max(abs(diff_BDF3(2,:)),[],"all"))
    
    fprintf('The Trapezoidal method has a maximum error of in u1: %e \n', max(abs(diff_Trapezoidal(1,:)),[],"all"))
    fprintf('in iV: %e \n', max(abs(diff_Trapezoidal(2,:)),[],"all"))
    
    %save error in matrix
    err_ex3(n,2:end) = [max_err_BDF1 max_err_BDF2 max_err_BDF3 max_err_Trapezoidal];

    %illustration of one of the components at a time, i.e. graph =1,2 for u1,
    %iV
    
    % graph = 2;
    % figure
    % title('comparison of the solutions of the different methods')
    % 
    % hold on
    % plot(x, y_exact(graph,:), 'DisplayName', 'exact solution');
    % plot(x, y1_BDF1(graph,:), 'DisplayName', 'BDF1');
    % plot(x, y1_BDF2(graph,:), 'DisplayName', 'BDF2');
    % plot(x, y1_BDF3(graph,:), 'DisplayName', 'BDF3');
    % plot(x, y1_Trapezoidal(graph,:), 'DisplayName', 'Trapezoidal');
    % hold off
    % 
    % legend

end

%output error
out = array2table(err_ex3);
out.Properties.VariableNames(1:9) = {'h','oneu','onei','twou','twoi','threeu','threei','trapu','trapil'};
writetable(out,'err_ex3.csv');

%exact solution graph
% figure
% 
% hold on
% plot(x, y_exact(1,:), 'DisplayName', 'u1');
% 
% plot(x, y_exact(2,:), 'DisplayName', 'iV');
% hold off
% 
% legend
% 
% export_fig exact_solution_ex3.png;