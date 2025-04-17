clear; close all;

tspan = [0;10];
hspan = [0.1,0.05,0.05/2];

%initialize error output

err_gauss = zeros(3,10);

err_gauss(:,1) = hspan;

%Example1
    %system matrices
    A1 = [0 0 0;
          0 1 0;
          0 0 0];
    
    B1 = [1 -1 -1;
          -1 1 0;
          -1 0 0];
    
    f1 = @(t) [0 0 -sin(pi*t)]';
    
    %consistent initial values (as calculated)
    
    y10 = [0 0 0]'; % consistent initial values
    
    c1 = pi/(1+pi*pi);
    u2 = @(t) (c1*exp(-t) + (sin(pi * t)/(1+ pi*pi)) - ((pi*cos(pi * t))/(1+pi*pi)));
    
    %exact solution u2 = vsrc, u1 = -u2
    % y = [u1, u2, iV]
    
    y1 = @(t) [sin(pi*t);
              u2(t);
              sin(pi*t) - u2(t)];
            
%Example2

    %system matrices
    A2 = [1 0
          0 1];
    
    B2 = [0 1
          -1 0];
    
    f2 = @(t) [0 0]';
    
    %consistent initial values (arbitrary since ODE)
    
    y20 = [1 0]';
    
    %exact solution for y0 = [1 0]', C=L=1
    %y = [u1 iL]
    
    y2 = @(t) [cos(t) sin(t)]';
    
%Example3
    
    %system matrices
    A3 = [1 0;
          0 0];
    
    B3 = [1 -1;
          1 0];
    
    f3 = @(t) [0 -sin(pi*t)]';
    
    %consistent initial values (as calculated)
    
    y30 = [0 -pi]';
    
    %exact solution u1 = -vsrc, iV = u1 + u1'
    % y = [u1, iV]
    
    y3 = @(t) [-sin(pi*t); 
              -sin(pi*t)-pi*cos(pi*t)]; 
    
for n=1:3

    h = hspan(n);
    fprintf('the step size is %d \n',h)

    x = 0:h:tspan(2);

    y1_exact = zeros(length(y10), length(x));
    y1_exact(:,1) = y10;

    y2_exact = zeros(length(y20), length(x));
    y2_exact(:,1) = y20;

    y3_exact = zeros(length(y30), length(x));
    y3_exact(:,1) = y30;

    for i=2:length(x)
        i
        y1_exact(:,i) = y1((i-1)*h);
        y2_exact(:,i) = y2((i-1)*h);
        y3_exact(:,i) = y3((i-1)*h);
    end

    %Example1
    
    y1_gauss = gauss1(A1, B1, f1, y10, tspan, h);
    
    %Example2
    
    y2_gauss = gauss1(A2, B2, f2, y20, tspan, h);
    
    %Example3
    
    y3_gauss = gauss1(A3, B3, f3, y30, tspan, h);

    %error calculation
    
    diff_y1 = y1_gauss-y1_exact;
    diff_y2 = y2_gauss-y2_exact;
    diff_y3 = y3_gauss-y3_exact;

    max_err_y1 = [max(abs(diff_y1(1,:))) max(abs(diff_y1(2,:))) max(abs(diff_y1(3,:)))];
    max_err_y2 = [max(abs(diff_y2(1,:))) max(abs(diff_y2(2,:))) 0];
    max_err_y3 = [max(abs(diff_y3(1,:))) max(abs(diff_y3(2,:))) 0];

    %save error in matrix
    err_gauss(n,2:end) = [max_err_y1 max_err_y2 max_err_y3];

end

%output error
out = array2table(err_gauss);
out.Properties.VariableNames(1:10) = {'h','oneu','oneuu','onei', 'twou', 'twoi','twoignore','threeu','threei','threeignore'};
writetable(out,'err_gauss.csv');
