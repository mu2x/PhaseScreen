function U = fresnel_prop_square_ap(x2, y2, D1, wvl, Dz)
 % function U = fresnel_prop_square_ap(x2, y2, D1, wvl, Dz)

 N_F = (D1/2)^2 / (wvl * Dz); % Fresnel number
 % substitutions
 bigX = x2 / sqrt(wvl*Dz);
 bigY = y2 / sqrt(wvl*Dz);
 alpha1 = -sqrt(2) * (sqrt(N_F) + bigX);
 alpha2 = sqrt(2) * (sqrt(N_F) - bigX);
 beta1 = -sqrt(2) * (sqrt(N_F) + bigY);
 beta2 = sqrt(2) * (sqrt(N_F) - bigY);
 % Fresnel sine and cosine integrals
 ca1 = mfun(FresnelC, alpha1);
 sa1 = mfun(FresnelS, alpha1);
 ca2 = mfun(FresnelC, alpha2);
 sa2 = mfun(FresnelS, alpha2);
 cb1 = mfun(FresnelC, beta1);
 sb1 = mfun(FresnelS, beta1);
 cb2 = mfun(FresnelC, beta2);
 sb2 = mfun(FresnelS, beta2);
 % observation-plane field
 U = 1 /(2*i) *((ca2 - ca1) + i * (sa2 - sa1)) ...
 .* ((cb2 - cb1) + i * (sb2 - sb1));
end