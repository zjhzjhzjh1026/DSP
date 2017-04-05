close all;clc;clear;
%% IA
N=1024;
a=rand(1,N);
b=randn(1,N);
figure(1);
stem(0:N-1,a);
title('1024-point Uniform Sequences');
xlabel('n');ylabel('a[n]');
axis([0 1023 0 1]);
figure(2);
stem(0:N-1,b);
title('1024-point Gaussian Sequences');
xlabel('n');ylabel('b[n]');
axis([0 1023 -4 4]);

%% IB 
figure(3);
hist(a,15);
title('1024-point Uniform Sequences Histogram');
xlabel('Amplitude');ylabel('Count');
figure(4);
hist(b,15);
title('1024-point Gaussian Sequences Histogram');
xlabel('Amplitude');ylabel('Count');

%% IC
m=15;
figure(5);
a_auto=xcorr(a(1:256),m,'biased');
a_auto=a_auto(m+1:2*m+1);
stem(0:m,a_auto);
title('The autocorrelation sequence estimate c_{xx}(m) of Uniform Sequence');
xlabel('m');ylabel('c_{xx}(m)');

figure(6);
b_auto=xcorr(b(1:256),m,'biased');
b_auto=b_auto(m+1:2*m+1);
stem(0:m,b_auto);
title('The autocorrelation sequence estimate c_{xx}(m) of Gaussian Sequence');
xlabel('m');ylabel('c_{xx}(m)');

%% IIA
lpf=ones(1,8);
figure(7); 
zplane(lpf);
legend('Zero','Pole'); title('Z-plane description of the FIR filter');

figure(8);
NN=256;
LPF=fftshift(fft(lpf,NN));
plot([-0.5:1/NN:0.5-1/NN],20*log10(abs(LPF)));
title('Low-pass FIR filter dB Magnitude Response');
xlabel('f (cycle/sample)');ylabel('magnitude (dB)');

%% IIB
b_fil=conv(b,lpf); 
figure(9);
plot(0:NN-1,b(1:NN));              
title('256-point example of input sequence');
xlabel('n');ylabel('b[n]');
axis([0 255 -4 4]);

figure(10);
plot(0:NN-1,b_fil(1:NN));              
title('256-point example of output sequence');
xlabel('n');ylabel('b_fil[n]');
axis([0 255 -8 8]);

figure(11);
bfil_auto=xcorr(b_fil(1:NN),m,'biased');
bfil_auto=bfil_auto(m+1:2*m+1);
stem(0:m,bfil_auto);
title('The autocorrelation sequence estimate c_{yy}(m)');
xlabel('m');ylabel('c_{yy}(m)');

figure(12);
bxy=xcorr(b_fil(1:NN),b(1:NN),m,'biased');
stem(-m:m,bxy);
title('The cross-correlation sequence estimate c_{xy}(m)');
xlabel('m');ylabel('c_{xy}(m)');