clear all; 
clc;
% --------------------------------------------------------
% Record your voice for 10 seconds.
% Change the sampling rate fs and listen to your recording 
% Try fs 22100 and fs 2000 
% --------------------------------------------------------
fs = 2000;
recObj = audiorecorder(fs,24,1);
disp('Press key to start recording')
pause;
disp('Recording started')
recordblocking(recObj, 10);
disp('End of Recording.');

disp ('Press key to playback recording');
pause
disp('Playback started')
% Play back the recording.
play(recObj);
% Store data in double-precision array.
myRecording = getaudiodata(recObj);
% Plot the waveform.
figure;
plot(myRecording);