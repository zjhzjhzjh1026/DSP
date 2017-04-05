clear;clc;close all;
%% Part I
rng(8);
z=[0.9896*exp(1i*pi/8) 0.9896*exp(-1i*pi/8) 0.9843*exp(1i*pi/4) 0.9843*exp(-1i*pi/4) ...
    0.9780*exp(1i*3*pi/8) 0.9780*exp(-1i*3*pi/8) 0.9686*exp(1i*pi/2) 0.9686*exp(-1i*pi/2)];
den=poly(z);
num=[1 zeros(1,8)];
figure(1);
zplane(num,den);
legend('Zero','Pole');
title('Zero and Pole Locations of H(z)');

figure(2);
N=256;
f=[0:0.5/128:0.5-0.5/128];
% [A_INV,~] = freqz(den,num,256);
% a_fill=[den zeros(1,247)];
A=fftshift(fft(den,N));
A=A(129:256);
plot(f,(10*log10(1./(abs(A).^2))));
xlabel('f (cycle/sample)');ylabel('dB');
title('The plot of $10log(\frac{1}{|A(k)|^2})$','Interpreter','latex');

figure(3);
x=[1 zeros(1,255)];
h=filter(num,den,x);
plot(0:255,h);
xlim([0,255]);title('Impulse response h(n)');
xlabel('n');ylabel('h(n)');

figure(4);
H=fftshift(fft(h,N));
H=H(129:256);
plot(f,(log10((abs(H).^2)))*10);
xlabel('f (cycle/sample)');ylabel('dB');
title('The plot of $10log(|H(k)|^2)$','Interpreter','latex');

%% Part II
% rng(15);
wn=randn([1,1280]);
figure(5);
xn=filter(num,den,wn);
xn=xn(1024:1279);
window=hanning(N)';     %%window
U=sum(window.^2);
X=fftshift(fft(xn.*window,N));
X=X(129:256);
plot(f,(log10((abs(X).^2)/U))*10);
xlabel('f (cycle/sample)');ylabel('dB');
title('The plot of $10log(|X(k)|^2)$ (Single Periodogram)','Interpreter','latex');

X_avg = fftshift(pwelch(xn,32,16,256,1,'twosided','psd'));
X_avg=X_avg(129:256);
figure(6);
plot(f,10*log10(X_avg));
xlabel('f (cycle/sample)');ylabel('dB');
title('The plot of $10log(|X(k)|_{avg}^2)$','Interpreter','latex');
%% III
pbin=[2 8 14];
xn1=xn.*window;
for i=1:size(pbin,2)
    p=pbin(i);
    [a,g] = lpc(xn1,p);
    A2=fftshift(fft(a,N));
    A2=A2(129:256);
    figure(5+2*i);
    plot(f,(10*log10(1./(abs(A2).^2))));
    xlabel('f (cycle/sample)');ylabel('dB');
    title(['The plot of $10log(\frac{1}{|\hat{A}(k)|^2})$ p=',num2str(pbin(i))],'Interpreter','latex');
    figure(6+2*i);
    zplane(a);
    title(['Zero and Pole Locations of the inverse filter p=',num2str(pbin(i))]);
end;

pbin=[2 4 6 8 10 12 14];
Ep=[];
for i=1:size(pbin,2)
    p=pbin(i);
    [a,g] = lpc(xn1,p);
    Ep=[Ep g];
end;
figure(13);
plot(pbin,Ep);
xlabel('p');ylabel('Ep');
title('Ep vs. p (256 points)');
axis([2,14,0,30]);
num=32;
%% IIIC
xn=xn(1:32).*hanning(num)';
N_1=32;
f_1=[0:1/N_1:0.5-1/N_1];
X=fftshift(fft(xn,N));
X=X(129:256);
figure(14);
U=sum(hanning(num).^2);
plot(f,(log10((abs(X).^2)/U))*10);
xlabel('f (cycle/sample)');ylabel('dB');
title('The plot of $10log(|X(k)|^2)$ (Single Periodogram 32 points)','Interpreter','latex');

pbin=[2 8 14];
for i=1:size(pbin,2)
    p=pbin(i);
    [a,g] = lpc(xn,p);
    A2=fftshift(fft(a,N_1));
    A2=A2(17:32);
    figure(13+2*i);
    plot(f_1,(10*log10(1./(abs(A2).^2))));
    xlabel('f (cycle/sample)');ylabel('dB');
    title(['The plot of $10log(\frac{1}{|\hat{A}(k)|^2})$ (32 points) p=',num2str(pbin(i))],'Interpreter','latex');
    figure(14+2*i);
    zplane(a);
    title(['Zero and Pole Locations of the inverse filter (32 points) p=',num2str(pbin(i))]);
end;

pbin=[2 4 6 8 10 12 14];
Ep=[];
for i=1:size(pbin,2)
    p=pbin(i);
    [a,g] = lpc(xn,p);
    Ep=[Ep g];
end;
figure(21);
plot(pbin,Ep);
xlabel('p');ylabel('Ep');
title('Ep vs. p (32 points)');
axis([2,14,0,30]);
