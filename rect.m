function y = rect(x, D)

if nargin == 1, D = 1; end
x=abs(x);
y = double(x<D/2);
y( x == D/2) = .5;