function c = corr2_ft(u1,u2,mask,delta)

N=size(u1,1); c=zeros(N); delta_f = 1/(N*delta); 
U1=ft2(u1.*mask, delta); U2=ft2(u2.*mask, delta); 

U12corr = ift2(conj(U1).*U2, delta_f); 
maskcorr = ift2(abs(ft2(mask,delta)).^2, delta_f)*delta^2; 
idx = logical(maskcorr); 
c(idx) = U12corr(idx)./maskcorr(idx).*mask(idx); 


end