function y = BDFk(A, B, f, y0, tspan, h,k)
% BDF-k method for solving Ay' + By = f or Ay' = f - By or Ay' + By - f = 0
    % A: Matrix
    % B: Matrix
    % f: vector-valued function f(t)
    % y0: Initial condition - vector of size k
    % tspan: Time interval [t0, tf]
    % h: Step size

    % Time vector
    t = tspan(1):h:tspan(2);
    n = length(t);
    
    % Preallocate solution array
    y = zeros(length(y0), n);
    for i=1:k
        y(:, i) = y0(:, i);
    end

    % BDF-k coefficients
    BDF1alpha = [1 -1];
    BDF2alpha = [3 -4 1];
    BDF3alpha = [11 -18 9 -2];

    BDFalpha =  {BDF1alpha;
                BDF2alpha;
                BDF3alpha};

    BDFbeta = [1 2 6 12 60 60];
    
    % Time-stepping loop for BDF-k
    for i = k+1:n
        ti = t(i);
        % Solve implicit equation for y_i
        y(:, i) = (-sum(y(:, i-1:i-k)*BDFalpha{k},2) + BDFbeta{k}*h*f(ti))/(BDFalpha{k}(k)*M+BDFbeta{k}*h*B);  %solve the implicit equation
        %not sure if this summation makes sense
    end
end
