clear;clc;close all;
%% Part A
rng(669);   %% random seed
N=1024;
n=0:N-1;
A1=randn([1,1024]);
A2=A1+sqrt(2)*cos(pi/16*n);
A3=A1+sqrt((10^(0.9))*2)*cos(pi/16*n);
A4_1=randn([1,512]);
A4_2=2*randn([1,512]);
A4=[A4_1 A4_2];
%% Part B1
mean1=mean(A1);
var1=var(A1);
std1=std(A1);
figure(1);
plot(n,A1);axis([0,N-1,-6,6]);
title(['Time Series A1 (estimated mean:',num2str(mean1),' var:',...
    num2str(var1),' std:',num2str(std1),')']); 
xlabel('n');ylabel('A1[n]');

mean2=mean(A2);
var2=var(A2);
std2=std(A2);
figure(2);
plot(n,A2);axis([0,N-1,-6,6]);
title(['Time Series A2 (estimated mean:',num2str(mean2),' var:',...
    num2str(var2),' std:',num2str(std2),')']); 
xlabel('n');ylabel('A2[n]');

mean3=mean(A3);
var3=var(A3);
std3=std(A3);
figure(3);
plot(n,A3);axis([0,N-1,-6,6]);
title(['Time Series A3 (estimated mean:',num2str(mean3),' var:',...
    num2str(var3),' std:',num2str(std3),')']); 
xlabel('n');ylabel('A3[n]');

mean4=mean(A4);
var4=var(A4);
std4=std(A4);
figure(4);
plot(n,A4);axis([0,N-1,-6,6]);
title(['Time Series A4 (estimated mean:',num2str(mean4),' var:',...
    num2str(var4),' std:',num2str(std4),')']); 
xlabel('n');ylabel('A4[n]');
%% Part B2
figure(5);
histfit(A1);
title('A1 histogram with a normal density'); 
xlabel('amplitude');ylabel('count');

figure(6);
histfit(A2);
title('A2 histogram with a normal density'); 
xlabel('amplitude');ylabel('count');

figure(7);
histfit(A3);
title('A3 histogram with a normal density'); 
xlabel('amplitude');ylabel('count');

figure(8);
histfit(A4);
title('A4 histogram with a normal density'); 
xlabel('amplitude');ylabel('count');
%% Part B3
NN=128;
figure(9);
S1 = fftshift(pwelch(A1,128,64,128,1,'twosided','psd'));
plot([-0.5:1/NN:0.5-1/NN],10*log10(S1));
xlabel('f (cycle/sample)');ylabel('Power Spectrum (dB)');
title('Power Spectral Estimate of A1 (dB)','Interpreter','latex');
axis([-0.5,0.5,-5,10]);

figure(10);
S2 = fftshift(pwelch(A2,128,64,128,1,'twosided','psd'));
plot([-0.5:1/NN:0.5-1/NN],10*log10(S2));
xlabel('f (cycle/sample)');ylabel('Power Spectrum (dB)');
title('Power Spectral Estimate of A2 (dB)','Interpreter','latex');

figure(11);
S3 = fftshift(pwelch(A3,128,64,128,1,'twosided','psd'));
plot([-0.5:1/NN:0.5-1/NN],10*log10(S3));
xlabel('f (cycle/sample)');ylabel('Power Spectrum (dB)');
title('Power Spectral Estimate of A3 (dB)','Interpreter','latex');

figure(12);
S4 = fftshift(pwelch(A4,128,64,128,1,'twosided','psd'));
plot([-0.5:1/NN:0.5-1/NN],10*log10(S4));
xlabel('f (cycle/sample)');ylabel('Power Spectrum (dB)');
title('Power Spectral Estimate of A4 (dB)','Interpreter','latex');
axis([-0.5,0.5,-5,10]);
%% C1
f=0:99;
[ ms1 , med1 ] = run_test( A1 );
aa=ms1-med1;
runs1=sum(xor((aa(1:end-1) > 0),(aa(2:end) > 0)));
figure(13);
plot(f,med1*ones(1,size(ms1,2)),':','LineWidth',2);hold on;
plot(f,ms1,'*');title('$\hat{E}_i[x^2(n)]$ in Runs test A1','Interpreter','latex');
legend('median value');
xlabel('i');ylabel('$\hat{E}_i[x^2(n)]$','Interpreter','latex');

[ ms2 , med2 ] = run_test( A2 );
aa=ms2-med2;
runs2=sum(xor((aa(1:end-1) > 0),(aa(2:end) > 0)));
figure(14);
plot(f,med2*ones(1,size(ms2,2)),':','LineWidth',2);hold on;
plot(f,ms2,'*');title('$\hat{E}_i[x^2(n)]$ in Runs test A2','Interpreter','latex');
legend('median value');
xlabel('i');ylabel('$\hat{E}_i[x^2(n)]$','Interpreter','latex');

[ ms3 , med3 ] = run_test( A3 );
aa=ms3-med3;
runs3=sum(xor((aa(1:end-1) > 0),(aa(2:end) > 0)));
figure(15);
plot(f,med3*ones(1,size(ms3,2)),':','LineWidth',2);hold on;
plot(f,ms3,'*');title('$\hat{E}_i[x^2(n)]$ in Runs test A3','Interpreter','latex');
legend('median value');
xlabel('i');ylabel('$\hat{E}_i[x^2(n)]$','Interpreter','latex');

[ ms4 , med4 ] = run_test( A4 );
aa=ms4-med4;
runs4=sum(xor((aa(1:end-1) > 0),(aa(2:end) > 0)));
figure(16);
plot(f,med4*ones(1,size(ms4,2)),':','LineWidth',2);hold on;
plot(f,ms4,'*');title('$\hat{E}_i[x^2(n)]$ in Runs test A4','Interpreter','latex');
legend('median value');
xlabel('i');ylabel('$\hat{E}_i[x^2(n)]$','Interpreter','latex');
%% C2
NC=1000;
k=[0:1/30:1];
interval=norminv(k,0,1);

interval1=interval*std1+mean1;
figure(17);
histogram(A1(1:NC),interval1);
cnt1 = histcounts(A1(1:NC),interval1);
cnt1 = ((cnt1 - 1000/30).^2 )/ (1000/30);
chis1=sum(cnt1);
title('Histogram in Chi-square test for A1');
xlabel('amplitude');ylabel('count');

interval2=interval*std2+mean2;
figure(18);
histogram(A2(1:NC),interval2);
cnt2 = histcounts(A2(1:NC),interval2);
cnt2 = ((cnt2 - 1000/30).^2 )/ (1000/30);
chis2=sum(cnt2);
title('Histogram in Chi-square test for A2');
xlabel('amplitude');ylabel('count');

% %% 4
% interval4=norminv(k,mean4,std4);
% figure(19);
% histogram(A4(1:NC),interval4);
% cnt4 = histcounts(A4(1:NC),interval4);
% cnt4 = ((cnt4 - 1000/30).^2 )/ (1000/30);
% chis4=sum(cnt4);