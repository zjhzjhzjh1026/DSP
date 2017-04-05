%% B
% Design a 64-point FIR Hilbert transformer for use in the single sideband generator.
hl = firpm(63,[0.05 0.95],[1 1],'hilbert');
% w = kaiser(64,3.4);
% hl = hl .* w';
%% C
% Plot the impulse response and transfer function (dB magnitude and phase) of the Hilbert transformer
figure(1)
stem(hl);
% axis([]);
xlabel('$$n$$','Interpreter','latex');
ylabel('$$h[n]$$','Interpreter','latex');
title('Impulse Response of Hilbert Transformer');

Hl = fftshift(fft(hl));
figure(2)
plot(linspace(-0.5,0.5 - 1/64,64),mag2db(abs(Hl)));
axis([-0.5 0.5 -inf inf]);
xlabel('$$f(cycles/sample)$$','Interpreter','latex');
ylabel('Magnitude');
title('dB Magnitude of Transfer Function of Hilbert Transformer');

figure(3)
plot(linspace(-0.5,0.5 - 1/64,64),unwrap(phase(Hl)));
axis([-0.5 0.5 -inf inf]);
xlabel('$$f(cycles/sample)$$','Interpreter','latex');
ylabel('Phase(radius)');
title('Phase of Transfer Function');

figure(4)
plot(linspace(-0.5,0.5 - 1/64,64),unwrap(phase(Hl)));
axis([-0.05 0.05 -100 -88]);
xlabel('$$f(cycles/sample)$$','Interpreter','latex');
ylabel('Phase(radius)');
title('Zoomed Phase of Transfer Function');
%% D
% Plot FFTs (dB magnitude only; no need for phase plots) at each stage of the system from input through output 
% including FFTs of the real signals xr(n), xr¡¯(n), xi(n), xr¡¯(n) cos(2¦Ðfcn), xi(n) sin(2¦Ðfcn), and sr(n)(both USB and LSB). 
% Also, plot the FFTs of the complex signals x(n) = xr¡¯(n) + j xi(n) and s(n) = x(n)exp(+j2¦Ðfcn). 
% Use a good window function with your FFTs and use NFFT = 256. 
% Just a single FFT is needed so there will be additional unused points in your various time series.

n = 0:1023;
f1 = 0.05;
f2 = 0.075;
f3 = 0.10;
fc = 0.25;
% xr = sin(2*pi*f1*n) + 0.1*sqrt(10)*sin(2*pi*f2*n) + 0.1*sin(2*pi*f3*n);
xr = cos(2*pi*f1*n) + 0.1*sqrt(10)*cos(2*pi*f2*n) + 0.1*cos(2*pi*f3*n);

% Window function
w = kaiser(256,3.9754);
% w = kaiser(256,2);
%% X[k]
% Xr[k]
xr_fft = w' .* xr(65:320);
figure(5)
plot(linspace(-0.5,0.5 - 1/256,256),mag2db(abs(fftshift(fft(xr_fft)))));
axis([-0.5 0.5 -inf inf]);
xlabel('$$f(cycles/sample)$$','Interpreter','latex');
ylabel('Magnitude');
title('dB Magnitude of X_r[k]');

% Xr'[k]
hu = firpm(63,[0 0.8],[1 1]);
xrr = conv(xr,hu);
xrr_fft = w' .* xrr(65:320);
figure(6)
plot(linspace(-0.5,0.5 - 1/256,256),mag2db(abs(fftshift(fft(xrr_fft)))));
axis([-0.5 0.5 -inf inf]);
xlabel('$$f(cycles/sample)$$','Interpreter','latex');
ylabel('Magnitude');
title('dB Magnitude of X_r^''[k]');

xi = conv(xr,hl);
xi_fft = w' .* xi(65:320);
figure(7)
plot(linspace(-0.5,0.5 - 1/256,256),mag2db(abs(fftshift(fft(xi_fft)))));
axis([-0.5 0.5 -inf inf]);
xlabel('$$f(cycles/sample)$$','Interpreter','latex');
ylabel('Magnitude');
title('dB Magnitude of X_i[k]');
%%
xrr_cos = xrr(1:1024) .* cos(2*pi*fc*n);
xrr_cos_fft = w' .* xrr_cos(65:320);
figure(8)
plot(linspace(-0.5,0.5 - 1/256,256),mag2db(abs(fftshift(fft(xrr_cos_fft)))));
axis([-0.5 0.5 -inf inf]);
xlabel('$$f(cycles/sample)$$','Interpreter','latex');
ylabel('Magnitude');
title('dB Magnitude of FFT of x_r^''[n]cos(2\pif_cn)');

xi_sin = xi(1:1024) .* sin(2*pi*fc*n);
xi_sin_fft = w' .* xi_sin(65:320);
figure(9)
plot(linspace(-0.5,0.5 - 1/256,256),mag2db(abs(fftshift(fft(xi_sin_fft)))));
axis([-0.5 0.5 -inf inf]);
xlabel('$$f(cycles/sample)$$','Interpreter','latex');
ylabel('Magnitude');
title('dB Magnitude of FFT of x_i[n]sin(2\pif_cn)');

%% sr
figure(10)
sr_l = xrr_cos + xi_sin;
sr_l_fft = w' .* sr_l(65:320);
plot(linspace(-0.5,0.5 - 1/256,256),mag2db(abs(fftshift(fft(sr_l_fft)))));
axis([-0.5 0.5 -inf inf]);
xlabel('$$f(cycles/sample)$$','Interpreter','latex');
ylabel('Magnitude');
title('dB Magnitude of LSB S_r[k]');

figure(11)
sr_u = xrr_cos - xi_sin;
sr_u_fft = w' .* sr_u(65:320);
plot(linspace(-0.5,0.5 - 1/256,256),mag2db(abs(fftshift(fft(sr_u_fft)))));
axis([-0.5 0.5 -inf inf]);
xlabel('$$f(cycles/sample)$$','Interpreter','latex');
ylabel('Magnitude');
title('dB Magnitude of USB S_r[k]');

%% xr
x = complex(xrr , xi);
x_fft = w' .* x(65:320);
figure(12)
plot(linspace(-0.5,0.5 - 1/256,256),mag2db(fftshift(abs(fft(x_fft)))))
axis([-0.5 0.5 -inf inf]);
xlabel('$$f(cycles/sample)$$','Interpreter','latex');
ylabel('Magnitude');
title('dB Magnitude of X[k]');
%% s
s = x(1:1024) .* exp(1i*2*pi*fc*n);
s_fft = w' .* s(65:320);
figure(13)
plot(linspace(-0.5,0.5 - 1/256,256),mag2db(fftshift(abs(fft(s_fft)))))
axis([-0.5 0.5 -inf inf]);
xlabel('$$f(cycles/sample)$$','Interpreter','latex');
ylabel('Magnitude');
title('dB Magnitude of S[k]');

%%
figure(14)
stem(hu);
xlabel('$$n$$','Interpreter','latex');
ylabel('$$h[n]$$','Interpreter','latex');
title('Impulse Response of LPF');

Hu = fftshift(fft(hu));
figure(15)
plot(linspace(-0.5,0.5 - 1/64,64),mag2db(abs(Hu)));
axis([-0.5 0.5 -inf inf]);
xlabel('$$f(cycles/sample)$$','Interpreter','latex');
ylabel('Magnitude');
title('dB Magnitude of Transfer Function of LPF');
% % stem(fft(hu))
% % stem(abs(fftshift(fft(hu))))
% 
% % xi = filter(h,1,xr);
% % xi = hilbert(xr);
% % plot(mag2db(abs(fftshift(fft(xi)))))