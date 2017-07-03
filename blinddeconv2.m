function [f,g] = blinddeconv2(c, f0, delta, N, beta)
%f0 must be a nonnegative-valued initial estimate
n = size(c,1);
delta_f = 1/(n*delta); 
C = ft2(c, delta);

while 1
F0 = ft2(f0,delta);               %Step 1 F0 = ft(f0)

G0 = C.*inv(F0);                  %Step 2 G0 = C/F0
g0 = ift2(G0, delta_f);           %Step 3 ift(G0) = g0
    while all(g0(:) > 0) == 0       
    g_0 = g0;                     %Step 4 g0(g0 < 0) = g0
    g0(g0 < 0) = 0;               %Non-negative contraint is formed 
    E_g = sum(g_0(:) - g0(:));    %with total energy being conserved
    g0 = g0 + (E_g/N);
    end
G0 = ft2(g0,delta);               %Step 5 G0 = ft(g0)

F0 = C.*inv(G0);                  %Step 6 F1 = C/G0
f0 = ift2(F0, delta_f);           %Step 7 f1 = ift(F1)
    while all(f0(:) > 0) == 0
    f_0 = f0;                     %Step 8 f1(f1 < 0) = f1
    f0(f0 < 0) = 0;               %Non-negative contraint is formed 
    E_f = sum(f_0(:) - f0(:));    %with total energy being conserved
    f0 = f0 + (E_f/N);
    end
    
F0 = ft2(f0,delta);               %Fourier-domain constraint
G0 = C.*inv(F0);
C_new = F0*G0 ;

if abs(C_new) < 1e-5      %Fourier contraint imposes no information 

elseif abs(G0) >= abs(C)  %The two estimates are averaged
    F0 = (1-beta).*F0 + beta*(C.*inv(G)); 
elseif abs(G0) < abs(C)   %The inverse of the two function estimates are averaged 
    F0 = inv((1-beta).*inv(F0) + beta*(G0./inv(C)));
end

C_new = F0*G0 ;

    if C_new == C        %Once the required convolution is met the loop breaks
    break
    end
    
    
f0 = ift2(F0, delta_f);
end

g =ift2(G0, delta_f);
f = ift2(F0, delta_f);