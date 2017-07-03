function g = ift1D( G, delta_f )
 N=length(G); 
 g = ifftshift(ifft(ifftshift(G)))*(N*delta_f); 
end