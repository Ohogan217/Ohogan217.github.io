clc
close all
clear
%clear all values, plots and command window

%a)
N=100; % N = 100 for filter
A = [1, -.2, 0,  .1]; % define A according to transfer function
B = [1, .1, -.3]; % define B according to transfer function
[z, p, k] = tf2zpk(B, A); % find zeros and poles of transfer function
figure% plot the filters and poles of this function
zplane(z,p)
title('Z-Plane')

%b)
figure
freqz(B, A, N);% plot the magnitude of hte filter response for the transfer function
title('Magnitude of Filter Response')
%c)

%d)
x = rand(1000,1);% random 1000 long signal
figure
tiledlayout(2,1)
nexttile% plot x
plot(x)
title('X signal')
xlabel('Samples')
ylabel('Amplitude')
nexttile % filter x and plot the filtered version
xf = filtfilt(B,A,x);
plot(xf)
title('Filtered X signal')
xlabel('Samples')
ylabel('Amplitude')

figure
tiledlayout(2,1)
nexttile
fdom = (0: 1/1000: 1-1/1000);% frequency domain array created
fxf = abs(fft(xf)); % fourrier transform of filtered x
fxf = (fftshift(fxf)); % phase shift of fft(filtered x)
fx = abs(fft(x)); % fourrier transform of x
fx = fftshift(fx);% phase shift of fft(x)
plot(fdom, fx); % plot phase shifted fft(x)
title('Filtered X signal')
xlabel('Frequencies')
ylabel('Amplitude')
nexttile
plot(fdom, fxf)% plot phase shifted fft(filtered x)
title('Filtered X signal')
xlabel('Frequencies')
ylabel('Amplitude')