function y = tri(x, D)
 % function y = tri(x, D)
 if(nargin==0) fprintf('Use as y=tri(x,D);\n'); return; end
 if nargin == 1, D = 1; end
 y = double(x<D);
 y(x<=0) = D+x(x<=0); 
 y(x>=0) = D-x(x>=0); 
 y(abs(x)>D) = 0; 
end