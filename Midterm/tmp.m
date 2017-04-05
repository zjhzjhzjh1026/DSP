clear;clc;close all;

%% 1
N=150;
n=0:N-1;
xn=0.99*cos(n/10);
figure(1);
stem(n,xn);
axis([0 length(xn)-1 -1.1 1.1]);
xlabel('n');ylabel('Value');title('N=256 point time series x(n)');

b=3;
xn_q=xn.*(2^b);
xn_q=round(xn_q);
xn_q=xn_q.*(2^(-b));
[i,j]=find(xn_q==1);
xn_q(i,j)=1-1/(2^b);
figure(2);
stem(n,xn_q);
axis([0 length(xn)-1 -1.1 1.1]);
xlabel('n');ylabel('Value');title('N=256 point quantized time series Q[x(n)]');

en=xn_q-xn;
figure(3);
stem(n,en);
xlim([0 length(xn)-1]);
xlabel('n');ylabel('Value');title('N=256 point eror series e(n)');
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
title('dB Magnitude of the |FFT| of Q[x(n)]');
xlabel('f (cycle/sample)');ylabel('magnitude (dB)');

%% 3
figure(6);
histogram(en); 
title('Histogram of e(n)');
xlabel('Amplitude');ylabel('Count'); 

m=63; 
figure(7); 
e_auto=xcorr(en,m,'biased');
e_auto=e_auto(m+1:2*m+1); 
stem(0:m,e_auto); 
title('The autocorrelation sequence estimate c_{ee}(m) of e(n)'); 
xlabel('m');ylabel('c_{ee}(m)'); 
xlim([0 m]);

window=hamming(N)';    
wn=en.*window;    
U=sum(window.^2);    
Pee=10*log10(abs(fftshift(fft(wn)).^2)/U);        
figure(8);     
f=[0:1/N:0.5-1/N];     
plot(f,Pee(N/2+1:end));     
xlabel('f (cycle/sample)');ylabel('Power(dB)');
title('Power Spectrum Estimate of e(n)'); 

figure(9); 
bex=xcorr(xn,en,m,'biased'); stem(-m:m,bex); 
title('The cross-correlation sequence estimate c_{ex}(m)'); 
xlabel('m');ylabel('c_{ex}(m)');
xlim([-m m]);