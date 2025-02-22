function y = BDFk(A, B, f, y0, tspan, h,k)
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

    % BDF-k coefficients
    BDF1alpha = [1 -1];
    BDF2alpha = [3 -4 1];
    BDF3alpha = [11 -18 9 -2];

    BDFalpha =  {BDF1alpha;
                BDF2alpha;
                BDF3alpha};

    BDFbeta = [1 2 6 12 60 60];
    %construct initial k values using BDF1 method
    if k ~= 1
        tempspan = [0+h,h*k];
        y(:,1:k) = BDFk(A, B, f, y0, tempspan, h,1);
    end
     

    % Time-stepping loop for BDF-k
    for i = k+1:n
        ti = t(i);
        % Solve implicit equation for y_i
        %doing the sum 
        mysum = zeros(length(y0), 1);
        for j = 1:k %from 0 to k-1
            %               k-1 previous y and all the alpha except for
            %               last one
            %               y_i-j * a_k 
            %                                      k+1-j
            mysum = mysum + A*y(:,i-j)*BDFalpha{k}(k+1-j);
        end
        %(-sum(A*y(:, i-1:i-k)*BDFalpha{k}(i),2)
        %dimensions       y0 x 1                    y0 x y0 + y0 x y0
        %          -?
        y(:, i) = (mysum + BDFbeta(k)*h*f(ti))'/(BDFalpha{k}(k)*A+BDFbeta(k)*h*B);  %solve the implicit equation
        %not sure if this summation makes sense - this should be the sum
        %componentwise, because of dim 2 at the end
    end
end

