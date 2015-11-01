pkg load signal
M=20;
Fs = 100;%Sampling Freq
ts=0:1/Fs:1;
Fc= 45.688;
xs=sin(2*pi*Fc*ts);

xup=upsample(xs,M);

tsup=0:1/Fs/M:1;

blp=sinc(Fs*(tsup(1:400)-.1));
xup=upsample(xs,M);

bhld=ones(M,1);

figure(1)
hold off
xhld=filter(bhld,1,xup);
stem(xup(1:200))
hold on
plot(xhld(1:200), 'r')
legend('DAC ideal', 'DAC real')

yfilt=filter(blp,1,xup);
yfilt2=filter(blp,1,xhld)/M;

figure(2)
hold off
plot(yfilt)
hold on
plot(yfilt2, 'r')
legend('DAC ideal', 'DAC real')