function [ y, mc,fc,ac ] = speechFrequency( f,fs)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
f=f(:,1);
m=0;
m = mean(f);
threshold1 = max(abs(f))*0.2;
threshold2 = max(abs(f))*0.8;
f(abs(f)<threshold1) = 0;
f(abs(f)>threshold2) = 0;
l=length(f);
plot(f);
c=0;

% sound(f,fs)
%f_3 = zeros(l);

f_3=f;
% 
% for i=1 : (l-6)
%     f_3(i+3)=(f(i)+f(i+1)+f(i+2)+f(i+3)+f(i+4)+f(i+5)+f(i+6))/7;
% end
sound(f_3,fs);
plot(f_3);
c=0;
zeropos=0;
for j=1 : l-4
    if(f_3(j)<0&&f_3(j+1)>=0)
        c=c+1;
        zeropos(c)=j;
    end
end


% calculate remove silence
minSilentPeriod=fs/75;
minSpeakPeriod=fs/275;
maleMinL = fs/165;
femaleMaxL = fs/180;
mc = 0;
fc = 0;
ac = 0;
sl = l;
if (zeropos(1) > minSilentPeriod)
    sl = sl - zeropos(1); 
end
sc = c
% ampP=1;
% ambAtPos = 0;
% D=0;
for p=2:length(zeropos)
    d = zeropos(p)-zeropos(p-1) ;
    freq(p)=fs/d;
    if( d > minSilentPeriod)
       sl = sl-d;
        sc = sc-1;
    elseif(d < minSpeakPeriod)
        sc = sc-1;
        sl = sl-d;
    else
        if(d > maleMinL) 
            mc = mc +1;
        elseif(d < femaleMaxL)
            fc = fc+1;
        else
            ac = ac +1;
        end
%         amp = mean(abs(f_3(zeropos(p-1):zeropos(p))));
%         ambAtPos(ampP) = amp;
%         D(ampP) = d;
%         ampP = ampP + 1;
        
    end
end

d = l-zeropos(p);
if( d > minSilentPeriod)
    sl = sl-d;
end

plot([1:length(freq)], freq);

% factor=2/max(ambAtPos);
% ambAtPos = ambAtPos*factor;
% D = D / sl;
% D = D * 2/max(D);
% x2 = sum(ambAtPos.*(D));
% x2 = sum(ambAtPos);

if(sl==0 || sc==0)
    y=0;
    return;
end
% t=l/fs;
st=sl/fs;
% y=x2/st;
y=sc/st;


end

