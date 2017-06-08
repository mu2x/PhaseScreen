clear; 
% Written by V. Kumar (vkumar@utep.edu)


Dir='../DATA/riptide/01-Aug-2016_noise_0'; 
ODir=sprintf('%s/Entropy',Dir); [suc,mesg,msgid]=mkdir(ODir);
nbins=100; %[20:20:100 200:100:1000]; 
mfile2=sprintf('%s/Output_%.1f_%.1f.mat',Dir,.1,6*22/6);
load(mfile2); U0=Uout; Asq0=abs(U0.^2);  N=size(Asq0,1); ii=0;
for kpow=[22/6]; %[19:23 23.8]/6; %[19:23 23.2:.2:23.8]/6;
    for Rytov=[.1]; %[.1 .2 .4 .8 1 1.5 2 2.5 3] % [.1 1:.5:3]; %[.1:.1:1 1.5 2 2.5 3];
        mfile=sprintf('%s/Output_%.1f_%.1f.mat',Dir,Rytov,6*kpow);
        ii=ii+1; 
        load(mfile); Asq=abs(Uout.^2); 
        minI=0; maxI=max(Asq(:)); varI0=var(Asq0(:)); varI=var(Asq(:));
        u=Asq(:); v=Asq0(:);  ub=mean(u); vb=mean(v);
        for nbins=[100:500:1000]
         dI=(maxI-minI)/nbins; bins=[0:nbins-1]*dI+(minI+dI/2);
         [n r]=hist(Asq0(:),bins); p0=n/sum(n);  
         [n r]=hist(Asq(:),bins); p=n/sum(n);  
         Db = -log(sum(sqrt(p0.*p))); %S=-log(p./r)*p'; 
         Db2=(1/4)*log((1/4)*((varI/varI0)^2 + (varI0/varI)^2 +2)); 
         r_corr=sum((u-ub).*(v-vb))/sqrt(sum((u-ub).^2)*sum((v-vb).^2)); 
         fprintf('[%.4f, %.4f, %.4f], ',Db, Db2, r_corr); 
         dvsr(ii,1)=Rytov; dvsr(ii,2)=r_corr;
        end
        fprintf('\n'); 
        figure(1); hist(Asq(:),bins); axis([0 10 0 inf]);
        xlabel('Intensity'); ylabel('Distribution'); title(sprintf('Entropy, 1000bins, %.1f-%.1f/6',Rytov,6*kpow));
        
        %figure(2); plot(nbins,SS); xlabel('nbins'); ylabel('Entropy'); title(sprintf('Rytov=%.1f, alpha=%.1f/6',Rytov,6*kpow)); 
%         fig=figure(1);  saveas(fig,sprintf('%s/Hist_Rytov_%.1f_plot_%.1f.jpg',ODir,Rytov,(kpow*6)),'jpg');
%         fig=figure(2);  saveas(fig,sprintf('%s/Entropy_Rytov_%.1f_plot_%.1f.jpg',ODir,Rytov,(kpow*6)),'jpg');
%         csvwrite(sprintf('%s/Entropy_%.1f.csv',ODir,6*kpow),plotD)
    end
end