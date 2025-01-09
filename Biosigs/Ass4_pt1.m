clc
clear
close all% clear the command windows, workspace and figures

Fs = 2000;% set the sampling frequency
Fn = Fs/2;% set the nyquist
Ws = 100/Fn;Wp = 350/Fn;% calculate the Stop and Pass frequencies
Rp = 1; Rs = 40;% calculate the stop and pass ripples
%Calculate the orders and frequencies of the different filters
[Nb,Wcb]=buttord(Wp,Ws, Rp,Rs) %Butterworth filter
[Nc1,Wcc1]=cheb1ord(Wp,Ws,Rp,Rs) %Chebyshev Type-I
[Nc2,Wcc2]=cheb2ord(Wp,Ws,Rp,Rs) %Chebyshev Type-II
[Ne,Wce]=ellipord(Wp,Ws,Rp,Rs) %Elliptic

