function G = ft(g, delta)

G = fftshift(fft(fftshift(g)))*delta;