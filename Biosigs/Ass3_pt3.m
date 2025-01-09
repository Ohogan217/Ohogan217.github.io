clc
close all
clear
%clear all values, plots and command window

%a)
fs = pi; % sampling frequency is pi Hz
Wn = 1/4; % the 1/8 pi is equal to 1/4 of pi/2
Nf = 12; % the order of the FIR filter is 12th
Bf = fir1(Nf, Wn); %Lowpass FIR filter

%b)
Nb = 3; % order of the butterworth filter is 3
[Bb, Ab] = butter(Nb, Wn); %Lowpass Buttereworth filter

%c)
figure
N= 100; % plot the fitler responses for N = 100
[Hf, Wf] = freqz(Bf, 1, N); % freqz for the FIR filter
[Hb, Wb] = freqz(Bb, Ab, N); % freqz for the butterworth filter

angf = angle(Hf); % find phase of Hf
angb = angle(Hb); % find phase of Hb

tiledlayout(2,1)
nexttile% plot the magnitude of Hf and Hb
fdom = (0: 1/100: 1-1/100);
plot(fdom , abs(Hf)) 
title('Response Magnitude of Filter')
xlabel('Normalised Frequency')
ylabel('Amplitude')
hold on 
plot(fdom ,abs(Hb))
legend('FIR', 'Butterworth')

nexttile% plot the phase of Hf and Hb
plot(abs(angf))
title('Phase Response of Filter')
xlabel('Normalised Frequency')
ylabel('Amplitude')
hold on 
plot(abs(angb))
legend('FIR', 'Butterworth')
