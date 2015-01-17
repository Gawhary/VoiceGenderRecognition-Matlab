function [ mp, fp, tp ] = maleFemalePower( xn, fs)
xn=xn(:,1);

xn=echoCancelling(xn, fs);
% 
% threshold1 = max(abs(xn))*0.2;
% % threshold2 = max(abs(xn))*0.9;
% xn(abs(xn)<threshold1) = 0;
% % xn(abs(xn)>threshold2) = 0;


nf=fs/10; %number of point in DTFT
Y = fft(xn,nf);
f = fs/2*linspace(0,1,nf/2+1);

g = gausswin(11); % <-- this value determines the width of the smoothing window
g = g/sum(g);
y2 = conv(Y, g, 'same');
ff = abs(y2(1:nf/2+1));

plot(ff);
 
mp = sum(ff(85:165));
fp = sum(ff(180:255));
tp = sum(ff);

end

