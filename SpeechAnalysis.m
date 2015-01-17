 function [medianfx, stdfx, mEnrgy, fEnrgy, tEnrgy] = speechAnalysis(f,fs)
x1 = f(:,1);

% x1=echoCancelling(x1, fs);
% 
% threshold1 = max(abs(f))*0.2;
% threshold2 = max(abs(f))*0.9;
% f(abs(f)<threshold1) = 0;
% f(abs(f)>threshold2) = 0;
% 
% x1=f;

% sound(x1,fs);
ms2=floor(fs*0.002);
ms10=floor(fs*0.01);
ms20=floor(fs*0.02);
ms30=floor(fs*0.03);
% % plot waveform
% t=(0:length(x1)-1)/fs;
% subplot(3,1,1);
% plot(t,x1);
% legend('Waveform');
% xlabel('Time (s)');
% ylabel('Amplitude');
% h = fir1(128, 0.075);        %lavepass filter
% x = conv(x1, h);              %output of the lavepass filter
x=x1;
% w = hamming(ms20); 
% nw = length(w);  
% process in chunks
pos=1;
fx=[];
%energy=[];
cou=1;
while (pos+ms30) <= length(x)
    y=x(pos:pos+ms30-1);
%     y=y-mean(y);
    energy(cou)= sum(abs(y)); % energy= [energy 10*log10(dot(y,y))];  % calculate energy
    ethr = 0.1*energy(cou);
%     r=xcorr(y,ms20,'coeff');      % calculate autocorrelation
    r=y;
%     r=r(ms20+1:2*ms20+1);          %half part of r
    [rmax,fxval]=max(abs(r(ms2:ms20))); % search for maximum  between 2ms (=500Hz) and 20ms (=50Hz)
    if (rmax > 0.6 && energy(cou) > ethr) 
        fx= [fx fs/(ms2+fxval-1)];
    else
        fx= [fx NaN];
    end;
    cou = cou +1;
    pos=pos+ms10;
end;
cou = cou-1;

gx =[];
j=1;
mEnrgy = 0;
fEnrgy = 0;
tEnrgy = sum(energy);
for i= 1:length(fx)
    if (fx(i)>85 && fx(i)<255)
        gx(j)=fx(i);
        j=j+1;
        
        if(fx(i) < 165)
            mEnrgy = mEnrgy + energy(i); 
        elseif(fx(i) > 180)
            fEnrgy = fEnrgy + energy(i);
        end
    end
end
medianfx=median(gx);
stdfx=std(gx);
% 
% % plot FX trace
% t=(0:length(fx)-1)*0.01;  %length(fx)=cou
% subplot(3,1,2);
% plot(t, fx,'.');
% legend('FX Trace'); %legend('energy')
% xlabel('Time (s)');
% ylabel('Frequency (Hz)'); 
% t=(0:length(fx)-1)*0.01;
% subplot(3,1,3); plot(t,energy);
% xlabel('Time (s)');
% ylabel('energy dB')
%  %keyboard
%  t1= (0:ms20)/fs;
% % subplot(4,1,4);
% % plot(t1,r);
% % legend('Autocorrelation');
% % xlabel('Time (s)');
% % ylabel('coeff');
% % 
% % fprintf('fx=%gHz\n',medianfx);  %  rmax=%g  ,rmax,
% % 
% % if (medianfx <= 205)
% %     fprintf ('this is male')
% %         
% % else if (medianfx >205 && stdfx> 50)
% %     fprintf('this is female')
% %    
% %     else 
% %     fprintf('this is female')
% %     end
% % end;
% % % figure
% % % hist(fx)

end