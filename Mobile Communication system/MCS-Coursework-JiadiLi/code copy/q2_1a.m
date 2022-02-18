clc;
clear all;
close all;
M=2; %Modulation Order
E_bN_0=-5:10;   % Define range of Eb/N0 for calculations
tberB = berawgn(E_bN_0,'psk',2,'nondiff');   % Theoretical BER of BPSK in AWGN Channel 
tberQ = berawgn(E_bN_0,'psk',4,'nondiff'); %Theoretical BER of QPSK in AWGN Channel 
tberQAM = berawgn(E_bN_0,'qam',16,'nondiff'); %Theoretical BER of QAM16 in AWGN Channel 


semilogy(E_bN_0,tberB,'b-x','linewidth',10) %Plot Theoretical BER in AWGN
hold on
semilogy(E_bN_0,tberQ,'c-x','linewidth',2) %Plot Theoretical BER in AWGN
hold on
semilogy(E_bN_0,tberQAM,'r-x','linewidth',1) %Plot Theoretical BER in AWGN
legend ('Theoratical BER-BPSK','Theoratical BER-QPSK','Theoratical BER-QAM')
xlabel('E_b/N_0 (dB)')
ylabel('Bit Error Rate')
title('EbN0 vers BER,BPSK,16QAM,Qpsk in AWGN')
grid on