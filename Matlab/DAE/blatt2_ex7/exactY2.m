function [out] = exactY2(t)
%with initial value 0
    out = 2*tan(exp(log(atan(1/2))-t));
end

