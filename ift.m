function g = ift(G, delta_f)

g = ifftshift(ifft(ifftshift(G)))*length(G)*delta_f;