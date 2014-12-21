function [ y ] = speechFrequency( f,fs)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
f=f(:,1);
m=0;
% m = mean(f);
% threshold = mean(abs(f));
% f(abs(f)<threshold) = m;
l=length(f);
plot(f);
%zeropos=zeros(l);
c=0;

% sound(f,fs)
%f_3 = zeros(l);

f_3=f;

% for i=1 : (l-6)
%     f_3(i+3)=(f(i)+f(i+1)+f(i+2)+f(i+3)+f(i+4)+f(i+5)+f(i+6))/7;
% end
sound(f_3,fs);
plot(f_3);
c=0;
zeropos=0;
for j=1 : l-4
    if(f_3(j)<m&&f_3(j+1)>=m)
        c=c+1;
        zeropos(c)=j;
    end
end


% calculate remove silence
minSilentPeriod=fs/20;
minSpeakPeriod=fs/500;
sl = l;
if (zeropos(1) > minSilentPeriod)
    sl = sl - zeropos(1); 
end
factor=2/max(abs(f));
sc = c
ampP=1;
for p=2:length(zeropos)
    d = zeropos(p)-zeropos(p-1) ;
    if( d > minSilentPeriod)
       sl = sl-d;
        sc = sc-1;
    elseif(d < minSpeakPeriod)
        sc = sc-1;
        sl = sl-d;
    else
        amp = max(abs(f_3(zeropos(p-1):zeropos(p))));
        ambAtPos(ampP) = amp*factor;
        ampP = ampP + 1;
    end
end
x2 = sum(ambAtPos);
d = l-zeropos(length(zeropos));
if( d > minSilentPeriod)
    sl = sl-d;
end
if(sl==0 || c==0)
    y=0;
    return;
end
t=l/fs;
st=sl/fs;
y=x2/st;
% y=sc/st;


end

