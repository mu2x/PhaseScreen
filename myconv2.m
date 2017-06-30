function C = myconv2(A, B, delta)
N = size(A,1);
deltaf = 1/(N*delta); 
C = ift2(ft2(A,delta).*ft2(B, delta), deltaf);