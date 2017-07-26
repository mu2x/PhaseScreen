clear; 
addpath('Functions') 
 N = 256;  L = 16;  delta = L / N; delta_f = 1/(N*delta);
 
 x = (-N/2 : N/2-1) * delta; nn=(-N/2:N/2-1); [x,y] = meshgrid(x);
 w = 2;  A = rect(x/w) .* rect(y/w);  B = tri(x/w) .* tri(y/w); 
 C = myconv2(A, B, delta); % perform digital convolution
 %C_cont = w^2*tri(x/w) .* tri(y/w); % continuous convolution
c=C; %f=A; g=B;
f0 = rand(N);
[f,g] = simpblinddeconv2(c, f0, delta);
 
 %F = ft2(f,delta);
 %C = ft2(c, delta);
 %G = C./(F+1e-8); 
 %g_new = ift2(G, delta_f);
 
 figure
 subplot(2,2,1); imagesc(nn*delta, nn*delta, f); axis equal;
 subplot(2,2,2); imagesc(nn*delta, nn*delta, g); axis equal;
 subplot(2,2,3); imagesc(nn*delta, nn*delta, c); axis equal;
 subplot(2,2,4); plot(x(N/2,:), c(N/2,:))
 
 figure
 subplot(2,2,1); imagesc(nn*delta, nn*delta, A); axis equal;
 subplot(2,2,2); imagesc(nn*delta, nn*delta, B); axis equal;
 subplot(2,2,3); imagesc(nn*delta, nn*delta, c); axis equal;
 subplot(2,2,4); plot(x(N/2,:), c(N/2,:))