% example_conv_rect_rect.m

 N = 64; % number of samples
 L = 8; % grid size [m]
 delta = L / N; % sample spacing [m]
 F = 1/L; % frequency-domain grid spacing [1/m]
 x = (-N/2 : N/2-1) * delta;
 w = 2; % width of rectangle
 A = rect(x/w); % signal
 B = rect(x/w); % signal
 C = myconv(A, B, delta); % perform digital convolution
 C_cont = w*tri(x/w);  % continuous convolution
 plot(x,C, x, C_cont); legend('C','C_{cont}');
 