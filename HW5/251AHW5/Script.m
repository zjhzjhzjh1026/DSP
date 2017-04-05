clc;clear;close all;
%% Build signal
% w1=randn(1,1024);
% h=1/8*[1,1,1,1,1,1,1,1]; %%lowpass filter
% y=filter(h,1,w1);
% w2=randn(1,1024)/sqrt(32);
% r=y+w2;
% N=128;
load('matlab.mat');
%% A
H=fftshift(fft(h,N));
figure(1);
plot([-0.5:1/N:0.5-1/N],20*log10(abs(H)));
title('Transfer Function of h(n) dB Magnitude');
xlabel('f (cycle/sample)');ylabel('Magnitude (dB)');

figure(2);
plot([-0.5:1/N:0.5-1/N],abs(H));
title('Transfer Function of h(n) Linear Magnitude');
xlabel('f (cycle/sample)');ylabel('Magnitude');

figure(3);
plot([-0.5:1/N:0.5-1/N],unwrap(phase(H)));
title('Transfer function of h(n) (phase)');
xlabel('f (cycle/sample)');ylabel('Phase (rad)');
% zplane(h);legend('Zero','Pole');
% title('Transfer Function of h(n) Phase')
%% B
figure(4);
Sw1w1 = fftshift(pwelch(w1,128,64,128,1,'twosided','psd'));
plot([-0.5:1/N:0.5-1/N],10*log10(Sw1w1));
xlabel('f (cycle/sample)');ylabel('Power Spectral (dB)');
title('Power Spectral Estimate $\hat{S}_{w1,w1}(f)$ (dB)','Interpreter','latex');
axis([-0.5,0.5,-20,5]);

figure(5);
plot([-0.5:1/N:0.5-1/N],Sw1w1);
xlabel('f (cycle/sample)');ylabel('Power Spectral');
title('Power Spectral Estimate $\hat{S}_{w1,w1}(f)$ (linear)','Interpreter','latex');
% axis([-0.5,0.5,-20,5]);

figure(6);
Sw2w2= fftshift(pwelch(w2,128,64,128,1,'twosided','psd'));
plot([-0.5:1/N:0.5-1/N],10*log10(Sw2w2));
xlabel('f (cycle/sample)');ylabel('Power Spectral (dB)');
title('Power Spectral Estimate $\hat{S}_{w2,w2}(f)$ (dB)','Interpreter','latex');
axis([-0.5,0.5,-20,5]);

figure(7);
plot([-0.5:1/N:0.5-1/N],Sw2w2);
xlabel('f (cycle/sample)');ylabel('Power Spectral');
title('Power Spectral Estimate $\hat{S}_{w2,w2}(f)$ (linear)','Interpreter','latex');
% axis([-0.5,0.5,-20,5]);

figure(8);
Syy = fftshift(pwelch(y,128,64,128,1,'twosided','psd'));
plot([-0.5:1/N:0.5-1/N],10*log10(Syy));
xlabel('f (cycle/sample)');ylabel('Power Spectral (dB)');
title('Power Spectral Estimate $\hat{S}_{y,y}(f)$ (dB)','Interpreter','latex');

figure(9);
plot([-0.5:1/N:0.5-1/N],Syy);
xlabel('f (cycle/sample)');ylabel('Power Spectral');
title('Power Spectral Estimate $\hat{S}_{y,y}(f)$ (linear)','Interpreter','latex');

figure(10);
Srr = fftshift(pwelch(r,128,64,128,1,'twosided','psd'));
plot([-0.5:1/N:0.5-1/N],10*log10(Srr));
xlabel('f (cycle/sample)');ylabel('Power Spectral (dB)');
title('Power Spectral Estimate $\hat{S}_{r,r}(f)$ (dB)','Interpreter','latex');

figure(11);
plot([-0.5:1/N:0.5-1/N],Srr);
xlabel('f (cycle/sample)');ylabel('Power Spectral');
title('Power Spectral Estimate $\hat{S}_{r,r}(f)$ (linear)','Interpreter','latex');

%% C
figure(12);
Syw1=fftshift(cpsd(y,w1,128,64,128,1,'twosided'));
plot([-0.5:1/N:0.5-1/N],10*log10(abs(Syw1)));
xlabel('f (cycle/sample)');ylabel('Cross-power Spectral(dB)');
title('Cross-power Spectral Estimate $\hat{S}_{y,w1}(f)$ (dB)','Interpreter','latex');

figure(13);
plot([-0.5:1/N:0.5-1/N],abs(Syw1));
xlabel('f (cycle/sample)');ylabel('Cross-power Spectral');
title('Cross-power Spectral Estimate $\hat{S}_{y,w1}(f)$ (linear)','Interpreter','latex');

figure(14);
plot([-0.5:1/N:0.5-1/N],unwrap(phase(Syw1)));
title('Cross-power Spectral Estimate $\hat{S}_{y,w1}(f)$ (phase)','Interpreter','latex');
xlabel('f (cycle/sample)');ylabel('Phase (rad)');

figure(15);
Srw1=fftshift(cpsd(r,w1,128,64,128,1,'twosided'));
plot([-0.5:1/N:0.5-1/N],10*log10(abs(Srw1)));
xlabel('f (cycle/sample)');ylabel('Cross-power Spectral(dB)');
title('Cross-power Spectral Estimate $\hat{S}_{r,w1}(f)$ (dB)','Interpreter','latex');

figure(16);
plot([-0.5:1/N:0.5-1/N],abs(Srw1));
xlabel('f (cycle/sample)');ylabel('Cross-power Spectral');
title('Cross-power Spectral Estimate $\hat{S}_{r,w1}(f)$ (linear)','Interpreter','latex');

figure(17);
plot([-0.5:1/N:0.5-1/N],angle(Srw1));
title('Cross-power Spectral Estimate $\hat{S}_{r,w1}(f)$ (phase)','Interpreter','latex');
xlabel('f (cycle/sample)');ylabel('Phase (rad)');
%% D
figure(18);
Hw1y=Syw1./Sw1w1;
plot([-0.5:1/N:0.5-1/N],20*log10(abs(Hw1y)));
xlabel('f (cycle/sample)');ylabel('Magnitude(dB)');
title('Transfer Function Estimate $\hat{H}_{w1,y}(f)$ (dB)','Interpreter','latex');

figure(19);
plot([-0.5:1/N:0.5-1/N],abs(Hw1y));
xlabel('f (cycle/sample)');ylabel('Magnitude');
title('Transfer Function Estimate $\hat{H}_{w1,y}(f)$ (linear)','Interpreter','latex');

figure(20);
plot([-0.5:1/N:0.5-1/N],unwrap(phase(Hw1y)));
title('Transfer Function Estimate $\hat{H}_{w1,y}(f)$ (phase)','Interpreter','latex');
xlabel('f (cycle/sample)');ylabel('Phase (rad)');

figure(21);
Hw1r=Srw1./Sw1w1;
plot([-0.5:1/N:0.5-1/N],20*log10(abs(Hw1r)));
xlabel('f (cycle/sample)');ylabel('Magnitude(dB)');
title('Transfer Function Estimate $\hat{H}_{w1,r}(f)$ (dB)','Interpreter','latex');

figure(22);
plot([-0.5:1/N:0.5-1/N],abs(Hw1r));
xlabel('f (cycle/sample)');ylabel('Magnitude');
title('Transfer Function Estimate $\hat{H}_{w1,r}(f)$ (linear)','Interpreter','latex');

figure(23);
plot([-0.5:1/N:0.5-1/N],angle(Hw1r));
title('Transfer Function Estimate $\hat{H}_{w1,r}(f)$ (phase)','Interpreter','latex');
xlabel('f (cycle/sample)');ylabel('Phase (rad)');
%% E
figure(24);
gamma_w1y=abs(Syw1).^2./Syy./Sw1w1;
plot([-0.5:1/N:0.5-1/N],abs(gamma_w1y));
xlabel('f (cycle/sample)');ylabel('$\hat{\gamma}_{w1,y}^{2}$','Interpreter','latex');
title('Magnitude-squared Coherence Function Estimate $\hat{\gamma}_{w1,y}^{2}(f)$ (linear)','Interpreter','latex');

figure(25);
gamma_w1r=abs(Srw1).^2./Srr./Sw1w1;
plot([-0.5:1/N:0.5-1/N],abs(gamma_w1r));
xlabel('f (cycle/sample)');ylabel('$\hat{\gamma}_{w1,r}^{2}$','Interpreter','latex');
title('Magnitude-squared Coherence Function Estimate $\hat{\gamma}_{w1,r}^{2}(f)$ (linear)','Interpreter','latex');