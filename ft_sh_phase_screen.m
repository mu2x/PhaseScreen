 function [phz_lo, phz_hi] = ft_sh_phase_screen(r0, N, delta, L0, l0, phz, alpha)
    global flag; 
    D = N*delta; [x, y] = meshgrid((-N/2 : N/2-1) * delta);
    phz_hi = phz; phz_lo = zeros(size(phz_hi));

    aalpha=2^(alpha-6) * (alpha^2-5*alpha + 6)*pi^(-3/2) * gamma( (alpha-2)/2 )/gamma( (5-alpha)/2); 
    c1=2*(8/(alpha-2) * gamma(2/(alpha-2)))^((alpha-2)/2); 

    num=c1*gamma(alpha/2);
    den=-2^(4-alpha)*pi^2*aalpha*gamma( (2-alpha)/2 ); 

    coeff=2*pi*aalpha * (r0^-(alpha-2) * num/den)*(2*pi)^(2-alpha);

for p = 1:3

del_f = 1 / (3^p*D); 
fx = (-1 : 1) * del_f;
[fx, fy] = meshgrid(fx);
fsq=fx.^2+fy.^2; f=sqrt(fsq); 
fm = 5.92/l0/(2*pi); 
f0 = 1/L0;

    if(strcmp(flag,'vK')) 
      PSD_phi = coeff *(fsq+f0^2).^(-alpha/2);                         
    elseif(strcmp(flag,'mvK')) 
      PSD_phi = coeff *exp(-(fsq/fm^2)).*(fsq+f0^2).^(-alpha/2);                 
    else
      PSD_phi = coeff *f.^(-alpha);
    end
    
PSD_phi(2,2) = 0;
cn = (randn(3) + 1i*randn(3)).* sqrt(PSD_phi)*del_f;
SH = zeros(N);

for ii = 1:9
SH = SH + cn(ii)* exp(1i*2*pi*(fx(ii)*x+fy(ii)*y));
end
phz_lo = phz_lo + SH;
end
phz_lo = real(phz_lo) - mean(real(phz_lo(:)));
