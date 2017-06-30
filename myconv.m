function C = myconv(A, B, delta)
N = length(A);
deltaf = 1/(N*delta); 
C = ift(ft(A,delta).*ft(B, delta), deltaf);