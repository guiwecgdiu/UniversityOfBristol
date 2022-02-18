function smearing2()
% smearing2 shows the effect of windowing on the spectrum of a signal.
% Two signals are tested : a complex exponential and a cosine
% The DTFT is approximated (given that in reality the spectrum is calculated with the DFT in all cases)
% by having a very large window (N1=1024 samples of the signal).
% The effect of windowing is then shown by windowing the siganl using a window of length N=16.
% Arrange the windows at your desktop so that the figure and the command prompt are visible all the time. 
% call smearing2 and press enter at the command prompt - every time you press enter the frequency of the signal increases slightly

N = 16;
N1 = 1024;
n = (0:N1-1)-100;
axislimits = [-10,N+10,-1.1,1.1];

wn = zeros( size(n) );
wn(find( (n>=0) & (n<N) )) = rectwin(N);
%Comment the above line and uncomment the one below to try Hamming window
%wn(find( (n>=0) & (n<N) )) = hamming(N); 

% Complex Eponential
for expectedk = 0:0.1:5, 
    expectedk
    Omega = expectedk * 2*pi / N;
    xn = exp(j*Omega*n);
    smearing2a(n, xn, N, wn, axislimits); 
    drawnow
    pause;
end

% Cosine
for expectedk = 0:0.1:5,   
    expectedk
    Omega = expectedk * 2*pi / N;
    xn = cos(Omega*n);
    smearing2a(n, xn, N, wn, axislimits); 
    drawnow
    pause;
end


function smearing2a(n, xn, N, wn, axislimits)

Omega = 2*pi * ( 0:length(n)-1 ) / length(n);
xwn   = xn .* wn;
Xk    = fft(xn);
Wk    = fft(wn);
Xwk   = fft(xwn);

k   = 0:N-1;
xxn = xwn( find((n>=0) & (n<N)) );
XXk = fft(xxn);


% Time domain plots
% ----------------------------------------------------
%Input signal
subplot(3,2,1);
plot(n,real(xn));
xlabel('n')
ylabel('real( x[n] )')
axis(axislimits);

% Window
subplot(3,2,3);
plot(n,wn);
ylabel('w[n]')
xlabel('n')
axis(axislimits);

% Windowed input signal
subplot(3,2,5);
plot(n,real(xwn));
xlabel('n')
ylabel('real( xw[n] )')
axis(axislimits);

% Frequency domain plots
% ----------------------------------------------------
% DTFT (approximation) of input signal
subplot(3,2,2);
plot(Omega,abs(Xk));
xlabel('Omega (radians)')
ylabel('Magnitude of X(Omega)');
axis([0,2*pi,0,600])

% DTFT (approximation) of window 
subplot(3,2,4);
plot(Omega,abs(Wk));
xlabel('Omega (radians)')
ylabel('Magnitude of W(Omega)');
axis([0,2*pi,0,20])

% DTFT  (approximation) of windowed input signal 
subplot(3,2,6);
hold off
plot(Omega,abs(Xwk));
xlabel('Omega (radians)')
ylabel('Magnitude of Xw(Omega) or X[k]');

% DFT of windowed input signal 
hold on
axis([0,2*pi,0,20])
stem(k*2*pi/N,abs(XXk), 'r');

