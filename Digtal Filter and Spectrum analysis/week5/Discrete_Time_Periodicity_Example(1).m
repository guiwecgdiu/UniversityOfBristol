clear; clf;                    
n = 0:20;
x = sin(5*n + 0.1);
subplot(2,2,1);
stem(n,x,'filled'); grid;
xlabel('n'); ylabel('x[n]=sin(5n+0.1)');
title('Aperiodic Discrete-Time Signal');

x = cos(10*pi*n/6 - 0.22);
subplot(2,2,2);
stem(n,x,'filled'); grid;
xlabel('n'); ylabel('x[n]=cos(10*pi*n/6-0.22)');
title('Periodic Discrete-Time Signal');

t = 0:0.01:20;                 % continuous-time values
xcon = sin(2*t);               % continuous-time signal
T = 0.5;                       % sample interval (time)       
n = 0/T:20/T;                  % discrete-time values (from t=nT)
xdisc = sin(n);                % discrete-time signal
subplot(2,1,2);                % plot both signals on continous-time axis
plot(t,xcon);                  % use t = nT for discrete-time signal
hold on;
stem(n*T, xdisc, 'filled');
hold off;
grid;
xlabel('t '); ylabel('x[n],x(t)');
title('Periodic x(t)=sin(2t) Sampled at T=0.5sec to get Aperiodic x[n]=sin(n)');