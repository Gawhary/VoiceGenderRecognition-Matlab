function [marea, farea, ambarea] = smooth_fft_spectrum(xn,fs)
nf=fs/10; %number of point in DTFT
Y = fft(xn,nf);
f = fs/2*linspace(0,1,nf/2+1);

g = gausswin(11); % <-- this value determines the width of the smoothing window
g = g/sum(g);
y2 = conv(Y, g, 'same');
ff = abs(Y(1:nf/2+1));

plot(f,ff);

end