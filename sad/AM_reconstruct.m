% Load signal processing package
pkg load signal
Fs = 80;	%Sampling Freq: 80Hz = Fmax/4
ts=0:1/Fs:1;
Fc=310; Fmod=8; % Carrier and modulation frequency
% sampled signal
xs=10*sin(2*pi*Fc*ts) + 2*sin(2*pi*(Fc-Fmod)*ts)+2*sin(2*pi*(Fc+Fmod)*ts); % 20% modulation index
plot(ts,xs)
title('sinal sub-amostrado')
M=10; 		% up-sampling factor
%”Up sampling”
xup=upsample(xs,M);
Fsup=Fs*M;
up=0:1/Fsup:1.1;
tup=up(1:length(xup));
plot(tup,xup)
Fmin=300; Fmax=320; 	% PBF filter limits
% IIR Digital Filter
[b,a]=butter(10,[Fmin/Fsup, Fmax/Fsup]);
% Filter signal xup
yfilt=filter(b,a,xup);
figure(2)
plot(tup,yfilt)
title('sinal reconstruido')
figure(3)
s=10*sin(2*pi*Fc*tup) + 2*sin(2*pi*(Fc-Fmod)*tup)+2*sin(2*pi*(Fc+Fmod)*tup);
plot(tup,s)
title('sinal original')
