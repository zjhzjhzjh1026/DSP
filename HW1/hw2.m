figure(1);
n=[1,0,0,0,-0.5,0,0];
x = 0: length(n)-1;
stem(x,n,'filled');axis([0 length(n)-1 -1 1.5]);
xlabel('n');ylabel('X[n]');title('h(n)');

figure(2);
zplane(n);legend('Zero','Pole');
title('Zero and Pole Locations')

figure(3);
f=fft(n,256);
t=0:128;
plot(t/256*2*pi,abs(f(1:129)));
axis([0 pi 0 3]);
xlabel('w (rad/sample)');ylabel('H[e/^{jw}]');title('Magnitude vs. f');

figure(4);
angle=phase(f);
plot(t/256*2*pi,angle(1:129));
axis([0 pi -1 1]);
xlabel('w (rad/sample)');ylabel('Phase');title('Phase vs. f');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%B Part%%%%%%%%%%%%%%%%

%%%1
figure(5);
H=fft(n,64);
t=0:32;
plot(t/64*2*pi,abs(H(1:33)));
axis([0 pi 0 3]);
xlabel('w (rad/sample)');ylabel('|H[e^{jw}]|');title('N=64 Magnitude vs. f of H(k)');

figure(6);
angle=phase(H);
plot(t/64*2*pi,angle(1:33));
axis([0 pi -1 1]);
xlabel('w (rad/sample)');ylabel('Phase');title('N=64 Phase vs. f of H(k)');

figure(7);
H1=1./H;
t=0:32;
plot(t/64*2*pi,abs(H1(1:33)));
axis([0 pi 0 3]);
xlabel('w (rad/sample)');ylabel('|H[e^{jw}]|');title('N=64 Magnitude vs. f of H_{1}(k)');

figure(8);
angle=phase(H1);
plot(t/64*2*pi,angle(1:33));
axis([0 pi -1 1]);
xlabel('w (rad/sample)');ylabel('Phase');title('N=64 Phase vs. f of H_{1}(k)');

%%%2
figure(9);
n1=ifft(H1,64);
x = 0: length(n1)-1;
stem(x,n1,'filled');axis([0 length(n1)-1 -1 1.5]);
xlabel('n');ylabel('X_{1}[n]');title('N=64 h_{1}(n)');

figure(10);
zplane(n1);legend('Zero','Pole');
title('N=64 Zero and Pole Locations of H_{1}(z)')

%%%3
figure(11);
f=fft(n1,256);
t=0:128;
plot(t/256*2*pi,abs(f(1:129)));
axis([0 pi 0 3]);
xlabel('w (rad/sample)');ylabel('|H[e^{jw}]|');title('N=64 Magnitude vs. f of 256NFFT H_{1}(k)');

figure(12);
angle=phase(f);
plot(t/256*2*pi,angle(1:129));
axis([0 pi -1 1]);
xlabel('w (rad/sample)');ylabel('Phase');title('N=64 Phase vs. f of 256NFFT H_{1}(k)');

%%%4
n2=ifft(fft(n,128).*fft(n1,128));
%%%5
figure(13);
x = 0: length(n2)-1;
stem(x,n2,'filled');axis([0 length(n2)-1 -1 1.5]);
xlabel('n');ylabel('X[n]');title('N=64 h_{2}(n)');

figure(14);
zplane(n2(1:65));legend('Zero','Pole');
title('N=64 Zero and Pole Locations of H_{2}(z)')
%%%6
figure(15);
f=fft(n2,256);
t=0:128;
plot(t/256*2*pi,abs(f(1:129)));
axis([0 pi 0 3]);
xlabel('w (rad/sample)');ylabel('|H[e^{jw}]|');title('N=64 Magnitude vs. f of 256NFFT H_{2}(k)');

figure(16);
angle=phase(f);
plot(t/256*2*pi,angle(1:129));
axis([0 pi -1 1]);
xlabel('w (rad/sample)');ylabel('Phase');title('N=64 Phase vs. f of 256NFFT H_{2}(k)');