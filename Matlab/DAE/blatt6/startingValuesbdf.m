function [y_start] = startingValuesbdf(y0, h, f, M, A)
%gives starting valoes from y_1 - y_6
    y_start = zeros(length(y0), 6);

    y_start(:, 1) = y0 + h*f(h);

    % BDF-k coefficients
    BDF1alpha = [1 -1];
    BDF2alpha = [3 -4 1];
    BDF3alpha = [11 -18 9 -2];
    BDF4alpha = [25 -48 36 -16 3];
    BDF5alpha = [137 -300 300 -200 75 -12];
    BDF6alpha = [147 -360 450 -400 225 -72 10];

    BDFalpha =  {BDF1alpha,
                BDF2alpha,
                BDF3alpha,
                BDF4alpha,
                BDF5alpha,
                BDF6alpha};

    BDFbeta = [1 2 6 12 60 60];


    for i=2:6
        F = @(yi) M*yi - h*BDFbeta(i)*(A*yi + f(ti)) - sum(y(:, 1:i)*BDFalpha{k},2);
        y_start(:, i) = fsolve(F, y(:, i-1));  % Use fsolve to solve the implicit equation
    end
end

