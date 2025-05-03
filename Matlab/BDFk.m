function y = BDFk(A, B, f, y0, tspan, h,k, yexact)
% BDF-k method for solving Ay' + By = f or Ay' = f - By or Ay' + By - f = 0
    % A: Matrix
    % B: Matrix
    % f: vector-valued function f(t)
    % y0: Initial condition - vector of size k
    % tspan: Time interval [t0, tf]
    % h: Step size
    % k: indicates the method used
    % yexact: exact solution as function - if given the initial values 
    % are taken directly from the exact solution
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

    %construct initial k values using BDF1 and BDF2 method on finer grid
    if k == 2; g = 2; elseif k ==3; g=4; end %factor by how much the grid is finer
    
    if k ~= 1
        tempspan = [tspan(1),tspan(1)+h*(k-1)]; %yk is already calculated by BDFk method
        if nargin == 8
            y(:,1:k) = yexact(tspan(1):h:(tspan(1) + h*(k-1)));
        else
            initial = BDFk(A, B, f, y0, tempspan, h/g,k-1);
            y(:,1:k) = initial(:,1:g:end);
        end
    end
     
    %apply appropriate bdf-scheme
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
    end
end

