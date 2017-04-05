clear;clc;close all;
%% 1
N=256;
n=0:N-1;
xn=sin(2*pi/N*n);
% xx=xn;
figure(1);
stem(n,xn);
axis([0 length(xn)-1 -1.1 1.1]);
xlabel('n');ylabel('Value');title('N=256 point time series x(n)');

b=1;          %%1,3,7
% noise=-2^(-b) + (2^(-b)+2^(-b)).*rand(1,N);
% xn=xn+noise;

xn_q=xn.*(2^b);
xn_q=round(xn_q);
xn_q=xn_q.*(2^(-b));
figure(2);
stem(n,xn_q);
axis([0 length(xn)-1 -1.1 1.1]);
xlabel('n');ylabel('Value');title(['N=256 point quantized time series Q[x(n)] b=' num2str(b)]);

en=xn_q-xn;   %%change for dither
figure(3);
stem(n,en);
xlim([0 length(xn)-1]);
xlabel('n');ylabel('Value');title(['N=256 point eror series e(n) b=' num2str(b)]);
%% 2
XN=fftshift(fft(xn,N));
figure(4);
plot([-0.5:1/N:0.5-1/N],20*log10(abs(XN)));
title('dB Magnitude of the |FFT| of x(n)');
xlabel('f (cycle/sample)');ylabel('magnitude (dB)');
axis([-0.5 0.5 -50 50]);

figure(5);
XN_Q=abs(fftshift(fft(xn_q,N)));
XN_Q=XN_Q(2:2:end);                         %%cut-off large negative
plot([-0.5:2/N:0.5-2/N],20*log10(abs(XN_Q)));  
title(['dB Magnitude of the |FFT| of Q[x(n)] b=' num2str(b)]);
xlabel('f (cycle/sample)');ylabel('magnitude (dB)');

%% 3
figure(6);
hist(en); 
title(['Histogram of e(n) b=' num2str(b)]);
xlabel('Amplitude');ylabel('Count'); 

m=63; 
figure(7); 
e_auto=xcorr(en,m,'biased');
e_auto=e_auto(m+1:2*m+1); 
stem(0:m,e_auto); 
title(['The autocorrelation sequence estimate c_{ee}(m) of e(n) b=' num2str(b)]); 
xlabel('m');ylabel('c_{ee}(m)'); 
xlim([0 m]);

window=hamming(N)'; 
wn=en.*window;    
U=sum(window.^2);    
Pee=10*log10(abs(fftshift(fft(wn))).^2/U);
figure(8);     
f=[-0.5:1/N:0.5-1/N];     
plot(f,Pee);     
xlabel('f (cycle/sample)');ylabel('Power(dB)');
title(['Power Spectrum Estimate of e(n) b=' num2str(b)]); 

figure(9); 
bex=xcorr(xn,en,m,'biased'); stem(-m:m,bex); 
title(['The cross-correlation sequence estimate c_{ex}(m) b=' num2str(b)]); 
xlabel('m');ylabel('c_{ex}(m)');
xlim([-m m]);