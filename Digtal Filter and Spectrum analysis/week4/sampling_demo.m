function sampling_demo()
% A demo of sampling a cosine signal with aliasing
disp('f0 = 0.1Hz  fs = 1Hz');
sampling_draw(0.1, 1);
pause
disp('f0 = 0.9Hz  fs = 1Hz');
sampling_draw(0.9, 1);
pause
disp('f0 = 1.1Hz  fs = 1Hz');
sampling_draw(1.1, 1);
pause
disp('f0 = 1Hz  fs = 1Hz');
sampling_draw(1, 1);
pause


function sampling_draw(f0, fs)
Ts = 1/fs;  
Tmax = 10;

Tsh = 0.01 * Ts;
t = 0:Tsh:Tmax;
xt = cos(2*pi*f0*t);
N = Tmax / Ts;
n = 0:N;
xn = cos(2*pi*f0*n*Ts);

figure(1);
hold off
plot(t,xt, 'g');

hold on
stem(n,xn);
plot(n,xn,'r-');



