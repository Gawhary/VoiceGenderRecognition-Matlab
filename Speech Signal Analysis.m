ms20=fs/50;                 % minimum speech Fx at 50Hz

%

% plot waveform

t=(0:length(x)-1)/fs;        % times of sampling instants

subplot(2,1,1);

plot(t,x);

legend('Waveform');

xlabel('Time (s)');

ylabel('Amplitude');

%

% calculate autocorrelation

r=xcorr(x,ms20,'coeff');   

%

% plot autocorrelation

d=(-ms20:ms20)/fs;          % times of delays

subplot(2,1,2);

plot(d,r);

legend('Autocorrelation');

xlabel('Delay (s)');

ylabel('Correlation coeff.');

 