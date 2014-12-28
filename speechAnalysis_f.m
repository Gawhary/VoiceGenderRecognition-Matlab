function [meanfx] = speechAnalysis_f(x1,fs,nb)
x1=x1(:,1);
%generate test tone:
% fs=12000;
% f=150;
% N=fs;
% n=0:N-1;
% x1=sin(2*pi*f*n/fs);
ms1=floor(fs*0.001);
ms2=floor(fs*0.002);
ms10=floor(fs*0.01);
ms20=floor(fs*0.02);
ms30=floor(fs*0.03);

% plot waveform
% t=(0:length(x1)-1)/fs;
% subplot(4,1,1);
% plot(t,x1);
% legend('Waveform');
% xlabel('Time (s)');
% ylabel('Amplitude');

h = fir1(128, 0.075);        %lavepass filter
x = conv(x1, h);              %output of the lavepass filter
len = length(x);
% nbFrame = floor((len - ms20) / ms10) + 1;
% for i = 1:ms20
%     for j = 1:nbFrame
%     M(i, j) = x(((j - 1) * ms10) + i);
%     end
% end
% w = hamming(ms20);
% M2 = diag(w) * M;  %calculate correlation.
% % for i = 1:nbFrame
% %     M3(:, i) = fft(M2(:, i));
% M3 = fft(M2);
% %end
% figure
% t = ms20 / 2;
% tm = length(x) / fs;
% subplot(1,2,1);
% imagesc([0 tm], [0 fs/12], abs(M3(1:t, :)).^2), axis xy;
% title('Power Spectrum (M = 100, N = 256)');
% xlabel('Time [s]');
% ylabel('Frequency [Hz]');
% colorbar;
% subplot(1,2,2);
% imagesc([0 tm], [0 fs/12], 20 * log10(abs(M3(1:t, :)).^2)), axis xy;
% title('Logarithmic Power Spectrum (M = 100, N = 256)');
% xlabel('Time [s]');
% ylabel('Frequency [Hz]');
% colorbar;
% 
% figure;
% % plot cepstrum
% f=[];
% C=fft(log(abs(M3(1:t,:))+eps));
% q=(ms1:ms20)/fs;
% subplot(3,1,3);
% plot(q,abs(C(ms1:ms20)));
% legend('Cepstrum');
% xlabel('Quefrency (s)');
% ylabel('Amplitude');
% [c,fx]=max(abs(C(ms1:ms20)));
% f=[f fs/(ms1+fx-1)];
% fprintf('Fx=%gHz\n',fs/(ms1+fx-1));

%  w= hamming(ms30);
%  nw=length(w);
% % process in chunks
pos=1;
fx=[];
cou=1;
 while (pos+ms30) <= length(x) 
    y=x(pos:pos+ms30-1);  
    y= y .*hamming(ms30);
    y1=y-mean(y);
    energy(cou)= 10*log10(dot(y1,y1)); % energy= [energy 10*log10(dot(y,y))];  % calculate energy
    ethr = 0.3*median(energy);
    r=xcorr(y1,ms20,'coeff');      % calculate autocorrelation
    r=r(ms20+1:2*ms20+1);          %half part of r
    [rmax,fxval]=max(abs(r(ms2:ms20))); % search for maximum  between 2ms (=500Hz) and 20ms (=50Hz)
    Y1=fft(y); % do fourier transform of framed signal  
    C=ifft(log(abs(Y1)+eps)); % cepstrum is IDFT of log spectrum
    [c,fxv]=max(abs(C(ms2:ms20)));
   
    if (rmax > 0.5 && energy(cou) > ethr) 
        fx= [fx fs/(ms2+fxv-1)];
    else
        fx= [fx NaN];
    end;
    cou = cou +1;
    pos=pos+ms10;
 end;
 cou = cou-1;

% plot spectrum of bottom 500Hz
% hz500=500*length(Y1)/fs;
% f=(0:hz500)*fs/length(Y1);
% subplot(4,1,2);
% plot(f,20*log10(abs(Y1(1:length(f)))+eps));
% legend('Spectrum');
% xlabel('Frequency (Hz)');
% ylabel('Magnitude (dB)');

% % plot between 2ms (=500Hz) and 20ms (=50Hz)
% q=(ms2:ms20)/fs;
% subplot(4,1,3);
% plot(q,abs(C(ms2:ms20)));
% legend('Cepstrum');
% xlabel('Quefrency (s)');
% ylabel('Amplitude');

gx =[];
j=1;
for i= 1:length(fx)
    if (fx(i)>0 && fx(i)<500)
        gx(j)=fx(i);
        j=j+1;
        
    end
end
meanfx=mean(gx);
 
% % plot FX trace
% t=(0:length(fx)-1)*0.01;  %length(fx)=cou
% subplot(4,1,4);
% plot(t, fx,'.');
% legend('FX Trace'); %legend('energy')
% xlabel('Time (s)');
% ylabel('Frequency (Hz)'); 



fprintf('Fx=%gHz\n',meanfx);%fs/(ms2+fxv-1));
end