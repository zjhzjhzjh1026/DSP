function [ ] = NFFT_plot( f , N )

figure;
t=0:N/2;
plot(t/N*2*pi,abs(f(1:N/2+1)));
axis([0 pi 0 3]);
xlabel('w');ylabel('H[e^{jw}]');title('Magnitude vs. f');

figure;
angle=phase(f);
plot(t/N*2*pi,angle(1:N/2+1));
axis([0 pi -1 1]);
xlabel('w');ylabel('Phase');title('Phase vs. f');

end

