clear; 
% Written by V. Kumar (vkumar@utep.edu), most functions adopted from J. Schmidt book
global flag; 
Lin = 5e-3; Lout=10; isave=2; flag='mvK'; deltax = 1e-3;   wvl=0.532e-6; Dz=10e3; 
N=512; %1024*2; %512;
RytovV=0.1; %[.1:.1:1 1.5 2 2.5 3]; % Rytov=0.312 * k^(7/6) * Dz_s^(11/6) * Cn2;
ntrial=1; %10; 
nscreen=20;
kpowV=22/6; %[19:23 23.2:.2:23.8]/6; %[20:24]/6
if(isave>0) saveDir=['Saved/' date() '_' flag]; [suc,mesg,msgid]=mkdir(saveDir);   end

%PlotAll(.1,kpowV,'Saved/15-Jul-2016',1,1); return;

for kpow=kpowV
    
    
if(isave>0) 
    %saveDir=['Saved/' date() '_' flag]; [suc,mesg,msgid]=mkdir(saveDir);  
    fout=sprintf('%s/Output_%.1f.csv',saveDir,6*kpow); ftype='w'; fileID = fopen(fout,ftype);
    if(ftype=='w') fprintf(fileID,'ntrial, N, Rytov, Cn2, n(I<1%%), n(%%), meanI, varI, 6*kpow\n'); end
end;

for Rytov=RytovV; 
tic

  z=linspace(0,Dz,nscreen);  deltaz=z(2)-z(1); deltaf=1/(N*deltax); 
  k=2*pi/wvl; nn=(-N/2:N/2-1);  [nx, ny] = meshgrid(nn); 
  nsq = nx.^2 + ny.^2; fsq=(nx*deltaf).^2+(ny*deltaf).^2;  
  %mu=0;factor=(1+mu/2)*(1+mu/5)*Lout^(-mu/3); r0b=r0^(1-(mu/3))/(5/3+mu/3)*factor^(1/(5/3+mu/3)); 
  Q2 = exp(-1i*pi^2*2*deltaz*fsq/k); 

AsqS = zeros(N,N); varIS=0; meanIS=0; nIzS=0; nIzpS=0;
if(isave==2) 
    fileID2 = fopen(sprintf('%s/Output_%.1f_%.1f.csv',saveDir,6*kpow,Rytov),'w');
    fprintf(fileID2,'itrial, Rytov, Cn2, n(I<1%%), n(%%), varI, 6*kpow\n'); 
end;
for itrial=1:ntrial % Note: ntrial still need fixing
  Uin=ones(N,N); g=Uin; G=zeros(N,N); phz=G;  
  for idx=1:nscreen-1
    %[phz, r0, Cn2]=Phase_Turb(Rytov,wvl,N,deltax,deltaz, Dz,Lout,Lin,22/6); 
    [phz, r0, Cn2]=Phase_TurbAlpha(Rytov,wvl,N,deltax,deltaz, Dz,Lout,Lin,kpow); 
    G=Q2.*fftshift(fft2(fftshift(g)))*deltax^2;   
    g = ifftshift(ifft2(ifftshift(G)))*(N*deltaf)^2; 
    g = exp(1i*phz) .* g; % alter the phase
    %fprintf('Screen %d [z=%.0f] [mean(phz), var(phz)]=%.1e %.1e \n',idx, z(idx), mean(phz(:)),var(phz(:)) );
  end
  Uout = g; Asq=abs(Uout).^2; varI=var(Asq(:)); meanI=mean(Asq(:)); 
  nIz=sum(Asq(:)<max(Asq(:))/100); nIzp=100*nIz/(N*N);
  AsqS=AsqS+Asq; varIS=varIS+varI; meanIS=meanIS+meanI; nIzS=nIzS+nIz; nIzpS=nIzpS+nIzp;
  %varT(1,itrial)=varIS; varT(2,itrial)=varIS/Rytov;
  fprintf('Trial=%1d, Rytov=%.1f, Cn2=%.1e, r0=%.1f, n(Iz<1%%Imax)=%d, nIz%%=%.1f, varI=%.2f, varI/Rytov=%.2f\n',...
      itrial, Rytov,Cn2,r0,nIz,nIzp,varI, varI/Rytov);
  if(isave==2) fprintf(fileID2,'%d, %.1f, %.1e, %d, %.2f, %.2f, %.2f\n',itrial, Rytov,Cn2,nIz,nIzp,varI,kpow*6); end
end; % ntrial

if(isave==2) fclose(fileID2); end;
%Asq=AsqS/ntrial; 
varI=varIS/ntrial; meanI=meanIS/ntrial;nIz=round(nIzS/ntrial);nIzp=nIzpS/ntrial;

p=angle(Uout); p=unwrap(p,[],2); p=unwrap(p,[],1);

subplot(2,1,1); imagesc(nn*deltax, nn*deltax, Asq); colorbar; title(sprintf('Intensity, Cn2=%.1e',Cn2)); 
subplot(2,1,2); imagesc(nn*deltax, nn*deltax, p); colorbar; title('unwrap(Phase)'); 

fprintf('Trials=%1d, [Rytov Cn2 r0 alpha]=[%.1f, %.1e, %.1f, %.2f], n(Iz<1%%Imax)=[%d, %.1f%%], time=%.2f, I[%.1f, %.2f, %.2f]\n', ...
    ntrial, Rytov,Cn2,r0,kpow,nIz,nIzp,toc,meanI,varI, varI/Rytov);
%fprintf('meanI=%.1f, varI=%.1e, varI/Rytov=%.2f \n',meanI,varI, varI/Rytov); 

if(isave>0) 
    fprintf(fileID,'%d, %d, %.1f, %.1e, %d, %.2f, %.2f, %.2f, %.2f\n',ntrial, N,Rytov,Cn2,nIz,nIzp,meanI,varI,kpow*6); 
    fig=figure(1);  saveas(fig,sprintf('%s/Rytov_%.1f_plot_%.1f.jpg',saveDir,Rytov,(kpow*6)),'jpg'); 
    s1.Uout=Uout; s1.ntrial=ntrial; s1.Rytov=Rytov; s1.Cn2=Cn2; s1.nIz=nIz; s1.meanI=meanI; s1.varI=varI; s1.kpow=kpow; 
    save(sprintf('%s/Output_%.1f_%.1f.mat',saveDir,Rytov,(kpow*6)), '-struct', 's1');
end

end % Rytov
if(isave>1) fclose(fileID); end;

end; %kpow

      
