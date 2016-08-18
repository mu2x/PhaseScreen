wvl=1e-6; L=10e3; delta=1e-3; 
Dir='../DATA/riptide/01-Aug-2016_noise_0';
kpow=22/6; r=[1:100]*delta; ii=0; 
for Rytov=[.1 .5 1 2 3]
    ii=ii+1; 
    mfile=sprintf('%s/Output_%.1f_%.1f.mat',Dir,Rytov,6*kpow);
    load(mfile); Asq=abs(Uout.^2); N=size(Asq,1); 
    Ic=corr2_ft(Asq-1,Asq-1,ones(N),1e-3);
    ye(ii,:)=Ic(N/2,N/2:N/2+100)/max(Ic(:)); 
    xc=(N/2:N/2+100)*delta; xc=xc-min(xc); 
    C(ii,:)=Normalized_Cov(r,Rytov,wvl,L);
end

plot(xc,ye(1,:), r,C(1,:))
plot(xc,ye(1,:),'r-.', r,C(1,:), 'r', xc,ye(3,:), 'b-.', r,C(3,:), 'b', xc,ye(5,:), 'g-.', r,C(5,:),'g')
legend('x1, Rytov=.1','t1','x2, Rytov=1', 't2', 'x3, Rytov=3', 't3')
