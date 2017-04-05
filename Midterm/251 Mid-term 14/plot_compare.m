clear;clc;close all;

%% 1
N=256;
n=0:N-1;
xn=sin(2*pi/N*n);

B=[1,3,7];
for i=1:size(B,2)  
b=B(i);
xn_q=xn.*(2^b);
xn_q=round(xn_q);
xn_q=xn_q.*(2^(-b));
% [i,j]=find(xn_q==1);
% xn_q(i,j)=1-1/(2^b);

en=xn_q-xn;
%% 3
m=63; 
figure(1); 
window=hamming(N)';    
wn=en.*window;    
U=sum(window.^2);    
Pee=10*log10(abs(fftshift(fft(wn)).^2)/U);   
var(Pee)
f=[-0.5:1/N:0.5-1/N];     
plot(f,Pee);
xlabel('f (cycle/sample)');ylabel('Power Spectrum(dB)');
title('Comparison of Power Spectrum Estimate of e(n)'); 
hold on; %plot(f,10*log10(2^(-b*2)/12)*ones(1,size(f,2)),'r');grid on; %%-2?
end;
axis([-0.5,0.5,-100,0]);
legend('B=1','B=3','B=7');