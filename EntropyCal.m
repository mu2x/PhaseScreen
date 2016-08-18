clear; 
% Written by V. Kumar (vkumar@utep.edu)


RytovV= [.1 1:.5:3]; %[.1:.1:1 1.5 2 2.5 3]; % Rytov=0.312 * k^(7/6) * Dz_s^(11/6) * Cn2;
kpowV=[19:23 23.8]/6; %[19:23 23.2:.2:23.8]/6; %[20:24]/6 % Cn2 calculated using 22/6

Dir='../DATA/riptide/01-Aug-2016_noise_0'; 
ODir=sprintf('%s/Entropy',Dir); [suc,mesg,msgid]=mkdir(ODir);
nbins=[20:20:100 200:100:1000]; 
for kpow=kpowV
    ii=0; plotD(ii+1,:)=[0 nbins];
    for Rytov=RytovV;
        ii=ii+1; 
        mfile=sprintf('%s/Output_%.1f_%.1f.mat',Dir,Rytov,6*kpow);
        load(mfile); Asq=abs(Uout.^2); jj=0; plotD(ii+1,jj+1)=Rytov; 
        for ibin=nbins
            jj=jj+1; 
         [n r]=hist(Asq(:),ibin); p=n/sum(n); 
         S=-sum(log(r).*p); %S=-log(p./r)*p'; 
         SS(jj)=S; plotD(ii+1,jj+1)=S;
         fprintf('%.4f, ',S); 
        end
        fprintf('\n'); 
        figure(1); hist(Asq(:),1000); axis([0 10 0 inf]);
        xlabel('Intensity'); ylabel('Distribution'); title(sprintf('Entropy, 1000bins, %.1f-%.1f/6',Rytov,6*kpow));
        
        figure(2); plot(nbins,SS); xlabel('nbins'); ylabel('Entropy'); title(sprintf('Rytov=%.1f, alpha=%.1f/6',Rytov,6*kpow)); 
        fig=figure(1);  saveas(fig,sprintf('%s/Hist_Rytov_%.1f_plot_%.1f.jpg',ODir,Rytov,(kpow*6)),'jpg');
        fig=figure(2);  saveas(fig,sprintf('%s/Entropy_Rytov_%.1f_plot_%.1f.jpg',ODir,Rytov,(kpow*6)),'jpg');
        csvwrite(sprintf('%s/Entropy_%.1f.csv',ODir,6*kpow),plotD)
    end
end