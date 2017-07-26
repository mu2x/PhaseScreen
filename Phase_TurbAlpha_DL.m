function [phz, r0, Cn2] = Phase_TurbAlpha_DL(Rytov,wvl,N,deltax,deltaz, L, Lout,Lin,alpha)
    global flag; 
    % 4, SPIE V 2471, Rytov=sigma_x^2
    k=2*pi/wvl; 
    %Cn2=Rytov/(0.312 * k^(7/6) * L^(11/6));r0 = (.423*k^2*Cn2.*deltaz).^(-3/5);
    del_f = 1/(N*deltax); fx = (-N/2:N/2-1)*del_f; [fx, fy] = meshgrid(fx); 
    fsq=fx.^2+fy.^2; f=sqrt(fsq);  
    fm = 5.92/Lin/(2*pi); f0=1/Lout; % inner & outer scale f
    
    aalpha=2^(alpha-6) * (alpha^2-5*alpha + 6)*pi^(-3/2) * gamma( (alpha-2)/2 )/gamma( (5-alpha)/2); 
    c1=2*(8/(alpha-2) * gamma(2/(alpha-2)))^((alpha-2)/2); 
    t= -( 2^( (2-alpha)/2 ) * pi^(5/2) * k^( (6-alpha)/2 )  * aalpha/alpha) ...
        * ( gamma((2-alpha)/4)/gamma(alpha/4) ) * L^(alpha/2) ;
    betaz = Rytov/t;     Cn2=betaz; 
    num=c1*gamma(alpha/2); %c1*(alpha-1)*gamma(alpha/2); %spherical wave
    den=-2^(4-alpha)*pi^2*aalpha*gamma( (2-alpha)/2 ); 
    r0 = (num/(den*k^2 * betaz*deltaz) )^(1/(alpha-2)); 
    
    %PSD_phi = 0.023 *r0^(-5/3)*exp(-(fsq/fm^2))./(fsq + f0^2).^(p/2);%Modified von Karman
    %PSD_phi = 0.023 *r0^(-5/3)./f.^p; % Kolmogorov
    coeff=2*pi*aalpha * (r0^-(alpha-2) * num/den)*(2*pi)^(2-alpha);
    if(strcmp(flag,'vK')) 
      PSD_phi = coeff *(fsq+f0^2).^(-alpha/2);                         
    elseif(strcmp(flag,'mvK')) 
      PSD_phi = coeff *exp(-(fsq/fm^2)).*(fsq+f0^2).^(-alpha/2);                 
    else
      PSD_phi = coeff *f.^(-alpha);                         
      %PSD_phi = 2*pi*aalpha * (r0^-(alpha-2) * num/den)*(2*pi)^(2-alpha) *f.^(-alpha);         
    end
    %PSD_n = aalpha * betaz *f.^(-alpha) * (2*pi)^(2-alpha); % (2pi)^2 * (2pi)^-alpha for k->f 
    %PSD_phi = 2*pi*k^2*deltaz*PSD_n; % its 2pi, not 2pi^2 (as in Dr. Schmidt's book?)
    
    
    PSD_phi(N/2+1,N/2+1)=0; 
    
    cnm=(randn(N)+1i*randn(N)).*sqrt(PSD_phi)*del_f; 
    %phz = real(ift2(cnm,1)); 
     phzComplex=ifftshift(ifft2(ifftshift(cnm)))*(N*1)^2;
     phz = real(phzComplex);
     %fprintf('[phz mean/var real imag]=%.1e %.1e %.1e %.1e\n',mean(phz(:)),var(phz(:)),mean(imag(phzComplex(:))),var(imag(phzComplex(:))));

end