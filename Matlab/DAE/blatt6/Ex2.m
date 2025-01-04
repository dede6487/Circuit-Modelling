
% first find roots of polynomials and check the root condition


BDF1poly = [1 -1];
BDF2poly = [3 -4 1];
BDF3poly = [11 -18 9 -2];
BDF4poly = [25 -48 36 -16 3];
BDF5poly = [137 -300 300 -200 75 -12];
BDF6poly = [147 -360 450 -400 225 -72 10];

BDFpoly =  {BDF1poly,
            BDF2poly,
            BDF3poly,
            BDF4poly,
            BDF5poly,
            BDF6poly};

BDFroots = cell(6,1);

for i = 1:6
    BDFroots{i,1} = double(solve(poly2sym(BDFpoly{i,1})));
end

%BDFroots

temp = 1;
for i = 1:6
    for j = 1:numel(BDFroots{i})
        if abs(BDFroots{i,1}(j)) > 1 %.0000000000001 %why tho???
            %i
            %j
            %abs(BDFroots{i,1}(j))
            temp = 0;
        end
    end
end

temp

%------------------------------------------------------------------------
%second check consistency

consistent = ones(6,1);

betas = {[0 1],
         [0 0 2],
         [0 0 0 6],
         [0 0 0 0 12],
         [0 0 0 0 0 60],
         [0 0 0 0 0 0 60]};

%problem with indexing cause the elements are now polynomials bruh

for k = 1:6 %iterate over all BDF formulas
     sum = 0;
     for j = 1:k+1 %sum over j=0 to k (but starting with 1)
         sum = sum + (((j-1)^(k)) * (BDFpoly{k,1}(j)) - l*((j-1)^(k))*(betas{k,1}(j)));
     end
     if abs(sum) ~= 0
         sum
         consistent(k,1) = 0;
     end
end

consistent

%-------------------------------------------------------------------------
%determine set

set = [];

for i=1:k
    temp = solve(poly2sym(BDFpoly{i,1})-poly2sym(betas{i,1}));
end


