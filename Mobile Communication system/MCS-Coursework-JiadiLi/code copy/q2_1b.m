clc;
clear all;
close all;
%Commited 12/7 arno li guiwecgdiu@gmail.com

% Simulated QPSK and theoritical QPSK

%initialize the data transmitted
N=10^6; % Numbers of Bits to be processed
M=4; %Modulation Order
k=log2(M); %Numbers of bits per symbol
nSymbols=N/k; %Numbers of symbols
generatedata= randi([0 1],N,1); % Generate bits as 0 & 1

%initialzie the QPSK modulator
Modulator = comm.QPSKModulator; % Define modulator for QPSK
Demodulator = comm.QPSKDemodulator;   % Define demodulator for QPSK

%Data modulation
modulatedata = step(Modulator,generatedata);  % Modulate bits using QPSK
E_bN_0=-5:10;   % Define range of Eb/N0
SNR = E_bN_0 + 10*log10(k); %Conversion into SNR

%Demodulation
for j=1:length(SNR)
receivedSig(:,j)= awgn(modulatedata,SNR(j),'measured');    % Add AWGN noise to modulated Data     
Demodulatedata = step(Demodulator,receivedSig(:,j)); % Demodulate noisy data 
[numerr(j),errrate(j)] = biterr(generatedata,Demodulatedata); %Find number of Error Bits and Error Rate
end

%Plot BER of Simulated Data
semilogy(E_bN_0,errrate,'mx-','linewidth',4)  
hold on


%Theoretical BER OF QPSK IN AWGN CHANNEL
tber = berawgn(E_bN_0,'psk',4,'nondiff');   % Theoretical BER of QPSK in AWGN Channel 
semilogy(E_bN_0,tber,'b-x','linewidth',2) %Plot Theoretical BER in AWGN


axis([-6 11 10^-5 1])
legend ('Simulation BER','Theoratical BER');
xlabel('E_b/N_0 (dB)')
ylabel('Bit Error Rate')
title('QPSK Modulation in AWGN')
grid on