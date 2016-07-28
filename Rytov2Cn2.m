function Cn2 = Rytov2Cn2(Rytov,wvl,L,alpha)
    % Stribiling, SPIE V 2471, Rytov=sigma_x^2
    k=2*pi/wvl; 
    
    aalpha=2^(alpha-6) * (alpha^2-5*alpha + 6)*pi^(-3/2) * gamma( (alpha-2)/2 )/gamma( (5-alpha)/2); 
    t= -( 2^( (2-alpha)/2 ) * pi^(5/2) * k^( (6-alpha)/2 )  * aalpha/alpha) ...
        * ( gamma((2-alpha)/4)/gamma(alpha/4) ) * L^(alpha/2) ;
    Cn2= Rytov/t;    % Cn2=betaz; 
    % Cn2=Rytov/(0.312 * k^(7/6) * L^(11/6));
    % r0 = (.423*k^2*Cn2.*L).^(-3/5);

end
