% channel capacity figures, Outage capacity
% Capacities for various Nt and SNR
%commiter Arno Li guiwecgdiu@gmail.com
%"Modified from the class matlab code sample"
%last commit date:2021/12/8 


clear all

Nt  = 10;
Nr  = 10;
step = 1;
SNR  = 15;

snr = 10.^(SNR/10);

Ant = [1,10,10];



repet = 100000;


Cawgn = log2(1 + snr);
Cap   = zeros(length(Ant),repet); 




for J = 1:repet

HH = (randn(Nt) + 1i*randn(Nt))/sqrt(2);



for K = 1:length(Ant)

    H = HH(1:Ant(K),1:Ant(K));
    Id = eye(Ant(K));


    
    
% %     %Produce the diag matrix
    if K==3
        idx = eye(size(H));
        idx = idx +0*(1-idx);
        H = idx.*H;
    end
    
    Cap(K,J) = log2( real(det(Id + snr*H*H'/Ant(K) )));

end


end







[X1,Y1] = hist(Cap(1,:),50);
X1 = X1/repet;
cdfX1 = cumsum(X1);

[X2,Y2] = hist(Cap(2,:),50);
X2 = X2/repet;
cdfX2 = cumsum(X2);

[X3,Y3] = hist(Cap(3,:),50);
X3 = X3/repet;
cdfX3 = cumsum(X3);

%%% AWGN
Cawgn = log2(1 + snr);
Y0 = linspace(Cawgn-1,Cawgn+1,100)
cdfX0 = +(Y0 > Cawgn);



figure(2)
plot(Y0,cdfX0,Y1,cdfX1,Y2,cdfX2,Y3,cdfX3)
% plot(Y0,cdfX0,Y1,cdfX1,Y2,cdfX2,Y3,cdfX3,[0,50],[0.25,0.25],[0,50],[0.5,0.5])
legend('a.AWGN','b.1x1-SISO','c.10x10','d.10x10Diag')
xlabel('Capacity [bits/sec/Hz]')
ylabel('CDF')
title('Outage Probability @ SNR = 15dB') 
axis([0,50,0,1])  
grid on






% figure(1)
% plot(SNR,Cawgn,SNR,Cap(1,:),SNR,Cap(2,:),SNR,Cap(3,:),SNR,Cap(4,:),SNR,Cap(5,:),SNR,Cap(6,:))
% legend('AWGN','1x1','2x2','4x4','8x8','16x16','32x32')
% label('SNR [dB]')
% ylabel('bits/sec/Hz')


