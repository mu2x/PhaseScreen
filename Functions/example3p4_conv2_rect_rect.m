% example_conv2_rect_rect.m

 N = 256; % number of samples
 L = 16; % grid size [m]
 delta = L / N; % sample spacing [m]
 F = 1/L; % frequency-domain grid spacing [1/m]
 x = (-N/2 : N/2-1) * delta; nn=(-N/2:N/2-1);
 [x y] = meshgrid(x);
 w = 2; % width of rectangle
 A = rect(x/w) .* rect(y/w); % signal
 B = rect(x/w) .* rect(y/w); % signal
 C = myconv2(A, B, delta); % perform digital convolution
 % continuous convolution
 C_cont = w^2*tri(x/w) .* tri(y/w);
 
 subplot(2,1,1); imagesc(nn*delta, nn*delta, C); axis equal;
 subplot(2,1,2); imagesc(nn*delta, nn*delta, C_cont); axis equal;