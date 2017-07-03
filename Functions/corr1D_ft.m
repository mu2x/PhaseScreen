function c = corr1D_ft(u1,u2,mask,delta)

N=length(u1); c=0*u1; delta_f = 1/(N*delta); 
U1=ft1D(u1.*mask, delta); U2=ft1D(u2.*mask, delta); 

U12corr = ift1D(conj(U1).*U2, delta_f); 
maskcorr = ift1D(abs(ft1D(mask,delta)), delta_f)*delta; 
idx = logical(maskcorr); 
c(idx) = U12corr(idx)./maskcorr(idx).*mask(idx); 


end