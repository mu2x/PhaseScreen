clear; 
N=100; mask=ones(N,1); delta=1/N; 
x=10*pi*linspace(0,1,N); x=x'; 
u1=sin(x); u2=sin(x)+rand(N,1)/10; 
c=corr1D_ft(u1,u2,mask,1/N); 
plot(c)
