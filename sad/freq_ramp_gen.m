%http://www.tty1.net/blog/2009/audio-with-gnu-octave_en.html
%pkg load signal
%ffmpeg -f concat -i mylist.txt -c copy freq_ramp.wav
%ffmpeg -i freq_ramp_300_3000.wav -acodec flac -compression_level 12 -y freq_ramp_300_3000.flac 

clear
bps = 32;%16;       % bits per sample
sps = 96000;        % sample rate [samples/s]
freq_start = 790;   % tone Start frequency  [Hz]
dfreq = 10;  		% Freq step
freqBeep=sps/100.; 	% Beep frequency ~ 900Hz
wa=sps/100.; 		% duration of Beep = 10 ms

%
nsecs = 10;         % number of seconds per step

N_STEPS = 50;

%a = freq * floor(nsecs * sps / freq)  %floor(.5 *nsamples); Samples per phase
a = sps * nsecs
time = (1:a) / sps;
% Beep wave generation
wave   = .99*sin(time * 2 * pi * freqBeep);
%ramp up; beep; ramp down windows
window = [zeros(1, a - 3*wa), linspace(0,1,wa), ones(1, wa), linspace(1,0,wa)];
waveL = wave .* window;
waveLC = [];
for i=1:N_STEPS
	waveLC = [waveLC waveL];
end

totalsamp = a  * N_STEPS
time = (1:totalsamp) / sps;
freq_end = freq_start + dfreq * (N_STEPS-1)
%waveSin = .99*sin(time*2*pi*freq);
waveRC = .99*chirp(time, freq_start, time(end), freq_end,'linear',-90);

fn=sprintf("freq_ramp_%d_%d.wav",freq_start,freq_end); ...

%Y = [waveLC' waveRC'];
%wavwrite(Y, sps, bps, 'freq_ramp.wav');

