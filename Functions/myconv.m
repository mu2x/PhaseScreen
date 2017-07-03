function C = myconv(A, B, delta)
% function C = myconv(A, B, delta)
  N = length(A);
  C = ift1D(ft1D(A, delta) .* ft1D(B, delta), 1/(N*delta));
end

