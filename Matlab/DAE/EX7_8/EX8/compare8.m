function [errorExp,errorImp,errorMid] = compare8(h, tspan, u0, eps)

    N = tspan/h +1;
    uExp = Euler_Explicit8(eps, h, tspan, u0);
    uImp = Euler_Implicit8(eps, h, tspan, u0);
    uMid = Midpoint8(eps, h, tspan, u0);
    y = zeros(2, N);

    for i = 1:(N)
        y(:, i) = Solution8((i-1)*h, eps);
    end

    errorExptemp = zeros(1,N);
    errorImptemp = zeros(1,N);
    errorMidtemp = zeros(1,N);
    for i=1:N
        errorExptemp(1,i) = norm(uExp(1,i)-y(1,i));
        errorImptemp(1,i) = norm(uImp(1,i)-y(1,i));
        errorMidtemp(1,i) = norm(uMid(1,i)-y(1,i));
    end
    errorExp = max(errorExptemp);
    errorImp = max(errorImptemp);
    errorMid = max(errorMidtemp);
end

