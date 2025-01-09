clear
clc
close all% clear the command windows, workspace and figures
load("G:\My Drive\engineering_work\Biosigs\Lab 4\NoisyECG.mat")%Load the ECG file

Fs = 500;% sampling frequency
Fn = Fs/2;%Nyquist Frequency
Ampf = 500; % the amplification factor
Ecg = (ecg/500)*1000;% Find the original ecg signal in mV
len = length(ecg); % number of samples
%a)
tiledlayout(3,2)% Tiled Layout
nexttile 
plot(Ecg) %plot original signal
xticks([]) % remove 'x' numbers, as they will be just on the bottom graphs
ylabel('Amplitude (mV)')% y labels
title('ECG Signal') % title

ecgf = abs(fft(Ecg));
ecgf = fftshift(ecgf);% fourrier transform of the signal
f = (-len/2:(len-1)/2)*Fs/len; %frequency range of the signal

nexttile
plot(f, ecgf)%plot the frequency domain of the signal
xticks([])
ylabel('Magnitude (dB)')
title('ECG Signal')
xlim([0, Fs/2])
%b)
Fc = 50;% choose frequency of notch
wo = Fc/Fn; % calcualte the adjusted frequency
bw = wo/30; % calculate bw
[b,a] = iirnotch(wo,bw); % get constants, 'a' and 'b'
ecg2 = filtfilt(b, a, Ecg); % Filter ecg
ecg2f = abs(fft(ecg2)); %get the frequencies of filtered ecg
ecg2f = fftshift(ecg2f);
nexttile
plot(ecg2)% plot filtered ecg in time and frequency domain
xticks([])
ylabel('Amplitude(mV)')
title('Filtered ECG Signal')
nexttile
plot(f, ecg2f)
xticks([])
ylabel('Magnitude (dB)')
xlim([0, Fs/2])
title('Filtered ECG Signal')
%c)
n = 5; % set order of butterworth filter
Fc = [2, 10]; % set pass band frequencies
Wn = Fc/Fn; % get the normalised pass band frequencies
[b,a]=butter(n,Wn); % filter constants
ecg3 = filtfilt(b, a, ecg2); % filter
nexttile
plot(ecg3) % plot final filtered signal in time and frequency domains
xlabel('Samples (1 Sample = 1/1000s)') 
ylabel('Amplitude (mV)')
title('Filtered ECG Signal')
nexttile
ecg3f = abs(fft(ecg3));
ecg3f = fftshift(ecg3f);
plot(f, ecg3f)
xlabel('Frequency (Hz)') 
ylabel('Magnitude (dB)')
title('Filtered ECG Signal')
xlim([0, Fs/2])