pkg load signal
Fs=100;
Fsig=20;
t=0:1/Fs:1;
s=sin(2*pi*Fsig*t);
%Amostras do sinal
stem(t,s)
xlabel 'tempo(s)'
M=10; % upsample factor
sup=upsample(s,M);
figure
tup=0:1/Fs/M:1.009;
stem(tup,sup)
%filtro passa-baixo, freq de corte 1/M*FNyq
[b,a] = butter(15, 1/M);
%resposta impulsional do filtro
impulse=[1;zeros(199,1)];
figure
impresp=filter(b,a,impulse);
stem(impresp)
title 'LPF Impulse Response'	
%sinal reconstruido
figure
yfilt=filter(b,a,sup);
plot(tup,yfilt)
title 'Sinal reconstruido'
xlabel 'tempo(s)'	
	