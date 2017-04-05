N=1000000; 
r=rand(1,N);
U=1;    
Pee=10*log10(abs(fftshift(fft(r))).^2/U);
figure;     
f=[-0.5:1/N:0.5-1/N];     
plot(f,Pee);     
xlabel('f (cycle/sample)');ylabel('Power(dB)');
title('Power Spectrum Estimate of e(n)'); 
  

