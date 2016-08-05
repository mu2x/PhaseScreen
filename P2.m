Dir='Saved/01-Aug-2016_noise_0'; 
RytovV=[.1:.1:1 1.5 2 2.5 3]; 
kpowV=[19:23 23.2:.2:23.8]/6; 
iplot=0; 
  for kpow=kpowV    
    fid=fopen(sprintf('%s/MinMaxI_%.1f.csv',Dir,6*kpow), 'w');  
    fprintf('%s/MinMaxI_%.1f.csv\n',Dir,6*kpow); 
    fprintf(fid,'Rytov, meanI1,minI1,maxI1,meanI2,minI2,maxI2,meanI21,minI21,maxI21\n'); 
    fprintf('Rytov, meanI1,minI1,maxI1,meanI2,minI2,maxI2,meanI21,minI21,maxI21\n'); 
    for Rytov=RytovV;     
      f=sprintf('%s/Output_%.1f_%.1f.csv',Dir,6*kpow,Rytov);  
      d=csvread(f,1,0); 
      d1=d(:,8); d2=d(:,9); d21=d(:,9)./d(:,8); 
      fprintf('%.1f, %.1e, %.1e, %.1e, %.2f, %.2f, %.2f, %.1e, %.1e, %.1e\n',...
         Rytov, mean(d1), min(d1), max(d1), mean(d2), min(d2), max(d2), mean(d21), min(d21), max(d21));
      fprintf(fid,'%.1f, %.1e, %.1e, %.1e, %.2f, %.2f, %.2f, %.1e, %.1e, %.1e\n',...
         Rytov, mean(d1), min(d1), max(d1), mean(d2), min(d2), max(d2), mean(d21), min(d21), max(d21));
    end
    fclose(fid); 
  end
    

