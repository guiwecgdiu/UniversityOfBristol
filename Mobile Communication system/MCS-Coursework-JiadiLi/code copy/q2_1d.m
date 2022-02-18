clc;
clear all;
close all;

E_bN_0=-5:10;   % Define range of Eb/N0 for calculations
tberQ_d2= berfading(E_bN_0,'psk',4,2); %Theoretical BER of QPSK in Rayleigth Channel 
tberQ_d4= berfading(E_bN_0,'psk',4,4); %Theoretical BER of QPSK in Rayleigth Channel
tberQAM_d2 = berfading(E_bN_0,'qam',16,2); %Theoretical BER of QAM16 in Rayleigth Channel
tberQAM_d4 = berfading(E_bN_0,'qam',16,4); %Theoretical BER of QAM16 in Rayleigth Channel

axis([-6 11 10^-5 1])
semilogy(E_bN_0,tberQ_d2,'c-x','linewidth',2) %Plot Theoretical BER in Rayleigth Channel d=2
hold on
semilogy(E_bN_0,tberQ_d4,'b-x','linewidth',2) %Plot Theoretical BER in Rayleigth Channel d=4
hold on
semilogy(E_bN_0,tberQAM_d2,'r-x','linewidth',1) %Plot Theoretical BER in Rayleigth Channel d=2
hold on
semilogy(E_bN_0,tberQAM_d4,'m-x','linewidth',1) %Plot Theoretical BER in Rayleigth Channel d=4
legend ('Theoratical BER-QPSK(divorder2)','Theoratical BER-QPSK(divorder4)','Theoratical BER-QAM(divorder2)','Theoratical BER-QAM(divorder4)')
xlabel('E_b/N_0 (dB)')
ylabel('Bit Error Rate')
title('EbN0 vers 16QAM,Qpsk in Rayleigth(Divorder=4 and 2 respectively)')
grid on