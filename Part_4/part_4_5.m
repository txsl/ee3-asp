close all; clear; clc;

%% 4.5.1

Fs = 44100;
N = 1000;
t = Fs/N;

recObj = audiorecorder(Fs, 16, 1);

input('Hit enter and say "e"');
recordblocking(recObj, t);
e = getaudiodata(recOjb);

input('Hit enter and say "a"');
recordblocking(recObj, t);
a = getaudiodata(recOjb);

input('Hit enter and say "s"');
recordblocking(recObj, t);
s = getaudiodata(recOjb);

input('Hit enter and say "t"');
recordblocking(recObj, t);
t = getaudiodata(recOjb);

input('Hit enter and say "x"');
recordblocking(recObj, t);
x = getaudiodata(recOjb);

save('voice_recordings.mat');