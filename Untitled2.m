h = fir1(128, 0.001);        %lavepass filter
x = conv(f, h);              %output of the lavepass filter
subplot(2,1,1);
plot(f);
subplot(2,1,2);
plot(x);