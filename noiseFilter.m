% Read in the file
clear all;
close all;
[filename, pathname, filterindex] = uigetfile( ...
{  '*.wav','WAV-files (*.wav)'; ...
   '*.*',  'All Files (*.*)'}, ...
   'Pick a file');

[f,fs] = audioread(fullfile(pathname,filename));
N = size(f,1);
%% Play original file
pOrig = audioplayer(f,fs);
pOrig.play;


%% Design a bandpass filter that filters out between 700 to 12000 Hz
n = 7;
beginFreq = 700 / (fs/2);
endFreq = 12000 / (fs/2);
[b,a] = butter(n, [beginFreq, endFreq], 'bandpass');

%% Filter the signal
fOut = filter(b, a, f);

plot(fOut);

%% Construct audioplayer object and play
p = audioplayer(fOut, fs);
p.play;