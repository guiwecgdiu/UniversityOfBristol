clc;
clear all;
close all;

E_bN_0=-5:10;   % Define range of Eb/N0 for calculations
tberQ = berfading(E_bN_0,'psk',4,4); %Theoretical BER of QPSK in Rayleigth Channel 
tberQAM = berfading(E_bN_0,'qam',16,4); %Theoretical BER of QAM16 in Rayleigth Channel 

axis([-6 11 10^-5 1])
semilogy(E_bN_0,tberQ,'c-x','linewidth',2) %Plot Theoretical BER in AWGN
hold on
semilogy(E_bN_0,tberQAM,'r-x','linewidth',1) %Plot Theoretical BER in AWGN
legend ('Theoratical BER-QPSK','Theoratical BER-QAM')
xlabel('E_b/N_0 (dB)')
ylabel('Bit Error Rate')
title('EbN0 vers 16QAM,Qpsk in Rayleigth(Divorder=4)')
grid on