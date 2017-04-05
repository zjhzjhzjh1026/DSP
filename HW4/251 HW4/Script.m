clear;close all;clc;

f=0.125;
N=1024;
n=0:N-1;
y=sqrt(2)*cos(2*pi*f*n);   %%sqrt
%plot([-0.5:1/1024:0.5-1/1024],abs(fftshift(fft(y,1024)))); title('Pure Signal Magnitude'); xlabel('f (cycle/sample)');ylabel('magnitude (dB)'); 
rd=randn([1,N]);
sig_o=y+rd; 

%% Prob.A
figure(1);
NN=128;
plot(0:NN-1,sig_o(1:NN));
axis([0,NN-1,-5,5]);title('N=128 Time Series '); xlabel('n');ylabel('x[n]');

%% Prob. B
NFFT_bin=[128,256,512,1024];
for k=1:4
    NFFT=NFFT_bin(k);
    window=hamming(NFFT)';       %% window should be designed by number NFFT
    wn=sig_o(1:NFFT).*window;
    U=sum(window.^2);
    Pxx=10*log10(abs(fftshift(fft(wn)).^2)/U);    %%/NFFT??
    Noise_mean=mean(Pxx);
    figure(k+1);
    f=[-0.5:1/NFFT:0.5-1/NFFT];
    plot(f,Pxx);
    xlabel('f (cycle/sample)');ylabel('Power(dB)');title(['Power Spectrum Estimate N='  num2str(NFFT)]);   %%ylabel?
%     hold on;plot(f,Noise_mean*ones(1,size(f,2)),'r');grid on;
end;

%% Prob. C
    M=128;
    step=[128,64,32];
    num=[8,15,29];
    str=[0,50,75];
    window=hamming(M)';
    U=sum(window.^2);
    for i=1:3
        sum_1=zeros(1,128);
        start=1;
        for j=1:num(i)
            wn=sig_o(start:start+M-1).*window;
            Pxx=10*log10(abs(fftshift(fft(wn)).^2)/U);
            sum_1 = sum_1 + Pxx;
            start = start + step(i);
        end;
        avg = sum_1 / num(i);
        cov(avg)    %%COV
        figure(2*i+4);
        f=[-0.5:1/M:0.5-1/M];
        plot(f,avg);
        xlabel('f (cycle/sample)');ylabel('Power(dB)');title([num2str(str(i)) '% Overlap Power Spectrum Estimate K='  num2str(num(i))]);   %%ylabel?
        
        figure(2*i+5);
        plot(f,avg);
        xlabel('f (cycle/sample)');ylabel('Power(dB)');title([num2str(str(i)) '% Overlap Power Spectrum Estimate K='  num2str(num(i))]);
        axis([-0.5 0.5 -8 2]);
    end;

 %% Prob. D
    M=128;
    num=8;
    window=hamming(M)';
    U=sum(window.^2);
    sum_2=zeros(1,128);
    start=1;
    for j=1:8
        sum_2 = sum_2 + sig_o(start : start + M - 1);
        start = start + M;
    end;
    avg = sum_2 / num;
    figure(12);
    plot(0:M-1,avg);
    axis([0,M-1,-5,5]);title('Averaged Time Series'); xlabel('n');ylabel('x[n]');
    
    figure(13);
    wn=avg.*window;
    Pxx=10*log10(abs(fftshift(fft(wn)).^2)/U);
    f=[-0.5:1/M:0.5-1/M];
    plot(f,Pxx);
    xlabel('f (cycle/sample)');ylabel('Power(dB)');title('Averaged time series power spectrum estimate');
    
    figure(14);
    M=128;
    num=8;
    window=hamming(M)';
    U=sum(window.^2);
    sum_2=zeros(1,128);
    start=1;
    for j=1:8
        wn=sig_o(start:start+M-1).*window;
        sum_2 = sum_2 + fftshift(fft(wn));
        start = start + M;
    end;
    avg=sum_2/num;
    Pxx=10*log10((abs(avg).^2)/U);
    f=[-0.5:1/M:0.5-1/M];
    plot(f,Pxx);
    xlabel('f (cycle/sample)');ylabel('Power(dB)');title('The power spectrum estimate (dB) of the coherently averaged FFT');