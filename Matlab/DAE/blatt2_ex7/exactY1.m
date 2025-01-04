function [out] = exactY1(t)
%with initial value 0
    out = 1/2 * exp(-t) + sin(t)/2 - cos(t)/2;
end

