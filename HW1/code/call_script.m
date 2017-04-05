%%%%%%%%%%%%%%Part A%%%%%%%%%%%%%%%%%%%%%%%%
h=[1,0,0,0,-0.5,0,0];
plot_series( h );
F=fft(h,256);
NFFT_plot( F , 256 );

%%%%%%%%%%%%%%Part B%%%%%%%%%%%%%%%%%%%%%%%%
%%%1
N=16;
H=fft(h,N);
NFFT_plot( H , N );

H1=1./H;
NFFT_plot( H1 , N );
%%%2
h1=ifft(H1,N);
plot_series( h1 );
%%%3
F=fft(h1,256);
NFFT_plot( F , 256 );
%%%4
h2=ifft(fft(h,2*N).*fft(h1,2*N));
%%%5
plot_series(h2(1:N+1));
%%%6
F=fft(h2,256);
NFFT_plot( F , 256 );