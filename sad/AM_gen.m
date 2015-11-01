%http://www.tty1.net/blog/2009/audio-with-gnu-octave_en.html
%pkg load signal
%ffmpeg -f concat -i mylist.txt -c copy freq_ramp.wav
%ffmpeg -i freq_ramp_300_3000.wav -acodec flac -compression_level 12 -y freq_ramp_300_3000.flac 

clear
bps = 16;       % bits per sample
sps = 96000;        % sample rate [samples/s]
freq_carier = 1200;   % tone  frequency  [Hz]
freq_mod = 12;   % modulating  frequency  [Hz]
mod_factor=0.5;

%
nsecs = 1;         % number of seconds 


%a = freq * floor(nsecs * sps / freq)  %floor(.5 *nsamples); Samples 

a = freq_carier * 80
time = (1:a) / sps;
% Beep wave generation
Amplit =  sin(time * 2 * pi * freq_mod) + 0.5 * sin(time * 4 * pi * freq_mod) - 0.3 * sin(time * 6 * pi * freq_mod);
Amplit = (1.0 + mod_factor * Amplit)/2.0;
wave   = .99*sin(time * 2 * pi * freq_carier) .* Amplit ;

Y = [wave' wave'];


