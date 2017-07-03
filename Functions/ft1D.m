function G = ft1D( g,delta )
 G=fftshift(fft(fftshift(g)))*delta; 
end

