clear; 
addpath('2D_Phase_Unwrapping') 
Lin = 5e-3; Lout=10; flag='mvK'; deltax = 15e-3;   wvl=0.532e-6; Dz=10; 
N=1024; 
RytovV= .00001; %Rytov=0.312* Cn2 * k^(7/6) * L^(11/6);
nscreen=2;
ntrial=1; 
kpow=22/6; 

for Rytov=RytovV
    
  d = N*deltax;  
  deltaf=1/(N*deltax); z=linspace(0,Dz,nscreen);  deltaz=z(2)-z(1); 
  k=2*pi/wvl; nn=(-N/2:N/2-1);  [nx, ny] = meshgrid(nn); 
  x = (-N/2 : N/2-1) * deltax; [x,y] = meshgrid(x);
  nsq = nx.^2 + ny.^2; fsq=(nx*deltaf).^2+(ny*deltaf).^2;   
  Q2 = exp(-1i*pi^2*2*deltaz*fsq/k); mask=ones(N);

%     AsqS = zeros(N,N); varIS=0; meanIS=0; nIzS=0; nIzpS=0;
%     varPS=0; meanPS=0;
      varP = 0; 
  
for itrial=1:ntrial
  Uin=ones(N,N); g=Uin; G=zeros(N,N); phz=zeros(N,N);
  for idx=1:nscreen-1 
    [phz, r0, Cn2]=Phase_TurbAlpha_DL(Rytov,wvl,N,deltax,deltaz, Dz,Lout,Lin,kpow); 
    [phz_lo, phz_hi] = ft_sh_phase_screen(r0, N, deltax, Lout, Lin, phz, kpow);
    phz_SH = phz_lo + phz_hi;
    
    g = exp(1i*phz_SH) .* g;
    G=Q2.*fftshift(fft2(fftshift(g)))*deltax^2;   
    g = ifftshift(ifft2(ifftshift(G)))*(N*deltaf)^2; 
    %g = exp(1i*phz) .* g;
  end
     Uout = g; Asq=abs(Uout).^2; varI=var(Asq(:));% meanI=mean(Asq(:)); 
%    nIz=sum(Asq(:)<max(Asq(:))/100); nIzp=100*nIz/(N*N);
%    AsqS=AsqS+Asq; varIS=varIS+varI; meanIS=meanIS+meanI; nIzS=nIzS+nIz; nIzpS=nIzpS+nIzp;
%    p=GoldsteinUnwrap2D(Uout, mask);
    p=angle(Uout); p=unwrap(p,[],2); p=unwrap(p,[],1);
     
     varp = var(p(:)); meanp = mean(p(:));
     varP = varP + varp; 
     Var_p = .78*Cn2*(k^2)*Dz*(((2*pi)/Lout)^(-5/3)); 

     Cn2_dl = varp/(.78*(k^2)*Dz*(((2*pi)/Lout)^(-5/3)));
     Rytov_dl=0.312* Cn2_dl * k^(7/6) * Dz^(11/6); Rytov_TH=0.312* Cn2 * k^(7/6) * Dz^(11/6);
     
 fprintf('%1d, %.1f, %.2e, %.3f, %.3f, %.3f, %.3f, %.3f\n',...
      itrial, Rytov,Cn2,r0,Rytov_dl,Rytov_TH,varp, Var_p);
  % fprintf('Trial=%1d, Rytov=%.1f, Cn2=%.2e, r0=%.3f, Rytov_dl=%.3f, Rytov_TH=%.3f, varphz_sh=%.3f, Var_p=%.3f\n',...
   %   itrial, Rytov,Cn2,r0,Rytov_dl,Rytov_TH,varphz_sh, Var_p);
end 
  
%varI=varIS/ntrial; meanI=meanIS/ntrial;nIz=round(nIzS/ntrial);nIzp=nIzpS/ntrial;
varp=varP/ntrial; 


corrphz = corr2_ft(phz_SH,phz_SH,mask, deltax);
norcorrphz = corrphz./(max(corrphz(:)));
%d_sfphz = str_fcn2_ft(phz_SH, mask, deltax); 


%Rms_p = sqrt(Var_p);
%Rytov_Theoretical=0.312* Cn2 * k^(7/6) * Dz^(11/6);
%%r0_DL= (.423*k^2*Cn2.*deltaz).^(-3/5);

subplot(2,2,1); imagesc(nn*deltax, nn*deltax, p); colorbar; title(sprintf('Phase SH, Cn2=%.1e',Cn2));
%subplot(2,2,2); imagesc(nn*deltax, nn*deltax, d_sfphz); colorbar; title('Phase Structure Function');   
%subplot(2,2,2); imagesc(nn*deltax, nn*deltax, norcorrphz); colorbar; title('Correlation');
%subplot(2,2,3); plot(x(N/2,:), norcorrphz(N/2,:)); xlabel({'Screen Size (m)','x(N/2,:)'}); xlim([-d/2,d/2-1]) ;ylabel('Autocorrelation')
%subplot(2,2,4); plot(y(:,N/2), norcorrphz(:,N/2)); xlabel({'Screen Size (m)','y(:,N/2)'}); xlim([-d/2,d/2-1]) ;ylabel('Autocorrelation')
end