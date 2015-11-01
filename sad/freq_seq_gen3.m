%http://www.tty1.net/blog/2009/audio-with-gnu-octave_en.html
%freq_seq96_32b
%ffmpeg -f concat -i mylist.txt -c copy freq_seq.wav
%ffmpeg -i freq_seq96.wav -acodec flac -compression_level 6 -y freq_seq96.flac 
clear
bps = 32;%16;       % bits per sample
%
% Flaccompress
% ffmpeg -i "freq_seq96_32b.wav" -acodec flac -compression_level 6 -y "freq_seq96_32.flac"
sps = 96000;        % sample rate [samples/s]
freq_start = 1300;   % tone Start frequency  [Hz] Must be Integer!
dfreq = 10;  		% Freq step Must be Integer!
freqBeep=sps/100.; 	% Beep frequency ~ 900Hz
wa=sps/100.; 		% duration of Beep = 10 ms

%
nsecs = 10;         % number of seconds per step

N_STEPS =21;

%a = freq * floor(nsecs * sps / freq)  %floor(.5 *nsamples); Samples per phase
a= sps * nsecs
time = (1:a) / sps;
% Beep wave generation
wave   = .99*sin(time * 2 * pi * freqBeep);
%ramp up; beep; ramp down windows
window = [zeros(1, a - 3*wa), linspace(0,1,wa), ones(1, wa), linspace(1,0,wa)];
waveL = wave .* window;

waveRC = []; waveLC = [];
freq = freq_start
for i=1:N_STEPS
	wave   = .99*sin(time * 2 * pi * freq);
	waveRC = [waveRC wave];
	%window = [linspace(0,1,a), ones(1,nsamples-a-b), linspace(1,0,b)]';	
	waveLC = [waveLC waveL];
%	window = [];
	freq = freq + dfreq
	fflush(stdout);
end
%
lfreq = freq - dfreq;

%
Y = [waveLC' waveRC'];
fn=sprintf("freq_seq_%d_%d.wav",freq_start,lfreq);
wavwrite(Y, sps, bps, fn);

%waveChirp = .99*chirp(time, freq, time(b), 12000+freq);
% create the amplitude window (creates the fade in and fade out when multiplied with the sine wave)
%a = b = floor(.3*nsamples);
%window = [linspace(0,1,a), ones(1,nsamples-a-b), linspace(1,0,b)]';
%a = sps; % one second floor(.48*nsamples);
%b = 10 * floor(sps / freq); %floor(.5 *nsamples);

%wave = [zeros(1,a), waveChirp, zeros(1,sps -b), waveChirp, zeros(1,sps -b)]';

%window = [zeros(1,a), ones(1, b), zeros(1,sps -b), ones(1, b), zeros(1,sps -b)]';

%wavwrite(wave, sps, bps, 'sonar_chirp.wav')
%>afplay audio.wav -d
% play (sox){[]}