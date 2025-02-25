function y = BDFk(A, B, f, y0, tspan, h,k, yexact)
% BDF-k method for solving Ay' + By = f or Ay' = f - By or Ay' + By - f = 0
    % A: Matrix
    % B: Matrix
    % f: vector-valued function f(t)
    % y0: Initial condition - vector of size k
    % tspan: Time interval [t0, tf]
    % h: Step size
    % k: indicates the method used
    %output: vector y of size length(y0) x length(tspan(1):h:tspan(2)
    %containing the calculated timesteps of the method

    % Time vector
    t = tspan(1):h:tspan(2);
    n = length(t);
    
    % Preallocate solution array (containing all the time steps)
    y = zeros(length(y0), n);
    for i=1:length(y0)
        y(i, 1) = y0(i, 1);
    end

    % % BDF-k coefficients
    % BDF1alpha = [1 -1];
    % BDF2alpha = [3 -4 1];
    % BDF3alpha = [11 -18 9 -2];
    % 
    % BDFalpha =  {BDF1alpha;
    %             BDF2alpha;
    %             BDF3alpha};
    % 
    % BDFbeta = [1 2 6 12 60 60];

    %construct initial k values using BDF1 method
    if k ~= 1
        tempspan = [tspan(1),tspan(1)+h*(k-1)]; %yk is already calculated by BDFk method
        if nargin == 8
            y(:,1:k) = yexact(tspan(1):h:tspan(1) + h*(k-1));
        else
            y(:,1:k) = BDFk(A, B, f, y0, tempspan, h,k-1);
        end
    end
     
    if k == 1 %for k=1 we just implicit euler
        for i = k+1:n
            y(:,i) = (A+h*B) \ (A*y(:,i-1) + h*f(t(i)));
        end
    elseif k == 2
        for i = k+1:n
            y(:,i) = (3*A+2*h*B) \ (-A*y(:,i-2) + 4*A*y(:,i-1) + 2*h*f(t(i)));
        end
    elseif k == 3
        for i = k+1:n
            y(:,i) = (11*A+6*h*B) \ (18*A*y(:,i-1) - 9*A*y(:,i-2) + 2*A*y(:,i-3) + 6*h*f(t(i)));
        end
    % else %implemented the methods explicitly cause there was an issue with some code below
    %     % Time-stepping loop for BDF-k
    %     for i = k+1:n
    %         ti = t(i);
    %         % Solve implicit equation for y_i
    %         %doing the sum 
    %         mysum = zeros(length(y0), 1);
    %         for j = 1:k %from 0 to k-1
    %             %                     because y_i is the n+k element we need to first retract k  
    %             %                     i-k+j               k+1-j
    %             mysum = mysum + A*y(:,i-k+j)*BDFalpha{k}(j);
    %         end
    %         %(-sum(A*y(:, i-1:i-k)*BDFalpha{k}(i),2)
    %         %dimensions       y0 x 1                    y0 x y0 + y0 x y0
    %         %          -?
    %         y(:, i) = (-mysum + BDFbeta(k)*h*f(ti))'/(BDFalpha{k}(k)*A+BDFbeta(k)*h*B);  %solve the implicit equation
    %         %not sure if this summation makes sense - this should be the sum
    %         %componentwise, because of dim 2 at the end
    %     end
    end
end

