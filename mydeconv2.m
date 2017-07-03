function b = mydeconv2(c, a, delta)
N = size(c,1);
deltaf = 1/(N*delta);
b = ift2(ft2(c,delta).*inv(ft2(a, delta)), deltaf);