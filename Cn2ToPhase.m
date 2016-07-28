function phz = Cn2ToPhase(Cn2,wvl,N,deltax,deltaz, Lout,Lin,alpha)
    flag='mvK'; 

    k=2*pi/wvl; del_f = 1/(N*deltax); fx = (-N/2:N/2-1)*del_f; [fx, fy] = meshgrid(fx); 
    fsq=fx.^2+fy.^2; f=sqrt(fsq);  fm = 5.92/Lin/(2*pi); f0=1/Lout; 
    
    aalpha=2^(alpha-6) * (alpha^2-5*alpha + 6)*pi^(-3/2) * gamma( (alpha-2)/2 )/gamma( (5-alpha)/2); 
    c1=2*(8/(alpha-2) * gamma(2/(alpha-2)))^((alpha-2)/2); 
    num=c1*gamma(alpha/2); den=-2^(4-alpha)*pi^2*aalpha*gamma( (2-alpha)/2 ); 

    r0 = (num/(den*k^2 * Cn2*deltaz) )^(1/(alpha-2)); 
    coeff=2*pi*aalpha * (r0^-(alpha-2)) * (num/den) * (2*pi)^(2-alpha);
    
    %PSD_phi = 0.023 *r0^(-5/3)*exp(-(fsq/fm^2))./(fsq + f0^2).^(p/2);%Modified von Karman
    %PSD_phi = 0.023 *r0^(-5/3)./f.^p; % Kolmogorov

    if(strcmp(flag,'vK')) 
      PSD_phi = coeff *(fsq+f0^2).^(-alpha/2);                         
    elseif(strcmp(flag,'mvK')) 
      PSD_phi = coeff *exp(-(fsq/fm^2)).*(fsq+f0^2).^(-alpha/2);                 
    else
      PSD_phi = coeff *f.^(-alpha);                         
    end
    PSD_phi(N/2+1,N/2+1)=0; 
     cnm=(randn(N)+1i*randn(N)).*sqrt(PSD_phi)*del_f; 
     phz = real( ifftshift(ifft2(ifftshift(cnm)))*(N*1)^2;);
     %fprintf('[phz mean/var real imag]=%.1e %.1e %.1e %.1e\n',mean(phz(:)),var(phz(:)),mean(imag(phzComplex(:))),var(imag(phzComplex(:))));

end
