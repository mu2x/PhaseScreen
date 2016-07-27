function iplot = PlotAll(RytovV,kpowV,Dir,f,flag)
% Written by V. Kumar (vkumar@utep.edu)
  close all; 

%RytovV=[.1:.1:1 1.5 2 2.5 3]; 
%kpowV=[19:23 23.2:.2:23.8]/6; 
iplot=0; 
  for kpow=kpowV    
    f=sprintf('%s/Output_%.1f.csv',Dir,6*kpow);  iplot=iplot+1;
    d=csvread(f,1,0); X(:,iplot)=d(:,3); Y1(:,iplot)=d(:,6); Y2(:,iplot)=d(:,8);
    D=3*(1-kpow)+11; ptype='-'; if(iplot>5) ptype='-.'; end
    L1(iplot,:)=sprintf('\\alpha=%.1f/6, D=%.1f',6*kpow, D); 
    figure(1); plot(d(:,3),d(:,6),ptype); hold on;
    figure(2); plot(d(:,3),d(:,8),ptype); hold on;
    figure(3); semilogx(d(:,4),d(:,6),ptype); hold on;
    figure(4); semilogx(d(:,4),d(:,8),ptype); hold on;    
    %for Rytov=RytovV;     end
  end
    
 figure(1); legend(L1,'Location','SouthEast'); xlabel('Rytov, \sigma_\chi^2'); ylabel('zero Inten(%)'); 
 figure(2);legend(L1,'Location','SouthEast'); xlabel('Rytov, \sigma_\chi^2'); ylabel('var(Inten)');
 figure(3);legend(L1,'Location','SouthEast'); xlabel('C_n^2'); ylabel('zero Inten(%)');
 figure(4);legend(L1,'Location','SouthEast'); xlabel('C_n^2'); ylabel('var(Inten)');

 fig=figure(1);  saveas(fig,sprintf('%s/Rytov_nIz.jpg',Dir),'jpg');
 fig=figure(2);  saveas(fig,sprintf('%s/Rytov_varI.jpg',Dir),'jpg');
 fig=figure(3);  saveas(fig,sprintf('%s/Cn2_nIz.jpg',Dir),'jpg');
 fig=figure(4);  saveas(fig,sprintf('%s/Cn2_varI.jpg',Dir),'jpg');
end