function y = trapezoidal(A, B, f, y0, tspan, h)
%TRAPEZOIDAL rule for solving Ay' + By = f or Ay' = f - By or Ay' + By - f = 0
    % A: Matrix
    % B: Matrix
    % f: vector-valued function f(t)
    % y0: Initial condition - vector of size k
    % tspan: Time interval [t0, tf]
    % h: Step size
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

    %time-stepping loop for Trapezoidal
    for i = 2:n
        y(:, i) = ((A-(h/2)*B)*y(:,i-1) + (h/2)*(f(t(i)) + f(t(i-1))))' / (A+(h/2)*B);  %solve the implicit equation
    end

end

