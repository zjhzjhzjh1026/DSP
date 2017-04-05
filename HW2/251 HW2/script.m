clear;clc;close all;
%%	Prob B starts
NN=64;
F=[0.05,0.95];
A=[1,1];
hb=firpm(NN-1,F,A,'hilbert');
%% Prob C starts
figure(1);
stem([0:NN-1],hb);
title('64-point FIR Hilbert Transformer Impulse Response');
xlabel('n');ylabel('hb[n]');

figure(2);
HB=fftshift(fft(hb,64));
plot([-0.5:1/64:0.5-1/64],20*log10(abs(HB)));
title('64-point FIR Hilbert Transformer dB Magnitude ');
xlabel('f (cycle/sample)');ylabel('magnitude (dB)');

figure(3);
plot([-0.5:1/64:0.5-1/64],unwrap(phase(HB)));
title('64-point FIR Hilbert Transformer Phase');
xlabel('f (cycle/sample)');ylabel('Phase (rad)');

figure(4);
plot([-0.5:1/64:0.5-1/64],unwrap(phase(HB)));
axis([-0.03 0.03 -97 -92]);
title('Local Zoom-in 64-point FIR Hilbert Transformer Phase');
xlabel('f (cycle/sample)');ylabel('Phase (rad)');

%% Prob D Starts
f1=0.05;f2=0.075;f3=0.10;fc=0.25;
A_1=1;A_2=1/sqrt(10);A_3=1/10;   %20log10(A),so 10dB equals 1/sqrt(10)
N=1024;
n=0:N-1;
window=hamming(256)';
x_r=A_1*cos(2*pi*f1*n)+A_2*cos(2*pi*f2*n)+A_3*cos(2*pi*f3*n);

%%%xr(n)
figure(5);
xr_t=window.*x_r(100:355);
plot([-0.5:1/256:0.5-1/256],20*log10(abs(fftshift(fft(xr_t)))));
title('X_{r} dB Magnitude');
xlabel('f (cycle/sample)');ylabel('magnitude (dB)');

%%%x'r(n)
figure(6);
delay_filter=firpm(NN-1,[0,0.85],[1,1]);
xr_d=filter(delay_filter,1,x_r);
xrd_t=window.*xr_d(1:256);
plot([-0.5:1/256:0.5-1/256],20*log10(abs(fftshift(fft(xrd_t)))));
title('X^''_{r}  dB Magnitude');
xlabel('f (cycle/sample)');ylabel('magnitude (dB)');

%%%xi(n)
figure(7);
xi_d=conv(x_r,hb);
xid_t=window.*xi_d(100:355);
plot([-0.5:1/256:0.5-1/256],20*log10(abs(fftshift(fft(xid_t)))));
title('X_{i}  dB Magnitude ');
xlabel('f (cycle/sample)');ylabel('magnitude (dB)');


%%%x'r(n)cos
figure(8);
xrd_cos=xr_d(1:1024).*cos(2*pi*fc*n);
xrdcos_t=window.*xrd_cos(100:355);
plot([-0.5:1/256:0.5-1/256],20*log10(abs(fftshift(fft(xrdcos_t)))));
title('X^''_{r}cos(2*pi*f_{c}*n)  dB Magnitude');
xlabel('f (cycle/sample)');ylabel('magnitude (dB)');

%%%xi(n)sin
figure(9);
xid_sin=xi_d(1:1024).*sin(2*pi*fc*n);
xidsin_t=window.*xid_sin(100:355);
plot([-0.5:1/256:0.5-1/256],20*log10(abs(fftshift(fft(xidsin_t)))));
title('X_{i}sin(2*pi*f_{c}*n)  dB Magnitude');
xlabel('f (cycle/sample)');ylabel('magnitude (dB)');

%%%LSB
figure(10);
LSB=xrd_cos+xid_sin;
LSB_t=window.*LSB(100:355);
plot([-0.5:1/256:0.5-1/256],20*log10(abs(fftshift(fft(LSB_t)))));
title('LSB dB Magnitude');
xlabel('f (cycle/sample)');ylabel('magnitude (dB)');

%%%USB
figure(11);
USB=xrd_cos-xid_sin;
USB_t=window.*USB(100:355);
plot([-0.5:1/256:0.5-1/256],20*log10(abs(fftshift(fft(USB_t)))));
title('USB dB Magnitude');
xlabel('f (cycle/sample)');ylabel('magnitude (dB)');

%%%complex x_comp
figure(12);
x_comp=complex(xr_d,xi_d);
xcomp_t=window.*x_comp(100:355);
plot([-0.5:1/256:0.5-1/256],20*log10(abs(fftshift(fft(xcomp_t)))));
title('X dB Magnitude');
xlabel('f (cycle/sample)');ylabel('magnitude (dB)');

%%%s(n)
figure(13);
s=x_comp(1:1024).*exp(i*2*pi*fc*n);
s_t=window.*s(100:355);
plot([-0.5:1/256:0.5-1/256],20*log10(abs(fftshift(fft(s_t)))));
title('S dB Magnitude ');
xlabel('f (cycle/sample)');ylabel('magnitude (dB)');

%% Lowpass Filter
figure(14);
stem([0:NN-1],delay_filter);
title('Upper Path Lowpass Filter Impulse Response');
xlabel('n');ylabel('lp[n]');

figure(15);
LP=fftshift(fft(delay_filter,64));
plot([-0.5:1/64:0.5-1/64],20*log10(abs(LP)));
title('Upper Path Lowpass Filter Transfer Function dB Magnitude ');
xlabel('f (cycle/sample)');ylabel('magnitude (dB)');

figure(16);
plot([-0.5:1/64:0.5-1/64],unwrap(phase(LP)));
title('Upper Path Lowpass Filter Transfer Function Phase');
xlabel('f (cycle/sample)');ylabel('Phase (rad)');