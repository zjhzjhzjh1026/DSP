close all;clc;clear;
%% IA
f1=160;f2=237;f3=240;
A_1=100;A_2=10;A_3=1;
N=4096;
fs=1000;
n=0:N-1;
xn=A_1*cos(2*pi*f1*n/fs)+A_2*cos(2*pi*f2*n/fs)+A_3*cos(2*pi*f3*n/fs);
