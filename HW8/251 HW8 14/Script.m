clc;clear;close all
load -ascii bili_single_col.txt
load -ascii bilu_single_col.txt
load -ascii bilng_single_col.txt
load -ascii jcnwwa_single_col.txt
%% Part I
sig_all = [bili_single_col bilu_single_col bilng_single_col];
N = 256;
f=[0:10000/N:5000-10000/N];
str = cell(3);
str{1}='i';
str{2}='u';
str{3}='\eta';
window=hanning(N);
window2=hanning(64);
U=sum(window.^2);
U2=sum(window2.^2);
for i = 1:3
    sig = sig_all(1024:1279,i);
    figure(3*(i-1)+1);
    plot(0:N-1,sig);
    title(['256-point Time Series Segment /',char(str(i)),'/']);
    xlabel('n');ylabel('x[n]');
    xlim([0 255]);
    
    figure(3*(i-1)+2);
    X=fftshift(fft(sig.*window));
    X=X(129:256);
    plot(f,10*log10((abs(X).^2)/U/10000));
    xlabel('f (Hz)');ylabel('Power(dB)');title(['Power Spectrum Estimate (256-point) /',char(str(i)),'/']);
    
    figure(3*i);
    X=fftshift(fft(sig(1:64).*window2,N));
    X=X(129:256);
    plot(f,10*log10((abs(X).^2)/U2/10000));
    xlabel('f (Hz)');ylabel('Power(dB)');title(['Power Spectrum Estimate (64-point) /',char(str(i)),'/']);
end;
%% Part II
for i = 1:3
    sig = sig_all(1024:1279,i);
    sig = sig .* window;
    figure(2*(i-1)+10);
    pbin=[2:2:14];
    Ep=[];
    for j=1:size(pbin,2)
        p=pbin(j);
        [a,g] = lpc(sig,p);
        Ep=[Ep g];
    end;
    plot(pbin,Ep);
    xlabel('p');ylabel('Ep');
    title(['Ep vs. p (256 points) /',char(str(i)),'/']);
    xlim([2,14]);
    
    figure(2*(i-1)+11);
    p=14;
    [a,g] = lpc(sig,p);
    A=fftshift(fft(a,N));
    A=A(129:256);
    plot(f,(10*log10(1./(abs(A).^2))));
    xlabel('f (Hz)');ylabel('dB');
    title(['The plot of $10log(\frac{1}{|\hat{A}(k)|^2})$ (256 points) p=14 /$',char(str(i)),'$/'],'Interpreter','latex');
end;

for i = 1:3
    sig = sig_all(1024:1279,i);
    sig = sig(1:64);
    sig = sig .* window2;
    figure(2*(i-1)+16);
    pbin=[2:2:14];
    Ep=[];
    for j=1:size(pbin,2)
        p=pbin(j);
        [a,g] = lpc(sig,p);
        Ep=[Ep g];
    end;
    plot(pbin,Ep);
    xlabel('p');ylabel('Ep');
    title(['Ep vs. p (64 points) /',char(str(i)),'/']);
    xlim([2,14]);
    
    figure(2*(i-1)+17);
    p=14;
    [a,g] = lpc(sig,p);
    A=fftshift(fft(a,N));
    A=A(129:256);
    plot(f,(10*log10(1./(abs(A).^2))));
    xlabel('f (Hz)');ylabel('dB');
    title(['The plot of $10log(\frac{1}{|\hat{A}(k)|^2})$ (64 points) p=14 /$',char(str(i)),'$/'],'Interpreter','latex');
end;