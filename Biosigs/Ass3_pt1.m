clc
close all
clear
%clear all values, plots and command window

%a)
a = [1 .125 -1/2]; %observe a's from equation
b = [0, 2, 3]; % observe b's from equation

[z, p, k] = tf2zpk(b, a); %poles and zeros of system

zplane(z,p) %plot poles and zeros of system
title('Z-Plane')
%b)

%c)
x = rand(1000,1); % generate random vector x
xf = filtfilt(b, a, x); % filt x with filter

figure 
tiledlayout(2,1)

nexttile% plot amplitude of unfiltered x
plot(x)
title('X( Unfiltered)')
xlabel('time')
ylabel('Amplitude')
nexttile%plot amplitude of filtered x
plot(xf, 'r')
title('X (Filtered)')
xlabel('time')
ylabel('Amplitude')

fdom = (0: 1/1000: 1-1/1000);% create frequency domain for x
fxf = abs(fft(xf)); % fourrier transform of filtered x
fxf = (fftshift(fxf)); % find phase of filtered x
fx = abs(fft(x)); % fourrier transform of x
fx = fftshift(fx);% find phase of x
figure
tiledlayout(2,1)
nexttile
plot(fdom, fx);
title('X')
xlabel('Frequency')
ylabel('Amplitude')
nexttile
plot(fdom, fxf)
title('X (Filtered)')
xlabel('Frequency')
ylabel('Amplitude')