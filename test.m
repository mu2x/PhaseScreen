clear
wvl=1e-6; k=2*pi/wvl; L=10000; delta=1e-3; Rytov=.1; 

jj=0; 
for Rytov=[.1 .5 1 2 10]
    ii=0;jj=jj+1; 
  for i=1:20:400; 
    ii=ii+1; 
    r=i*delta; sR=(4*Rytov)^(1/2); 

    ny=3*(1+.69*sR^(12/5)); nx=2.61/(1+1.11*sR^(12/5)); 

    t1=0.49*sR^2/(1+1.11*sR^(12/5))^(7/6) * genHyper(7/6,1,-k*r^2*nx/(4*L));
    t2=0.5*sR^2/(1+.69*sR^(12/5))*(k*r^2*ny/L)^(5/12) * besselk(5/6,sqrt(k*r^2*ny/L));
    B=exp(t1+t2)-1; 
    x(ii,jj)=r; 
    y(ii,jj)=B; 
    Leg(jj,1)=Rytov; Leg(jj,2)=sR;
  end
end
x1=sqrt(k/L)*x(:,1); x2=sqrt(k/L)*x(:,2); x3=sqrt(k/L)*x(:,3); x4=sqrt(k/L)*x(:,4); x5=sqrt(k/L)*x(:,5);
y1=y(:,1); y2=y(:,2); y3=y(:,3); y4=y(:,4); y5=y(:,5);

plot(x1,y1/max(y1),  x3,y3/max(y3), x5,y5/max(y5)  ); 

s1=sprintf('Rytov=%.2f, sigmaR-book=%.2f',Leg(1,1), Leg(1,2)); 
s2=sprintf('Rytov=%.2f, sigmaR-book=%.2f',Leg(3,1), Leg(3,2)); 
s3=sprintf('Rytov=%.2f, sigmaR-book=%.2f',Leg(5,1), Leg(5,2)); 
legend(s1,s2,s3)

