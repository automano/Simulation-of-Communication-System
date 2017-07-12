clc
clear
close all;
%%
uS = 1e-06;  %1us %twelve bits are to be transmitted in 12 microseconds
fc = 2e06;   %2 mega hertz frequency %required physical frequency
Wc = 2*pi*fc; %cosines and sines in all of the constellation has frequency of 2 mega hertz.
SNR = 20; % signal to noise rate %For add white guassian noise
sample = [0 0 0 0 0 1 0 1 0 1 0 0];%the first twelve channel encoded bits
%
remat_times = 100; %repeat elements 100 times for plot
t = 0:uS/remat_times: 12*uS - uS/remat_times;  %Time Domin 
%%
[BPSK, QPSK, QAM] = get_physical_signal();

